local Gradient = require(script.Parent.Gradient);
local Templates = script.Parent.GradientTemplates;

return function(uiInstance: GuiObject, speed: number)
    local mainGradient = Gradient.new(uiInstance, Templates.Rainbow.Color, 0);
    mainGradient:SetOffsetSpeed(speed, 1);
    return {mainGradient};
end