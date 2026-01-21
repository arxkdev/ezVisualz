local Players = game:GetService("Players");

local EasyVisuals = require(game:GetService("ReplicatedStorage").EasyVisuals);
local Player = Players.LocalPlayer;
local PlayerGui = Player:WaitForChild("PlayerGui");
local MainUI = PlayerGui:WaitForChild("MainUI");

-- Outlines speed is 1-100
-- Strokes and regular Gradients speed is 0-1

local effect = EasyVisuals.new(MainUI.Frame1, "Rainbow", 0.35);
local effect2 = EasyVisuals.new(MainUI.Frame2, "Lava", 0.35);
local outline = EasyVisuals.new(MainUI.Frame3, "RainbowOutline", 75, 5);
local outline2 = EasyVisuals.new(MainUI.Frame4, "GreenOutline", 75, 5); -- acelerator is much higher so needs to be higher speed
local outline3 = EasyVisuals.new(MainUI.Frame5, "ShineOutline", 75, 5, false, Color3.fromRGB(78, 177, 238)); -- acelerator is much higher so needs to be higher speed

local textEffect = EasyVisuals.new(MainUI.Texts.TextLabel1, "RainbowStroke", 0.5, 6, true);
local textEffect2 = EasyVisuals.new(MainUI.Texts.TextLabel2, "LavaStroke", 0.35, 5);
local textEffect3 = EasyVisuals.new(MainUI.Texts.TextLabel3, "Ghost", 0.2, 5);
local textEffect4 = EasyVisuals.new(MainUI.Texts.TextLabel4, "GhostStroke", 0.2, 2);
local textEffect5 = EasyVisuals.new(MainUI.Texts.TextLabel5, "Gold", 0.4, 2);
local textEffect6 = EasyVisuals.new(MainUI.Texts.TextLabel6, "GoldStroke", 0.55, 3);
local textEffect7 = EasyVisuals.new(MainUI.Texts.TextLabel7, "SilverStroke", 0.45, 3);
local textEffect8 = EasyVisuals.new(MainUI.Texts.TextLabel8, "ChromeStroke", 0.35, 3);
local textEffect9 = EasyVisuals.new(MainUI.Texts.TextLabel9, "Bubblegum", 1, 3);
local textEffect10 = EasyVisuals.new(MainUI.Texts.TextLabel10, "OceanicStroke", 0.2, 2);
local textEffect11 = EasyVisuals.new(MainUI.Texts.TextLabel11, "Zebra", 0.4, 3);
local textEffect12 = EasyVisuals.new(MainUI.Texts.TextLabel12, "DeathStroke", 0.2, 3);
local textEffect13 = EasyVisuals.new(MainUI.Texts.TextLabel13, "IceStroke", 0.35, 5);
local textEffect14 = EasyVisuals.new(MainUI.Texts.TextLabel14, "FireStroke", 0.5, 5);
local textEffect15 = EasyVisuals.new(MainUI.Texts.TextLabel15, "Matrix", 0.5, 3);
local textEffect16 = EasyVisuals.new(MainUI.Texts.TextLabel16, "Shine", 0.65, 3, false, Color3.fromRGB(187, 0, 255));
local textEffect17 = EasyVisuals.new(MainUI.Texts.TextLabel17, "WaveStroke", 0.55, 6, false, Color3.fromRGB(0, 247, 255));
local textEffect18 = EasyVisuals.new(MainUI.Texts.TextLabel18, "NeonStroke", 0.6, 5);
local textEffect19 = EasyVisuals.new(MainUI.Texts.TextLabel19, "GalaxyStroke", 0.4, 4);
local textEffect20 = EasyVisuals.new(MainUI.Texts.TextLabel20, "ElectricStroke", 0.5, 6);
local textEffect21 = EasyVisuals.new(MainUI.Texts.TextLabel21, "SunsetStroke", 0.45, 5);

-- Relative to parent (ui stroke scaled update)
local textEffectRelativeToParent = EasyVisuals.new(MainUI.RelativeToParent.TextLabel, "RainbowStroke", 0.5, 6, true, nil, nil, nil, true);

local textEffectBillboard = EasyVisuals.new(workspace.Part.Attachment.BillboardGui.TextLabel, "RainbowStroke", 0.4, 3);

task.delay(5, function()
    print("Pausing TextEffectBillboard!");
    textEffectBillboard:Pause();
end);

task.delay(10, function()
    -- TextEffect has saveInstanceObjects set to true, so it will save the black stroke (we set) when destroyed
    print("Destroying TextEffect!");
    textEffect:Destroy();
end);

-- create billboard over head
local textEffectsBillboard
local function SetupNametag()
    if (textEffectsBillboard) then
        textEffectsBillboard:Destroy();
    end

    local billboard = Instance.new("BillboardGui");
    billboard.Name = "BillboardGui";
    billboard.AlwaysOnTop = true;
    billboard.Size = UDim2.new(0, 100, 0, 80);
    billboard.StudsOffset = Vector3.new(0, 2, 0);
    billboard.Parent = Player.Character:WaitForChild("Head");

    local textLabel = Instance.new("TextLabel");
    textLabel.Name = "TextLabel";
    textLabel.Size = UDim2.new(1, 0, 1, 0);
    textLabel.BackgroundTransparency = 1;
    textLabel.Text = Player.Name;
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
    textLabel.TextScaled = true;
    textLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    textLabel.Position = UDim2.new(0.5, 0, 0.5, 0);
    textLabel.FontFace = Font.new("rbxasset://fonts/families/Bangers.json");
    textLabel.Parent = billboard;

    textEffectsBillboard = EasyVisuals.new(textLabel, "RainbowStroke", 0.4, 3);
end

if (Player.Character) then
    SetupNametag();
end
Player.CharacterAdded:Connect(function()
    SetupNametag();
end)