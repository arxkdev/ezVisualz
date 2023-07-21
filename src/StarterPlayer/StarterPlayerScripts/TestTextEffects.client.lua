local Players = game:GetService("Players");

local EasyVisuals = require(game:GetService("ReplicatedStorage").EasyVisuals);
local Player = Players.LocalPlayer;
local PlayerGui = Player:WaitForChild("PlayerGui");
local MainUI = PlayerGui:WaitForChild("MainUI");

local effect = EasyVisuals.new(MainUI.Frame1, "Rainbow");
local effect2 = EasyVisuals.new(MainUI.Frame2, "Lava");
local outline = EasyVisuals.new(MainUI.Frame3, "RainbowOutline", 1, 5);
local outline2 = EasyVisuals.new(MainUI.Frame4, "GreenOutline", 1, 5);

local textEffect = EasyVisuals.new(MainUI.Texts.TextLabel1, "RainbowStroke", 0.01, 6);
local textEffect2 = EasyVisuals.new(MainUI.Texts.TextLabel2, "LavaStroke", 0.004, 5);
local textEffect3 = EasyVisuals.new(MainUI.Texts.TextLabel3, "Ghost", 0.004, 5);
local textEffect4 = EasyVisuals.new(MainUI.Texts.TextLabel4, "GhostStroke", 0.004, 2);
local textEffect5 = EasyVisuals.new(MainUI.Texts.TextLabel5, "Gold", 0.009, 2);
local textEffect6 = EasyVisuals.new(MainUI.Texts.TextLabel6, "GoldStroke", 0.012, 3);
local textEffect7 = EasyVisuals.new(MainUI.Texts.TextLabel7, "SilverStroke", 0.012, 3);
local textEffect8 = EasyVisuals.new(MainUI.Texts.TextLabel8, "ChromeStroke", 0.004, 3);
local textEffect9 = EasyVisuals.new(MainUI.Texts.TextLabel9, "Bubblegum", 0.008, 3);
local textEffect10 = EasyVisuals.new(MainUI.Texts.TextLabel10, "OceanicStroke", 0.001, 2);
local textEffect11 = EasyVisuals.new(MainUI.Texts.TextLabel11, "Zebra", 0.009, 3);
local textEffect12 = EasyVisuals.new(MainUI.Texts.TextLabel12, "DeathStroke", 0.002, 3);
local textEffect13 = EasyVisuals.new(MainUI.Texts.TextLabel13, "IceStroke", 0.007, 5);
local textEffect14 = EasyVisuals.new(MainUI.Texts.TextLabel14, "FireStroke", 0.007, 5);
local textEffect15 = EasyVisuals.new(MainUI.Texts.TextLabel15, "Matrix", 0.009, 3);
local textEffect16 = EasyVisuals.new(MainUI.Texts.TextLabel16, "Shine", 0.015, 3, false, Color3.fromRGB(187, 0, 255));
local textEffect17 = EasyVisuals.new(MainUI.Texts.TextLabel17, "WaveStroke", 0.008, 6, false, Color3.fromRGB(0, 247, 255));

local textEffectBillboard = EasyVisuals.new(workspace.Part.Attachment.BillboardGui.TextLabel, "RainbowStroke", 0.01, 3);

-- task.delay(5, function()
-- 	print("bubblegum destroy");
-- 	textEffect9:Destroy();
-- end)

-- task.delay(5, function()
-- 	print("bubblegum pause");
-- 	textEffect9:Pause();
-- end)

-- create billboard over head
local function SetupNametag()
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

    local textEffectBillboard = EasyVisuals.new(textLabel, "RainbowStroke", 0.01, 3);
end

if (Player.Character) then
    SetupNametag();
end
Player.CharacterAdded:Connect(function()
    SetupNametag();
end)