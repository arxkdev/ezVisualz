local DefaultPresets = script.Presets;
local DefaultTemplates = script.GradientTemplates;

-- Imports
local SmartAssert = require(script.Util);

export type Effect<T...> = {
	UIInstance: GuiObject,
	EffectObjects: { Instance },
	SavedObjects: { Instance },
	Speed: number,
	Size: number,
	IsPaused: boolean,

	Pause: (self: Effect<T...>) -> nil,
	Resume: (self: Effect<T...>) -> nil,
	Destroy: (self: Effect<T...>) -> nil,
};

local Effect = {};
Effect.Gradient = require(script.Gradient);
Effect.Stroke = require(script.Stroke);
Effect.Dropshadow = require(script.Dropshadow);

Effect.__index = Effect;
Effect.CurrentEffects = {};

local CustomPresetsFolder: Folder? = nil;
local CustomTemplatesFolder: Folder? = nil;

-- Cached merged presets and templates
local MergedPresets: { [string]: ModuleScript }? = nil;
local MergedTemplates: { [string]: UIGradient }? = nil;

local VisibleOrEnabledChart = {
	["GuiObject"] = "Visible",
	["ScreenGui"] = "Enabled",
	["BillboardGui"] = "Enabled",
	["SurfaceGui"] = "Enabled",
};

local function _loadPresetsFromFolder(folder: Folder): { [string]: ModuleScript }
	local presets = {};
	for _, module in folder:GetDescendants() do
		if module:IsA("ModuleScript") then
			presets[module.Name] = module;
		end;
	end;
	return presets;
end

local function _loadTemplatesFromFolder(folder: Folder): { [string]: UIGradient }
	local templates = {};
	for _, module in folder:GetDescendants() do
		if module:IsA("ModuleScript") then
			local templateFunction = require(module);
			if typeof(templateFunction) == "function" then
				templates[module.Name] = templateFunction();
			end;
		end;
	end;
	return templates;
end

local function _getMergedPresets(): { [string]: ModuleScript }
	if MergedPresets then
		return MergedPresets;
	end;

	local merged = {};

	-- Load default presets first
	for name, module in pairs(_loadPresetsFromFolder(DefaultPresets)) do
		merged[name] = module;
	end;

	-- Override with custom presets if they exist
	if CustomPresetsFolder then
		for name, module in pairs(_loadPresetsFromFolder(CustomPresetsFolder)) do
			merged[name] = module;
		end;
	end;

	MergedPresets = merged;
	return merged;
end

local function _getMergedTemplates(): { [string]: UIGradient }
	if MergedTemplates then
		return MergedTemplates;
	end;

	local merged = {};

	-- Load default templates first
	for name, template in pairs(_loadTemplatesFromFolder(DefaultTemplates)) do
		merged[name] = template;
	end;

	-- Override with custom templates if they exist
	if CustomTemplatesFolder then
		for name, template in pairs(_loadTemplatesFromFolder(CustomTemplatesFolder)) do
			merged[name] = template;
		end;
	end;

	MergedTemplates = merged;
	return merged;
end

local function _findPreset(presetName: string): ModuleScript?
	local presets = _getMergedPresets();
	return presets[presetName];
end

local function ValidateIsPreset(presetName: string): boolean
	return _findPreset(presetName) ~= nil;
end

--[[
	Function to set custom folders for presets and templates.
	This allows users to add their own presets/templates without forking the module.

	Custom presets/templates will override default ones with the same name.

	Example usage:
		local EasyVisuals = require(path.to.EasyVisuals)

		-- Create custom folders in your game
		local CustomPresets = Instance.new("Folder")
		CustomPresets.Name = "CustomPresets"
		CustomPresets.Parent = workspace -- or wherever you want

		local CustomTemplates = Instance.new("Folder")
		CustomTemplates.Name = "CustomTemplates"
		CustomTemplates.Parent = workspace

		-- Add your custom preset modules to CustomPresets folder
		-- Add your custom template modules to CustomTemplates folder

		-- Hook up the custom folders
		EasyVisuals.SetCustomFolders(CustomPresets, CustomTemplates)

		-- Now you can use your custom presets!
		local effect = EasyVisuals.new(textLabel, "MyCustomPreset", 0.5, 3)

	@param customPresets Folder? - Optional folder containing custom preset ModuleScripts
	@param customTemplates Folder? - Optional folder containing custom template ModuleScripts
]]
function Effect.SetCustomFolders(customPresets: Folder?, customTemplates: Folder?)
	if customPresets then
		SmartAssert(customPresets:IsA("Folder"), "customPresets must be a Folder");
	end;
	if customTemplates then
		SmartAssert(customTemplates:IsA("Folder"), "customTemplates must be a Folder");
	end;

	CustomPresetsFolder = customPresets;
	CustomTemplatesFolder = customTemplates;

	-- Clear cache to force reload
	MergedPresets = nil;
	MergedTemplates = nil;

	-- Reload templates in the Effect module
	Effect.Templates = _getMergedTemplates();
end

