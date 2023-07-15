local TextEffects = script.Parent.Parent;

local Gradient = require(TextEffects.Gradient);
local Stroke = require(TextEffects.Stroke);
local Templates = require(TextEffects.GradientTemplates);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainGradient = Gradient.new(uiInstance, Templates.Oceanic.Color, 0);
    mainGradient:SetOffsetSpeed(speed, 1);
    mainGradient:SetRotation(-75, 1);
    mainGradient:SetRotationSpeed(0.1, 1);

    local mainStroke = Stroke.new(uiInstance, size);
    local strokeGradient = Gradient.new(mainStroke.Instance, Templates.Oceanic.Color, 0);
    strokeGradient:SetOffsetSpeed(-speed, 1);
    return {mainGradient, strokeGradient, mainStroke};
end