local TextEffects = script.Parent.Parent;

local Gradient = require(TextEffects.Gradient);
local Stroke = require(TextEffects.Stroke);
local Templates = require(TextEffects.GradientTemplates);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainGradient = Gradient.new(uiInstance, Templates.Ghost.Color, Templates.Ghost.Transparency);
    mainGradient:SetOffsetSpeed(speed, 1);
    mainGradient:SetTransparencyOffsetSpeed(speed * 0.9, 1);

    local mainStroke = Stroke.new(uiInstance, size);
    local strokeGradient = Gradient.new(mainStroke.Instance, Templates.Ghost.Color, Templates.Ghost.Transparency);
    strokeGradient:SetOffsetSpeed(-speed * 0.9, 1);
    strokeGradient:SetTransparencyOffsetSpeed(-speed * 0.9, 1);
    return {mainGradient, strokeGradient, mainStroke};
end