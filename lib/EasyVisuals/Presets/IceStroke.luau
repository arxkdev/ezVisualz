local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number, customColor: ColorSequence | Color3?, customTransparency: NumberSequence | number?, useScaledSize: boolean?)
    local mainGradient = TextEffects.Gradient.new(uiInstance, TextEffects.Templates.Ice.Color, 0);
    mainGradient:SetRotation(-65, 1);
    mainGradient:SetOffsetSpeed(speed, 1);

    local mainStroke = TextEffects.Stroke.new(uiInstance, size, nil, nil, useScaledSize);
    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, TextEffects.Templates.Ice.Color, 0);
    strokeGradient:SetRotation(-61, 1);
    strokeGradient:SetOffsetSpeed(speed * 0.23, 1);
    return {
        Effects = { mainGradient, strokeGradient, mainStroke }
    };
end