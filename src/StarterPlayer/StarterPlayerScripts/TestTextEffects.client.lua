local EasyVisuals = require(game:GetService("ReplicatedStorage").EasyVisuals);
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui");
local MainUI = PlayerGui:WaitForChild("MainUI");

local effect = EasyVisuals.new(MainUI.Frame1, "Rainbow");
local effect2 = EasyVisuals.new(MainUI.Frame2, "Lava");
local effect3 = EasyVisuals.new(MainUI.Frame3, "Bubblegum");
local outline = EasyVisuals.new(MainUI.Frame4, "RainbowOutline", 1, 4);

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

-- task.delay(5, function()
-- 	print("bubblegum destroy");
-- 	textEffect9:Destroy();
-- end)