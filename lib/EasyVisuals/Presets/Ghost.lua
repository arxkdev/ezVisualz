local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number)
    local mainGradient = TextEffects.Gradient.new(uiInstance, TextEffects.Templates.Ghost.Color, TextEffects.Templates.Ghost.Transparency);
    mainGradient:SetOffsetSpeed(speed, 1);
    mainGradient:SetTransparencyOffsetSpeed(speed * 0.9, 1);
    return {
        Effects = { mainGradient }
    };
end