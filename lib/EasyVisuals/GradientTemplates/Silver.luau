return function()
    local Gradient = Instance.new("UIGradient");
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(0.8352941274642944, 0.8352941274642944, 0.8352941274642944)),
        ColorSequenceKeypoint.new(0.284722238779068, Color3.new(0.7333333492279053, 0.7843137383460999, 0.8352941274642944)),
        ColorSequenceKeypoint.new(0.4982638955116272, Color3.new(0.3333333432674408, 0.3333333432674408, 0.43921568989753723)),
        ColorSequenceKeypoint.new(0.5034722089767456, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(0.7152777910232544, Color3.new(0.7333333492279053, 0.7843137383460999, 0.8352941274642944)),
        ColorSequenceKeypoint.new(1, Color3.new(0.8352941274642944, 0.8352941274642944, 0.8352941274642944)),
    })
    return Gradient;
end