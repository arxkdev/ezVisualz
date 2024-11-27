local RunService = game:GetService("RunService");

local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainGradient = TextEffects.Gradient.new(uiInstance, TextEffects.Templates.Fire.Color, 0);
    mainGradient:SetRotation(-75, 1);
    mainGradient:SetOffsetSpeed(speed, 1);

    local Rotation = 0;
	local Connection
	Connection = RunService.Heartbeat:Connect(function(dt)
		if (not mainGradient.Instance or mainGradient.Instance.Parent == nil) then
			Connection:Disconnect();
		end;
		Rotation = Rotation + speed * dt;
		mainGradient:SetRotation(Rotation, 1);
	end);

    local mainStroke = TextEffects.Stroke.new(uiInstance, size);
    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, TextEffects.Templates.Fire.Color, 0);
    strokeGradient:SetRotation(75, 1);
    strokeGradient:SetOffsetSpeed(-speed, 1);

	return {
		Effects = { mainGradient, strokeGradient, mainStroke },
		Connections = { Connection }
	};
end