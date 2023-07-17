return function()
    local Gradient = Instance.new("UIGradient");
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(48, 95, 96)),
        ColorSequenceKeypoint.new(0.0677083358168602, Color3.new(0.686274528503418, 0.7882353067398071, 0.8352941274642944)),
        ColorSequenceKeypoint.new(0.171875, Color3.new(0.8784313797950745, 0.9411764740943909, 1)),
        ColorSequenceKeypoint.new(0.3177083432674408, Color3.fromRGB(140, 208, 209)),
        ColorSequenceKeypoint.new(0.4670138955116272, Color3.fromRGB(109, 210, 212)),
        ColorSequenceKeypoint.new(0.4982638955116272, Color3.fromRGB(48, 95, 96)),
        ColorSequenceKeypoint.new(0.5034722089767456, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(0.71875, Color3.new(0.7058823704719543, 1, 0.9529411792755127)),
        ColorSequenceKeypoint.new(0.9409722089767456, Color3.fromRGB(165, 242, 243)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(48, 95, 96)),
    })
    return Gradient;
end