local RunService = game:GetService("RunService");

local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainStroke = TextEffects.Stroke.new(uiInstance, size);
    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, TextEffects.Templates.Rainbow.Color, 0);
    local Rotation = 5;

	local Connection
	Connection = RunService.Heartbeat:Connect(function(dt)
		if (not mainStroke.Instance or mainStroke.Instance.Parent == nil) then
			Connection:Disconnect();
		end;
		Rotation = Rotation + speed * dt;
		strokeGradient:SetRotation(Rotation, 1);
	end);

	return {
		Effects = { strokeGradient, mainStroke },
		Connections = { Connection }
	};
end