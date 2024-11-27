local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainGradient = TextEffects.Gradient.new(uiInstance, TextEffects.Templates.Oceanic.Color, 0);
    mainGradient:SetOffsetSpeed(speed, 1);
    mainGradient:SetRotation(-75, 1);
    mainGradient:SetRotationSpeed(0.1, 1);

    local mainStroke = TextEffects.Stroke.new(uiInstance, size);
    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, TextEffects.Templates.Oceanic.Color, 0);
    strokeGradient:SetOffsetSpeed(-speed, 1);
    return {
        Effects = { mainGradient, strokeGradient, mainStroke }
    };
end