local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number)
    local mainGradient = TextEffects.Gradient.new(uiInstance, TextEffects.Templates.Lava.Color, 0);
    mainGradient:SetOffsetSpeed(speed, 1);
    return {
        Effects = { mainGradient }
    };
end