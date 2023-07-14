local repS = game:GetService("ReplicatedStorage")

local TextEffects = require(repS.TextEffects)
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local mainUI = playerGui:WaitForChild("MainUI")

local effect = TextEffects.new(mainUI.Frame1, "Rainbow")
local effect2 = TextEffects.new(mainUI.Frame2, "Lava")
local effect3 = TextEffects.new(mainUI.Frame3, "Bubblegum")

local textEffect = TextEffects.new(mainUI.TextLabel1, "RainbowStroke", 0.01, 6)
local textEffect2 = TextEffects.new(mainUI.TextLabel2, "LavaStroke", 0.004, 5)
local textEffect3 = TextEffects.new(mainUI.TextLabel3, "Ghost", 0.004, 5)
local textEffect4 = TextEffects.new(mainUI.TextLabel4, "GhostStroke", 0.004, 2)
local textEffect5 = TextEffects.new(mainUI.TextLabel5, "Gold", 0.009, 2)
local textEffect6 = TextEffects.new(mainUI.TextLabel6, "GoldStroke", 0.012, 3)
local textEffect7 = TextEffects.new(mainUI.TextLabel7, "SilverStroke", 0.012, 3)
local textEffect8 = TextEffects.new(mainUI.TextLabel8, "ChromeStroke", 0.004, 3)
local textEffect9 = TextEffects.new(mainUI.TextLabel9, "Bubblegum", 0.008, 3)
local textEffect10 = TextEffects.new(mainUI.TextLabel10, "OceanicStroke", 0.001, 2)

-- task.delay(5, function()
-- 	print("bubblegum destroy");
-- 	textEffect9:Destroy();
-- end)