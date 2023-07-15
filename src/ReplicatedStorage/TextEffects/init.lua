local Presets = script.Presets;

local Effect = {};
Effect.__index = Effect;

local function ValidateIsPreset(presetName: string): boolean
	return Presets:FindFirstChild(presetName) ~= nil
end

function Effect.new(uiInstance: GuiObject, effectType: string, speed: number?, size: number?): typeof(Effect.new(nil, "", 0, 0))
	assert(uiInstance, "UIInstance not provided");
	assert(effectType, "EffectType not provided");
	assert(ValidateIsPreset(effectType), "effectType is not a valid preset");

	local self = {};

	self.Diagnostic = "DIAGNOSTIC VALUE";
	self.UIInstance = uiInstance;
	self.EffectObjects = {};
	self.SavedObjects = {};
	self.Speed = speed or 0.007;
	self.Size = size or 1;

	-- Save all objects that are UIGradient or UIStroke
	for _, Object in uiInstance:GetChildren() do
		if (Object:IsA("UIStroke") or Object:IsA("UIGradient")) then
			table.insert(self.SavedObjects, Object);
			Object.Parent = nil
		end;
	end;

	local Preset = require(Presets:FindFirstChild(effectType));
	local Objects = Preset(uiInstance, self.Speed, self.Size);

	for _, v in Objects do
		table.insert(self.EffectObjects, v);
	end;

	return setmetatable(self, Effect);
end

function Effect:Destroy()
	-- Add the saved objects back
	for Index, Object in self.SavedObjects do
		Object.Parent = self.UIInstance;
	end;

	table.clear(self.SavedObjects)

	for _, Object in self.EffectObjects do
		if (not Object.Destroy) then
			continue;
		end;
		Object:Destroy();
	end;

	self = nil;
end

return table.freeze(Effect);