local RunService = game:GetService("RunService");
local TextEffects = require(script.Parent.Parent);

-- Making colors lighter
local function makeLighter(color: Color3, amount: number): Color3
    return color:Lerp(Color3.fromRGB(255, 255, 255), amount);
end

local function findColorFromObject(uiInstance: GuiObject): Color3
    local Data = {
        ["TextButton"] = "BackgroundColor3",
        ["TextLabel"] = "TextColor3",
        ["ImageLabel"] = "ImageColor3",
        ["ImageButton"] = "ImageColor3",
        ["Frame"] = "BackgroundColor3",
        ["ScrollingFrame"] = "BackgroundColor3",
        ["ViewportFrame"] = "BackgroundColor3",
    };

    local color = uiInstance[Data[uiInstance.ClassName]];
    if (color) then
        return color;
    end;

    -- If we can't find a color, we'll just use white
    return Color3.fromRGB(255, 255, 255);
end

return function(uiInstance: GuiObject, speed: number, size: number, customColor: Color3)
    customColor = customColor or findColorFromObject(uiInstance);

    -- We're not going to use a GradientTemplate because this requires us to do some things with the customColor
    local color1 = customColor;
    local color2 = makeLighter(customColor, 0.6);
    local color3 = customColor;

    local colorSequenceForShine = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(0.5, color2),
        ColorSequenceKeypoint.new(1, color3)
	});
		
	local mainStroke = TextEffects.Stroke.new(uiInstance, size);
	local strokeGradient = TextEffects.Gradient.new(mainStroke.Instance, colorSequenceForShine, 0);
	local Rotation = 0.75;
	
	local Connection
	Connection = RunService.Heartbeat:Connect(function(dt)
		if (not mainStroke.Instance or mainStroke.Instance.Parent == nil) then
			Connection:Disconnect();
		end;
		
		Rotation = Rotation + speed * dt;
		strokeGradient:SetRotation(Rotation, 1);
	end);

	return {
		Effects = { strokeGradient, mainStroke },
		Connections = { Connection }
	};
end
