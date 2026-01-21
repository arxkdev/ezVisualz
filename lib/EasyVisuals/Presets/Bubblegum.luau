local RunService = game:GetService("RunService");

local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number, customColor: ColorSequence | Color3?, customTransparency: NumberSequence | number?, useScaledSize: boolean?)
    local mainGradient = TextEffects.Gradient.new(uiInstance, TextEffects.Templates.Bubblegum.Color, 0);
    mainGradient:SetRotation(-90, 1);
    mainGradient:SetOffsetSpeed(speed, 1);

    local mainStroke = TextEffects.Stroke.new(uiInstance, size, nil, nil, useScaledSize);
    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, TextEffects.Templates.Bubblegum.Color, 0);
    strokeGradient:SetRotation(-45, 1);
	strokeGradient:SetOffsetSpeed(speed * 0.9, 1);

	local variationPercent = 0.25;
	local minMultiplier = 0.5;
	local maxMultiplier = 3 + variationPercent;

	local Connection;
	Connection = RunService.Heartbeat:Connect(function()
		if (not mainStroke.Instance or mainStroke.Instance.Parent == nil) then
			Connection:Disconnect();
			return;
		end;

		local t = tick() * speed;
		local normalizedWave = (math.sin(t) + 1) / 2;
		local sizeMultiplier = minMultiplier + (maxMultiplier - minMultiplier) * normalizedWave;
		mainStroke:SetSize(size * sizeMultiplier, 0.15);
	end);

	return {
		Effects = { mainGradient, strokeGradient, mainStroke },
		Connections = { Connection }
	};
end