local RunService = game:GetService("RunService");

local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainGradient = TextEffects.Gradient.new(uiInstance, TextEffects.Templates.Bubblegum.Color, 0);
    mainGradient:SetRotation(-90, 1);
    mainGradient:SetOffsetSpeed(speed, 1);

    local mainStroke = TextEffects.Stroke.new(uiInstance, size);
    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, TextEffects.Templates.Bubblegum.Color, 0);
    strokeGradient:SetRotation(-45, 1);
	strokeGradient:SetOffsetSpeed(speed * 0.9, 1);

	local Scale = size * 3;
	local Connection;
	Connection = RunService.Heartbeat:Connect(function()
		if (not mainStroke.Instance or mainStroke.Instance.Parent == nil) then
			Connection:Disconnect();
			return;
		end;

		local t = tick() * speed;
		local sizeMultiplier = 1 + Scale * math.sin(t);
		mainStroke:SetSize(size * sizeMultiplier, 0.055);
	end);

	return {
		Effects = { mainGradient, strokeGradient, mainStroke },
		Connections = { Connection }
	};
end