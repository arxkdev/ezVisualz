return function()
    local Gradient = Instance.new("UIGradient");
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)), -- Bright Electric Blue
        ColorSequenceKeypoint.new(0.15, Color3.fromRGB(255, 255, 255)), -- Pure White
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(100, 200, 255)), -- Light Electric Blue
        ColorSequenceKeypoint.new(0.45, Color3.fromRGB(255, 255, 255)), -- Pure White
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 200, 255)), -- Cyan Blue
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 255, 255)), -- Pure White
        ColorSequenceKeypoint.new(0.9, Color3.fromRGB(50, 150, 255)), -- Medium Electric Blue
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255)), -- Bright Electric Blue
    });
    return Gradient;
end
