return function()
    local Gradient = Instance.new("UIGradient");
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 0, 130)), -- Indigo
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(138, 43, 226)), -- Blue Violet
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 25, 112)), -- Midnight Blue
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(72, 61, 139)), -- Dark Slate Blue
        ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 0, 130)), -- Indigo
    });
    return Gradient;
end
