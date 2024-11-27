local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainGradient = TextEffects.Gradient.new(uiInstance, TextEffects.Templates.Ghost.Color, TextEffects.Templates.Ghost.Transparency);
    mainGradient:SetOffsetSpeed(speed, 1);
    mainGradient:SetTransparencyOffsetSpeed(speed * 0.9, 1);

    local mainStroke = TextEffects.Stroke.new(uiInstance, size);
    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, TextEffects.Templates.Ghost.Color, TextEffects.Templates.Ghost.Transparency);
    strokeGradient:SetOffsetSpeed(-speed * 0.9, 1);
    strokeGradient:SetTransparencyOffsetSpeed(-speed * 0.9, 1);
    return {
        Effects = { mainGradient, strokeGradient, mainStroke }
    };
end