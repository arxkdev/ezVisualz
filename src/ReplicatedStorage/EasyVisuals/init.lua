local Presets = script.Presets;

export type Effect<T...> = {
	UIInstance: GuiObject,
	EffectObjects: { Instance },
	SavedObjects: { Instance },
	Speed: number,
	Size: number,

	Destroy: (self: Effect<T...>) -> nil,
};

local Effect = {};
Effect.Gradient = require(script.Gradient);
Effect.Stroke = require(script.Stroke);
Effect.Dropshadow = require(script.Dropshadow);
Effect.Templates = require(script.GradientTemplates);

Effect.__index = Effect;

local function ValidateIsPreset(presetName: string): boolean
	return Presets:FindFirstChild(presetName) ~= nil;
end

function Effect.new<T...>(uiInstance: GuiObject, effectType: string, speed: number?, size: number?, ignoreSavingObjects: boolean?, customColor: ColorSequence | Color3?, customTransparency: NumberSequence | number?): Effect<T...>
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

	local self = {};

	self.Diagnostic = "DIAGNOSTIC VALUE";
	self.UIInstance = uiInstance;
	self.EffectObjects = {};
	self.SavedObjects = {};
	self.Speed = speed or 0.007;
	self.Size = size or 1;

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

	for _, v in Objects do
		table.insert(self.EffectObjects, v);
	end;

	self.Connection = uiInstance.AncestryChanged:Connect(function()
		if (not uiInstance:IsDescendantOf(game)) then
			self:Destroy();
		end;
	end);

	return setmetatable(self, Effect);
end

function Effect:Destroy()
	for _, Object in self.SavedObjects do
		Object.Parent = self.UIInstance;
	end;

	table.clear(self.SavedObjects)

	for _, Object in self.EffectObjects do
		if (not Object.Destroy) then
			continue;
		end;
		Object:Destroy();
	end;

	self.Connection:Disconnect();
	self = nil;
end

return table.freeze(Effect);
