local function CreateGradient()
    local Gradient = Instance.new("UIGradient");
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(0.8352941274642944, 0.6823529601097107, 0.21960784494876862)),
        ColorSequenceKeypoint.new(0.220486119389534, Color3.new(0.8352941274642944, 0.6823529601097107, 0.21960784494876862)),
        ColorSequenceKeypoint.new(0.3680555522441864, Color3.new(0.7803921699523926, 0.5960784554481506, 0.0470588244497776)),
        ColorSequenceKeypoint.new(0.4982638955116272, Color3.new(0.8509804010391235, 0.6980392336845398, 0.0117647061124444)),
        ColorSequenceKeypoint.new(0.5034722089767456, Color3.new(1, 0.9254902005195618, 0.5058823823928833)),
        ColorSequenceKeypoint.new(0.6927083134651184, Color3.new(0.8352941274642944, 0.6823529601097107, 0.21960784494876862)),
        ColorSequenceKeypoint.new(0.7916666865348816, Color3.new(0.8352941274642944, 0.6823529601097107, 0.21960784494876862)),
        ColorSequenceKeypoint.new(1, Color3.new(0.8352941274642944, 0.6823529601097107, 0.21960784494876862)),
    })
    return Gradient;
end

return CreateGradient();