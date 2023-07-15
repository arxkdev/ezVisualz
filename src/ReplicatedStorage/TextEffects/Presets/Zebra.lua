local TextEffects = script.Parent.Parent;

local Gradient = require(TextEffects.Gradient);
local Stroke = require(TextEffects.Stroke);
local Templates = require(TextEffects.GradientTemplates);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainGradient = Gradient.new(uiInstance, Templates.Zebra.Color, 0);
    mainGradient:SetOffsetSpeed(speed, 1);
    mainGradient:SetRotation(90, 1);

    local mainStroke = Stroke.new(uiInstance, size);

    local strokeGradient = Gradient.new(mainStroke.Instance, Templates.Zebra.Color, 0);
    strokeGradient:SetOffset(0.5, 1);
    strokeGradient:SetRotation(90, 1);

    task.delay(0.1, function()
        strokeGradient:SetOffsetSpeed(speed, 1);
    end);

    return {mainGradient, strokeGradient, mainStroke};
end