-- helper function to get keypoints and colors for a bubblegum gradient
-- for i,v in pairs(game.ReplicatedStorage.EffectsUtil.TemplateGradients:GetChildren()) do
--     local data = v.Color;
--     local keypoints = {};
--     local colors = {};
--     for i,v in pairs(data.Keypoints) do
--         table.insert(keypoints, v.Time);
--         table.insert(colors, v.Value);
--     end

--     print("Gradient: "..v.Name);
--     print("ColorSequence.new({");
--     for i,v in pairs(keypoints) do
--         print("ColorSequenceKeypoint.new("..v..", Color3.new("..colors[i].R..", "..colors[i].G..", "..colors[i].B..")),");
--     end
--     print("})");
-- end

-- helper fnuctions to get transparent gradients
-- for i,v in pairs(game.ReplicatedStorage.EffectsUtil.TemplateGradients:GetChildren()) do
--     local data = v.Transparency;
--     if data == 0 then continue end
--     local keypoints = {};
--     local transparencyValues = {};
--     for i,v in pairs(data.Keypoints) do
--         table.insert(keypoints, v.Time);
--         table.insert(transparencyValues, v.Value);
--     end

--     print("Gradient: "..v.Name);
--     print("NumberSequence.new({");
--     for i,v in pairs(keypoints) do
--         print("NumberSequenceKeypoint.new("..v..", "..transparencyValues[i].."),");
--     end
--     print("})");
-- end

local function CreateGradient()
    local Gradient = Instance.new("UIGradient");
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(0.9529411792755127, 0.3960784375667572, 0.6941176652908325)),
        ColorSequenceKeypoint.new(0.5, Color3.new(1, 0.6549019813537598, 0.8901960849761963)),
        ColorSequenceKeypoint.new(1, Color3.new(0.9529411792755127, 0.3960784375667572, 0.6941176652908325)),
    })
    Gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.09894459694623947, 0),
        NumberSequenceKeypoint.new(0.5, 1),
        NumberSequenceKeypoint.new(0.8997361660003662, 0),
        NumberSequenceKeypoint.new(1, 0),
    })
    return Gradient;
end;

return CreateGradient();