local RunService = game:GetService("RunService");

local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number, customColor: ColorSequence | Color3?, customTransparency: NumberSequence | number?, useScaledSize: boolean?)
    local mainGradient = TextEffects.Gradient.new(uiInstance, TextEffects.Templates.Electric.Color, 0);
    mainGradient:SetRotation(-60, 1);
    mainGradient:SetOffsetSpeed(speed * 2.5, 1);

    local Rotation = 0;
    local Connection1;
    Connection1 = RunService.Heartbeat:Connect(function(dt)
        if (not mainGradient.Instance or mainGradient.Instance.Parent == nil) then
            Connection1:Disconnect();
            return;
        end;
        Rotation = Rotation + speed * dt * 50;
        mainGradient:SetRotation(-60 + math.sin(Rotation * 0.05) * 30, 0.15);
    end);

    local mainStroke = TextEffects.Stroke.new(uiInstance, size, nil, nil, useScaledSize);
    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, TextEffects.Templates.Electric.Color, 0);
    strokeGradient:SetRotation(60, 1);
    strokeGradient:SetOffsetSpeed(-speed * 2, 1);

    local StrokeRotation = 0;
    local Connection2;
    Connection2 = RunService.Heartbeat:Connect(function(dt)
        if (not strokeGradient.Instance or strokeGradient.Instance.Parent == nil) then
            Connection2:Disconnect();
            return;
        end;
        StrokeRotation = StrokeRotation + speed * dt * 45;
        strokeGradient:SetRotation(60 - math.sin(StrokeRotation * 0.05) * 30, 0.15);
    end);

    local pulseSize = size;
    local pulseSpeed = speed * 3;
    local Connection3;
    Connection3 = RunService.Heartbeat:Connect(function(dt)
        if (not mainStroke.Instance or mainStroke.Instance.Parent == nil) then
            Connection3:Disconnect();
            return;
        end;
        local t = tick() * pulseSpeed;
        local sizeMultiplier = 1 + 0.4 * (math.sin(t) * 0.5 + 0.5);
        mainStroke:SetSize(pulseSize * sizeMultiplier, 0.08);
    end);

    return {
        Effects = { mainGradient, strokeGradient, mainStroke },
        Connections = { Connection1, Connection2, Connection3 }
    };
end
