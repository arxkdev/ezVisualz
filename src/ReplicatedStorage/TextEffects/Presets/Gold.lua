local Gradient = require(script.Parent.Gradient);
local Templates = script.Parent.GradientTemplates;

return function(uiInstance: GuiObject, speed: number)
    local mainGradient = Gradient.new(uiInstance, Templates.Gold.Color, 0);
    mainGradient:SetRotation(-75, 1);
    mainGradient:SetOffsetSpeed(speed, 1);
    return {mainGradient};
end