return function()
    local Gradient = Instance.new("UIGradient");
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(0.6, 0, 0)),
        ColorSequenceKeypoint.new(0.125, Color3.new(1, 0, 0)),
        ColorSequenceKeypoint.new(0.2552083432674408, Color3.new(0.411764, 0, 0)),
        ColorSequenceKeypoint.new(0.3767361044883728, Color3.new(0.3, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.new(0.690196, 0, 0)),
        ColorSequenceKeypoint.new(0.6197916865348816, Color3.new(0.3, 0, 0)),
        ColorSequenceKeypoint.new(0.7378472089767456, Color3.new(1, 0, 0)),
        ColorSequenceKeypoint.new(0.8680555820465088, Color3.new(0.3, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.new(0.6, 0, 0))
    })
    return Gradient;
end