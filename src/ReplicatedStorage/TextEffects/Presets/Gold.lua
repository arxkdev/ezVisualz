local TextEffects = script.Parent.Parent;

local Gradient = require(TextEffects.Gradient);
local Templates = require(TextEffects.GradientTemplates);

return function(uiInstance: GuiObject, speed: number)
    local mainGradient = Gradient.new(uiInstance, Templates.Gold.Color, 0);
    mainGradient:SetRotation(-75, 1);
    mainGradient:SetOffsetSpeed(speed, 1);
    return {mainGradient};
end