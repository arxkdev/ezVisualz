local Presets = script.Presets;

export type Effect<T...> = {
	UIInstance: GuiObject,
	EffectObjects: { Instance },
	SavedObjects: { Instance },
	Speed: number,
	Size: number,
	IsPaused: boolean,

	Pause: () -> nil,
	Resume: () -> nil,
	Destroy: (self: Effect<T...>) -> nil,
};

local Effect = {};
Effect.Gradient = require(script.Gradient);
Effect.Stroke = require(script.Stroke);
Effect.Dropshadow = require(script.Dropshadow);
Effect.Templates = require(script.GradientTemplates);

Effect.__index = Effect;
Effect.CurrentEffects = {};

local VisibleOrEnabledChart = {
	["GuiObject"] = "Visible",
	["ScreenGui"] = "Enabled",
	["BillboardGui"] = "Enabled",
	["SurfaceGui"] = "Enabled",
};

local function ValidateIsPreset(presetName: string): boolean
	return Presets:FindFirstChild(presetName) ~= nil;
end

function Effect.new<T...>(uiInstance: GuiObject, effectType: string, speed: number?, size: number?, ignoreSavingObjects: boolean?, customColor: ColorSequence | Color3?, customTransparency: NumberSequence | number?, resumesOnVisible: boolean?): Effect<T...>
	assert(uiInstance, "UIInstance not provided");
	assert(effectType, "EffectType not provided");
	assert(uiInstance:IsA("GuiObject"), "UIInstance is not a GuiObject");
	assert(typeof(effectType) == "string", "effectType is not a string");
	assert(ValidateIsPreset(effectType), "effectType is not a valid preset");
	if (speed) then
		assert(typeof(speed) == "number", "speed is not a number");
	end;
	if (size) then
		assert(typeof(size) == "number", "size is not a number");
	end;
	if (customColor) then
		assert(typeof(customColor) == "ColorSequence" or typeof(customColor) == "Color3", "customColor is not a ColorSequence or Color3");
	end;
	if (customTransparency) then
		assert(typeof(customTransparency) == "NumberSequence" or typeof(customTransparency) == "number", "customTransparency is not a NumberSequence or number");
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

	if (not ignoreSavingObjects) then
		for _, Object in uiInstance:GetChildren() do
			if (Object:IsA("UIStroke") or Object:IsA("UIGradient")) then
				table.insert(self.SavedObjects, Object);
				Object.Parent = nil;
			end;
		end;
	end;

	local Preset = require(Presets:FindFirstChild(effectType));
	local Objects = Preset(uiInstance, self.Speed, self.Size, customColor, customTransparency);

	if Objects["Connections"] and Objects["Effects"] then
		local ObjectEffects = Objects.Effects;
		local ObjectConnections = Objects.Connections;
		for _, v in ObjectEffects do
			table.insert(self.EffectObjects, v);
		end;
		for _, v in ObjectConnections do
			table.insert(self.Connections, v);
		end;
	else
		for _, v in Objects do
			table.insert(self.Connections, v);
		end;
	end

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
