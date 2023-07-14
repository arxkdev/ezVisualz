local Gradient = require(script.Parent.Gradient);
local Stroke = require(script.Parent.Stroke);
local Templates = script.Parent.GradientTemplates;

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainGradient = Gradient.new(uiInstance, Templates.Gold.Color, 0);
    mainGradient:SetRotation(-75, 1);
    mainGradient:SetOffsetSpeed(speed, 1);

    local mainStroke = Stroke.new(uiInstance, size);
    local strokeGradient = Gradient.new(mainStroke.Instance, Templates.Gold.Color, 0);
    strokeGradient:SetRotation(75, 1);
    strokeGradient:SetOffsetSpeed(-speed, 1);
    return {mainGradient, strokeGradient, mainStroke};
end