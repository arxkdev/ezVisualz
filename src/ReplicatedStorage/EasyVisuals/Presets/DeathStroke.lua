local TextEffects = script.Parent.Parent;

local Gradient = require(TextEffects.Gradient);
local Stroke = require(TextEffects.Stroke);
local Templates = require(TextEffects.GradientTemplates);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainGradient = Gradient.new(uiInstance, Templates.Death.Color, 0);
    mainGradient:SetRotation(-90, 1);
    mainGradient:SetOffsetSpeed(speed, 1);

    local mainStroke = Stroke.new(uiInstance, size);
    local strokeGradient = Gradient.new(mainStroke.Instance, Templates.Death.Color, 0);
    strokeGradient:SetOffsetSpeed(-speed - 0.001, 1);
    strokeGradient:SetRotation(-85, 1);
    return {mainGradient, strokeGradient, mainStroke};
end