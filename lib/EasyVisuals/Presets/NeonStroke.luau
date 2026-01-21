local RunService = game:GetService("RunService");

local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainGradient = TextEffects.Gradient.new(uiInstance, TextEffects.Templates.Neon.Color, 0);
    mainGradient:SetRotation(45, 1);
    mainGradient:SetOffsetSpeed(speed, 1);

    local mainStroke = TextEffects.Stroke.new(uiInstance, size);
    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, TextEffects.Templates.Neon.Color, 0);
    strokeGradient:SetRotation(-45, 1);
    strokeGradient:SetOffsetSpeed(-speed * 0.7, 1);

    local Rotation = 0;
    local Connection;
    Connection = RunService.Heartbeat:Connect(function(dt)
        if (not mainGradient.Instance or mainGradient.Instance.Parent == nil) then
            Connection:Disconnect();
            return;
        end;
        Rotation = Rotation + speed * dt * 30;
        mainGradient:SetRotation(Rotation, 0.1);
    end);

    return {
        Effects = { mainGradient, strokeGradient, mainStroke },
        Connections = { Connection }
    };
end
