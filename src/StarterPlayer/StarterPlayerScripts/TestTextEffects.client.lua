local TextEffects = require(game:GetService("ReplicatedStorage").TextEffects);
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui");
local MainUI = PlayerGui:WaitForChild("MainUI");

local effect = TextEffects.new(MainUI.Frame1, "Rainbow");
local effect2 = TextEffects.new(MainUI.Frame2, "Lava");
local effect3 = TextEffects.new(MainUI.Frame3, "Bubblegum");

local textEffect = TextEffects.new(MainUI.TextLabel1, "RainbowStroke", 0.01, 6);
local textEffect2 = TextEffects.new(MainUI.TextLabel2, "LavaStroke", 0.004, 5);
local textEffect3 = TextEffects.new(MainUI.TextLabel3, "Ghost", 0.004, 5);
local textEffect4 = TextEffects.new(MainUI.TextLabel4, "GhostStroke", 0.004, 2);
local textEffect5 = TextEffects.new(MainUI.TextLabel5, "Gold", 0.009, 2);
local textEffect6 = TextEffects.new(MainUI.TextLabel6, "GoldStroke", 0.012, 3);
local textEffect7 = TextEffects.new(MainUI.TextLabel7, "SilverStroke", 0.012, 3);
local textEffect8 = TextEffects.new(MainUI.TextLabel8, "ChromeStroke", 0.004, 3);
local textEffect9 = TextEffects.new(MainUI.TextLabel9, "Bubblegum", 0.008, 3);
local textEffect10 = TextEffects.new(MainUI.TextLabel10, "OceanicStroke", 0.001, 2);

-- task.delay(5, function()
-- 	print("bubblegum destroy");
-- 	textEffect9:Destroy();
-- end)