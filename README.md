# ezVisualz

Quick example on how to use:
```lua
local TextEffects = require(...)

-- UI: GuiObject, PresetName: string, Time: number, Size: number
-- Initializing an effect on an object
local Label = ...
local Effect = TextEffects.new(Label, "RainbowStroke", 0.01, 6)

-- Destroying the Effect
Effect:Destroy()
```

## How to use the Gradient class
```lua
local TextEffects = require(...)
local Gradient = TextEffects.Gradient.new(instance, color, transparency);
-- Then we can use the gradient to apply it to an object
Gradient:SetOffsetSpeed(number)
Gradient:SetTransparencyOffsetSpeed(number)
Gradient:SetColor(color)
Gradient:SetTransparencySequence(number or NumberSequence, acceleration)
Gradient:SetRotation(number, acceleration)
Gradient:SetRotationSpeed(number, acceleration)
```

## How to use the Stroke class
```lua
local TextEffects = require(...)
local Stroke = TextEffects.Stroke.new(instance, size);
-- Then we can use the stroke to apply it to an object
local StrokeGradient = TextEffects.Gradient.new(Stroke.Instance, color, transparency);
StrokeGradient:SetOffsetSpeed(number)
StrokeGradient:SetTransparencyOffsetSpeed(number)
StrokeGradient:SetTransparency(number, acceleration)
StrokeGradient:SetSize(number, acceleration)
StrokeGradient:SetColor(color, acceleration)
```

# Presets
- RainbowStroke (Applies rainbow and stroke effect)
- Rainbow (Applies rainbow effect)
- Bubblegum (Applies bubblegum effect)
- ChromeStroke (Applies chrome and stroke effect)
- Ghost (Applies ghost effect)
- GhostStroke (Applies ghost and stroke effect)
- Gold (Applies gold effect)
- GoldStroke (Applies gold and stroke effect)
- Lava (Applies lava effect)
- LavaStroke (Applies lava and stroke effect)
- OceanicStroke (Applies oceanic and stroke effect)
- Silver (Applies silver effect)
- SilverStroke (Applies silver and stroke effect)
- Zebra (Applies zebra effect)
- More to come...