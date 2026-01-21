return function()
    local Gradient = Instance.new("UIGradient");
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)), -- Magenta
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(0, 255, 255)), -- Cyan
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 0, 255)), -- Magenta
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(255, 0, 150)), -- Pink
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 255, 255)), -- Cyan
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)), -- Magenta
    });
    return Gradient;
end