-- Initialize templates
Effect.Templates = _getMergedTemplates();

function Effect.new<T...>(uiInstance: GuiObject, effectType: string, speed: number?, size: number?, saveInstanceObjects: boolean?, customColor: ColorSequence | Color3?, customTransparency: NumberSequence | number?, resumesOnVisible: boolean?, useScaledSize: boolean?): Effect<T...>
	SmartAssert(uiInstance ~= nil, "UIInstance not provided");
	SmartAssert(effectType ~= nil, "EffectType not provided");
	SmartAssert(uiInstance:IsA("GuiObject"), "UIInstance is not a GuiObject");
	SmartAssert(typeof(effectType) == "string", "effectType is not a string");
	SmartAssert(ValidateIsPreset(effectType), "effectType is not a valid preset");
	if (speed) then
		SmartAssert(typeof(speed) == "number", "speed is not a number");
	end;
	if (size) then
		SmartAssert(typeof(size) == "number", "size is not a number");
	end;
	if (customColor) then
		SmartAssert(typeof(customColor) == "ColorSequence" or typeof(customColor) == "Color3", "customColor is not a ColorSequence or Color3");
	end;
	if (customTransparency) then
		SmartAssert(typeof(customTransparency) == "NumberSequence" or typeof(customTransparency) == "number", "customTransparency is not a NumberSequence or number");
	end;
	if (useScaledSize ~= nil) then
		SmartAssert(typeof(useScaledSize) == "boolean", "useScaledSize is not a boolean");
	end;

	local self = {};

	self.IsPaused = false;
	self.Diagnostic = "DIAGNOSTIC VALUE";
	self.UIInstance = uiInstance;
	self.ResumesOnShown = resumesOnVisible == nil and true or resumesOnVisible;
	self.EffectObjects = {};
	self.SavedObjects = {};
	self.Connections = {};
	self.Speed = speed or 0.007;
	self.Size = size or 1;

	-- Climb up the parent tree of the UIInstance and attach GetPropertyChangedSignal to the Visible property of each object
	-- If the Visible property changes to false, destroy the effect
	local function RecursiveAncestryChanged(Object: Instance)
		if (not Object) then
			return;
		end;

		-- If the object is a PlayerGui or Workspace, stop climbing
		if (Object:IsA("PlayerGui") or Object:IsA("Workspace")) then
			return;
		end;

		-- If the object is a ScreenGui, BillboardGui, or SurfaceGui, check if it's enabled
		local IsVisibleOrEnabled = VisibleOrEnabledChart[Object.ClassName];
		if (not IsVisibleOrEnabled) then
			RecursiveAncestryChanged(Object.Parent);
			return;
		end;

		table.insert(self.Connections, Object:GetPropertyChangedSignal(IsVisibleOrEnabled):Connect(function()
			self.IsPaused = not Object[IsVisibleOrEnabled];
			if (self.IsPaused) then
				self:Pause();
			else
				if (self.ResumesOnShown) then
					self:Resume();
				end;
			end;
		end));

		RecursiveAncestryChanged(Object.Parent);
	end;
	RecursiveAncestryChanged(uiInstance);

	if (saveInstanceObjects) then
		for _, Object in uiInstance:GetChildren() do
			if (Object:IsA("UIStroke") or Object:IsA("UIGradient")) then
				table.insert(self.SavedObjects, Object);
				Object.Parent = nil;
			end;
		end;
	end;

	local PresetModule = _findPreset(effectType);
	SmartAssert(PresetModule ~= nil, "Preset '" .. effectType .. "' not found");
	local Preset = require(PresetModule);
	local Objects = Preset(uiInstance, self.Speed, self.Size, customColor, customTransparency, useScaledSize);

	if (Objects["Connections"]) then
		for _, Connection in Objects["Connections"] do
			table.insert(self.Connections, Connection);
		end;
	end;
	if (Objects["Effects"]) then
		for _, ObjectEffect in Objects["Effects"] do
			table.insert(self.EffectObjects, ObjectEffect);
		end;
	end;

	self.Connection = uiInstance.AncestryChanged:Connect(function()
		if (not uiInstance:IsDescendantOf(game)) then
			self:Destroy();
		end;
	end);

	return setmetatable(self, Effect);
end

function Effect:Pause()
	-- print("Effect paused");
	for _, Object in self.EffectObjects do
		if (Object.Pause) then
			Object:Pause();
		end;
	end;
end

function Effect:Resume()
	-- print("Effect resumed");
	for _, Object in self.EffectObjects do
		if (Object.Resume) then
			Object:Resume();
		end;
	end;
end

function Effect:Destroy()
	for _, Object in self.SavedObjects do
		Object.Parent = self.UIInstance;
	end;
	for _, Connection in self.Connections do
		Connection:Disconnect();
	end;

	table.clear(self.SavedObjects);
	table.clear(self.Connections);

	for _, Object in self.EffectObjects do
		if (not Object.Destroy) then
			continue;
		end;
		Object:Destroy();
	end;

	self.Connection:Disconnect();
end

return table.freeze(Effect);
