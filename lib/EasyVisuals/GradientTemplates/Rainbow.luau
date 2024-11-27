return function()
    local Gradient = Instance.new("UIGradient");
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)),
        ColorSequenceKeypoint.new(0.1510416716337204, Color3.new(0.615686297416687, 0, 1)),
        ColorSequenceKeypoint.new(0.3072916567325592, Color3.new(0.06666667014360428, 0, 1)),
        ColorSequenceKeypoint.new(0.4965277910232544, Color3.new(0, 1, 1)),
        ColorSequenceKeypoint.new(0.6649305820465088, Color3.new(0.01568627543747425, 1, 0)),
        ColorSequenceKeypoint.new(0.8385416865348816, Color3.new(1, 1, 0)),
        ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0)),
    });
    return Gradient;
end