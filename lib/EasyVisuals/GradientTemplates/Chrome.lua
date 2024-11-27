return function()
    local Gradient = Instance.new("UIGradient");
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(0, 0.062745101749897, 0.3529411852359772)),
        ColorSequenceKeypoint.new(0.0677083358168602, Color3.new(0.686274528503418, 0.7882353067398071, 0.8352941274642944)),
        ColorSequenceKeypoint.new(0.171875, Color3.new(0.8784313797950745, 0.9411764740943909, 1)),
        ColorSequenceKeypoint.new(0.3177083432674408, Color3.new(1, 0.7058823704719543, 1)),
        ColorSequenceKeypoint.new(0.4670138955116272, Color3.new(0.2666666805744171, 0, 0.49803921580314636)),
        ColorSequenceKeypoint.new(0.4982638955116272, Color3.new(0.019607843831181526, 0.003921568859368563, 0.03529411926865578)),
        ColorSequenceKeypoint.new(0.5034722089767456, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(0.71875, Color3.new(0.7058823704719543, 1, 0.9529411792755127)),
        ColorSequenceKeypoint.new(0.9409722089767456, Color3.new(0.15203255414962769, 0.6226686239242554, 0.6860832571983337)),
        ColorSequenceKeypoint.new(1, Color3.new(0, 0.062745101749897, 0.3529411852359772)),
    })
    return Gradient;
end