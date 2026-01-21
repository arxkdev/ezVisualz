local RunService = game:GetService("RunService");

local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number, customColor: ColorSequence | Color3?, customTransparency: NumberSequence | number?, useScaledSize: boolean?)
    local mainGradient = TextEffects.Gradient.new(uiInstance, TextEffects.Templates.Sunset.Color, 0);
    mainGradient:SetRotation(-60, 1);
    mainGradient:SetOffsetSpeed(speed * 0.8, 1);

    local mainStroke = TextEffects.Stroke.new(uiInstance, size, nil, nil, useScaledSize);
    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, TextEffects.Templates.Sunset.Color, 0);
    strokeGradient:SetRotation(60, 1);
    strokeGradient:SetOffsetSpeed(-speed * 0.6, 1);

    local Rotation = 0;
    local Connection;
    Connection = RunService.Heartbeat:Connect(function(dt)
        if (not mainGradient.Instance or mainGradient.Instance.Parent == nil) then
            Connection:Disconnect();
            return;
        end;
        Rotation = Rotation + speed * dt * 20;
        mainGradient:SetRotation(-60 + math.sin(Rotation * 0.1) * 20, 0.2);
        strokeGradient:SetRotation(60 - math.sin(Rotation * 0.1) * 20, 0.2);
    end);

    return {
        Effects = { mainGradient, strokeGradient, mainStroke },
        Connections = { Connection }
    };
end
