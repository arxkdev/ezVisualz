local Presets = script.Presets;

local Effect = {};
local EffectMetatable = {__index = Effect};

local function ValidateIsPreset(effectType: string): boolean
	for _, Preset in pairs(Presets:GetChildren()) do
		if (Preset.Name == effectType) then
			return true;
		end;
	end;
	return false;
end

function Effect.new(UIInstance: GuiObject, effectType: string, speed: number?, size: number?): typeof(Effect.new(nil, "", 0, 0))
	assert(UIInstance, "UIInstance not provided");
	assert(effectType, "effectType not provided");
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

	for _, v in pairs(Objects) do
		table.insert(self.EffectObjects, v);
	end;

	return self;
end

function Effect:Destroy()
	if (self.EffectObjects) then
		for _, v in pairs(self.EffectObjects) do
			if (not v.Destroy) then
				continue;
			end;
			v:Destroy();
		end;
	end;

	self = nil;
end

return Effect;