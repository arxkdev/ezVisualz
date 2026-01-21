return function()
    local Gradient = Instance.new("UIGradient");
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 94, 77)), -- Coral Red
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 154, 0)), -- Orange
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 192, 203)), -- Pink
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 20, 147)), -- Deep Pink
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 94, 77)), -- Coral Red
    });
    return Gradient;
end
