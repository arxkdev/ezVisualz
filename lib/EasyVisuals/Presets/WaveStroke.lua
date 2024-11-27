local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number, customColor: Color3)
    local colorSequence = ColorSequence.new({
        ColorSequenceKeypoint.new(0, customColor),
        ColorSequenceKeypoint.new(0.5, customColor),
        ColorSequenceKeypoint.new(1, customColor)
    });

    local transparencySequence = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.25, 1),
        NumberSequenceKeypoint.new(0.5, 1),
        NumberSequenceKeypoint.new(0.75, 1),
        NumberSequenceKeypoint.new(1, 0)
    });

    local mainStroke = TextEffects.Stroke.new(uiInstance, size);
    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, colorSequence, transparencySequence);
    strokeGradient:SetOffsetSpeed(speed, 1);
    strokeGradient:SetTransparencyOffsetSpeed(speed * 0.9, 1);
    return {
        Effects = { strokeGradient, mainStroke }
    };
end