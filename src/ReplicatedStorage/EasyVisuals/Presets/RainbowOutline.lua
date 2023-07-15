local TextEffects = script.Parent.Parent;

local Gradient = require(TextEffects.Gradient);
local Stroke = require(TextEffects.Stroke);
local Templates = require(TextEffects.GradientTemplates);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainStroke = Stroke.new(uiInstance, size);
    local strokeGradient = Gradient.new(mainStroke.Instance, Templates.Rainbow.Color, 0);
    local Rotation = 0.5;

    task.spawn(function()
        while (true) do
            if (not mainStroke.Instance or mainStroke.Instance.Parent == nil) then
                break;
            end;
            Rotation = Rotation + speed;
            strokeGradient:SetRotation(Rotation, 1);
            task.wait();
        end;
    end);
    return {strokeGradient, mainStroke};
end