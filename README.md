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

## Presets
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