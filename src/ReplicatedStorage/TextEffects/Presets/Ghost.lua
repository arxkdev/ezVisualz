local Gradient = require(script.Parent.Gradient);
local Templates = script.Parent.GradientTemplates;

return function(uiInstance: GuiObject, speed: number)
    local mainGradient = Gradient.new(uiInstance, Templates.Ghost.Color, Templates.Ghost.Transparency);
    mainGradient:SetOffsetSpeed(speed, 1);
    mainGradient:SetTransparencyOffsetSpeed(speed * 0.9, 1);
    return {mainGradient};
end