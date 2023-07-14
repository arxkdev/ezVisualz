local repS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")

local runS = game:GetService("RunService")

local EffectModule = require(repS.TextEffects)
local effect = EffectModule.new(script.Parent.Frame1, "Rainbow")
local effect2 = EffectModule.new(script.Parent.Frame2, "Lava")
local effect3 = EffectModule.new(script.Parent.Frame3, "Bubblegum")

local textEffect = EffectModule.new(script.Parent.TextLabel1, "RainbowStroke", 0.01, 6)
local textEffect2 = EffectModule.new(script.Parent.TextLabel2, "LavaStroke", 0.004, 5)
local textEffect3 = EffectModule.new(script.Parent.TextLabel3, "Ghost", 0.004, 5)
local textEffect4 = EffectModule.new(script.Parent.TextLabel4, "GhostStroke", 0.004, 2)
local textEffect5 = EffectModule.new(script.Parent.TextLabel5, "Gold", 0.009, 2)
local textEffect6 = EffectModule.new(script.Parent.TextLabel6, "GoldStroke", 0.012, 3)
local textEffect7 = EffectModule.new(script.Parent.TextLabel7, "SilverStroke", 0.012, 3)
local textEffect8 = EffectModule.new(script.Parent.TextLabel8, "ChromeStroke", 0.004, 3)
local textEffect9 = EffectModule.new(script.Parent.TextLabel9, "Bubblegum", 0.008, 3)

task.delay(5, function()
	print("bubblegum");
	textEffect9:Destroy();
end)