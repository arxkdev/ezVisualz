local TextEffects = require(script.Parent.Parent);

return function(uiInstance: GuiObject, speed: number, size: number)
    local mainGradient = TextEffects.Gradient.new(uiInstance, TextEffects.Templates.Fire.Color, 0);
    mainGradient:SetRotation(-75, 1);
    mainGradient:SetOffsetSpeed(speed, 1);

    local Rotation = 0;
    task.spawn(function()
        while (true) do
            if (not mainGradient.Instance or mainGradient.Instance.Parent == nil) then
                break;
            end;

            Rotation = Rotation + 1;
            mainGradient:SetRotation(Rotation, 1);
            task.wait();
        end;
    end);

    local mainStroke = TextEffects.Stroke.new(uiInstance, size);
    local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, TextEffects.Templates.Fire.Color, 0);
    strokeGradient:SetRotation(75, 1);
    strokeGradient:SetOffsetSpeed(-speed, 1);
    return {mainGradient, strokeGradient, mainStroke};
end