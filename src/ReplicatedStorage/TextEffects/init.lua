local Presets = script.Presets;

local Effect = {};
local EffectMetatable = {__index = Effect};

local function ValidateIsPreset(effectType: string): boolean
	for _, Preset in pairs(Presets) do
		if (Preset.Name == effectType) then
			return true;
		end;
	end;
	return false;
end

function Effect.new(UIInstance: GuiObject, effectType: string, speed: number?, size: number?): typeof(Effect.new)
	assert(UIInstance, "UIInstance is nil");
	assert(effectType, "effectType is nil");
	assert(ValidateIsPreset(effectType), "effectType is not a valid preset");

	local self = {};

	self.Diagnostic = "DIAGNOSTIC VALUE";
	self.UIInstance = UIInstance;
	self.EffectObjects = {};
	self.Speed = speed or 0.007;
	self.Size = size or 1;

	setmetatable(self, EffectMetatable);
	local Preset = require(Presets:FindFirstChild(effectType));
	local Objects = Preset(UIInstance, self.Speed, self.Size);
	print(Objects)

	for _, v in pairs(Objects) do
		table.insert(self.EffectObjects, v);
	end;

	return self;
end

function Effect:Destroy()
	if (self.EffectObjects) then
		for _, v in pairs(self.EffectObjects) do
			if (v) then
				v:Destroy();
			end;
		end;
	end;

	self = nil;
end

return Effect;