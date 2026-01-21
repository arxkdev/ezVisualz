local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number, customColor: ColorSequence | Color3?, customTransparency: NumberSequence | number?, useScaledSize: boolean?)
    local actualColor: Color3 = Color3.new(1, 1, 1);
    if customColor then
        if typeof(customColor) == "ColorSequence" then
            actualColor = customColor.Keypoints[1].Value;
        else
            actualColor = customColor;
        end;
    end;
    local colorSequence = ColorSequence.new({
        ColorSequenceKeypoint.new(0, actualColor),
        ColorSequenceKeypoint.new(0.5, actualColor),
        ColorSequenceKeypoint.new(1, actualColor)
    });

    local transparencySequence = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.25, 1),
        NumberSequenceKeypoint.new(0.5, 1),
        NumberSequenceKeypoint.new(0.75, 1),
        NumberSequenceKeypoint.new(1, 0)
    });

    local mainStroke = TextEffects.Stroke.new(uiInstance, size, nil, nil, useScaledSize);
    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, colorSequence, transparencySequence);
    strokeGradient:SetOffsetSpeed(speed, 1);
    strokeGradient:SetTransparencyOffsetSpeed(speed * 0.9, 1);
    return {
        Effects = { strokeGradient, mainStroke }
    };
end