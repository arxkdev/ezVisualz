local RunService = game:GetService("RunService");

local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number, customColor: ColorSequence | Color3?, customTransparency: NumberSequence | number?, useScaledSize: boolean?)
    local mainGradient = TextEffects.Gradient.new(uiInstance, TextEffects.Templates.Galaxy.Color, 0);
    mainGradient:SetRotation(90, 1);
    mainGradient:SetOffsetSpeed(speed * 0.5, 1);

    local mainStroke = TextEffects.Stroke.new(uiInstance, size, nil, nil, useScaledSize);
    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, TextEffects.Templates.Galaxy.Color, 0);
    strokeGradient:SetRotation(-90, 1);
    strokeGradient:SetOffsetSpeed(-speed * 0.3, 1);

    local Rotation = 0;
    local Connection;
    Connection = RunService.Heartbeat:Connect(function(dt)
        if (not mainGradient.Instance or mainGradient.Instance.Parent == nil) then
            Connection:Disconnect();
            return;
        end;
        Rotation = Rotation + speed * dt * 15;
        mainGradient:SetRotation(Rotation, 0.15);
        strokeGradient:SetRotation(-Rotation, 0.15);
    end);

    return {
        Effects = { mainGradient, strokeGradient, mainStroke },
        Connections = { Connection }
    };
end
