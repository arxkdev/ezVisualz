local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainGradient = TextEffects.Gradient.new(uiInstance, TextEffects.Templates.Matrix.Color, 0);
    mainGradient:SetOffsetSpeed(speed, 1);
    mainGradient:SetRotation(90, 1);

    local mainStroke = TextEffects.Stroke.new(uiInstance, size);

    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, TextEffects.Templates.Matrix.Color, 0);
    strokeGradient:SetOffset(0.5, 1);
    strokeGradient:SetRotation(90, 1);

    task.delay(0.1, function()
        strokeGradient:SetOffsetSpeed(speed, 1);
    end);

    return {
        Effects = { mainGradient, strokeGradient, mainStroke }
    };
end