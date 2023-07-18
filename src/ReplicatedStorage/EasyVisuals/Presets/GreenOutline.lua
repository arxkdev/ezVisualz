local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainStroke = TextEffects.Stroke.new(uiInstance, size);
    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, TextEffects.Templates.Green.Color, TextEffects.Templates.Green.Transparency);
    local Rotation = 5;

    task.spawn(function()
        while (true) do
            if (not mainStroke.Instance or mainStroke.Instance.Parent == nil) then
                break;
            end;
            Rotation = Rotation + 2;
            strokeGradient:SetRotation(Rotation, 1);
            task.wait();
        end;
    end);
    return {strokeGradient, mainStroke};
end