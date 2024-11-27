local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainGradient = TextEffects.Gradient.new(uiInstance, TextEffects.Templates.Death.Color, 0);
    mainGradient:SetRotation(-90, 1);
    mainGradient:SetOffsetSpeed(speed, 1);

    local mainStroke = TextEffects.Stroke.new(uiInstance, size);
    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, TextEffects.Templates.Death.Color, 0);
    strokeGradient:SetOffsetSpeed(-speed - 0.001, 1);
    strokeGradient:SetRotation(-85, 1);
    return {
        Effects = { mainGradient, strokeGradient, mainStroke }
    };
end