local TextEffects = script.Parent.Parent;

local Gradient = require(TextEffects.Gradient);
local Stroke = require(TextEffects.Stroke);
local Templates = require(TextEffects.GradientTemplates);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainGradient = Gradient.new(uiInstance, Templates.Silver.Color, 0);
    mainGradient:SetRotation(-80, 1);
    mainGradient:SetOffsetSpeed(speed, 1);

    local mainStroke = Stroke.new(uiInstance, size);
    local strokeGradient = Gradient.new(mainStroke.Instance, Templates.Silver.Color, 0);
    strokeGradient:SetRotation(-79, 1);
    strokeGradient:SetOffsetSpeed(speed * 0.56, 1);
    return {mainGradient, strokeGradient, mainStroke};
end