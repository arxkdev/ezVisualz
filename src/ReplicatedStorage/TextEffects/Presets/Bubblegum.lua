local Gradient = require(script.Parent.Gradient);
local Stroke = require(script.Parent.Stroke);
local Templates = require(script.Parent.GradientTemplates);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainGradient = Gradient.new(uiInstance, Templates.Bubblegum.Color, 0);
    mainGradient:SetRotation(-90, 1);
    mainGradient:SetOffsetSpeed(speed, 1);

    local mainStroke = Stroke.new(uiInstance, size);
    local strokeGradient = Gradient.new(mainStroke.Instance, Templates.Bubblegum.Color, 0);
    strokeGradient:SetRotation(-45, 1);
    strokeGradient:SetOffsetSpeed(speed * 0.9, 1);

    task.spawn(function()
        while (uiInstance:IsDescendantOf(game)) do
            mainStroke:SetSize(size * 3, 0.055);
            task.wait(0.2);
            mainStroke:SetSize(size, 0.055);
            task.wait(0.2);
        end;
    end);

    return {mainGradient, strokeGradient, mainStroke};
end