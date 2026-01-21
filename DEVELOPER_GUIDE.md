# EasyVisuals Developer Guide

This guide explains how EasyVisuals effects work internally and how to create your own custom effects.

## Table of Contents

1. [Understanding the API](#understanding-the-api)
2. [Effect Types](#effect-types)
   - [Gradient](#gradient)
   - [Stroke](#stroke)
   - [Dropshadow](#dropshadow)
3. [Creating Custom Presets](#creating-custom-presets)
4. [Creating Custom Gradient Templates](#creating-custom-gradient-templates)
5. [Advanced Examples](#advanced-examples)
6. [Best Practices](#best-practices)

---

## Understanding the API

### Basic Usage

```lua
local EasyVisuals = require(path.to.EasyVisuals)

-- Create an effect
local effect = EasyVisuals.new(
    uiInstance,        -- GuiObject to apply effect to
    effectType,        -- Preset name (string)
    speed,             -- Animation speed (number, optional)
    size,              -- Effect size (number, optional)
    saveInstanceObjects, -- Save existing strokes/gradients (boolean, optional)
    customColor,       -- Custom color override (ColorSequence | Color3, optional)
    customTransparency,-- Custom transparency override (NumberSequence | number, optional)
    resumesOnVisible   -- Auto-resume when visible (boolean, optional, default: true)
)

-- Control the effect
effect:Pause()    -- Pause the animation
effect:Resume()   -- Resume the animation
effect:Destroy()  -- Remove the effect and clean up
```

### Effect Object Properties

Every effect object has these properties:

- `UIInstance: GuiObject` - The UI element the effect is applied to
- `EffectObjects: { Instance }` - Array of effect components (Gradients, Strokes, etc.)
- `SavedObjects: { Instance }` - Saved original objects (if `saveInstanceObjects` was true)
- `Speed: number` - Current animation speed
- `Size: number` - Current effect size
- `IsPaused: boolean` - Whether the effect is currently paused

---

## Effect Types

EasyVisuals uses three core effect types that can be combined to create presets.

### Gradient

The `Gradient` class creates animated UIGradient effects with customizable colors, transparency, offset, and rotation.

#### Creating a Gradient

```lua
local EasyVisuals = require(path.to.EasyVisuals)

-- Create a gradient
local gradient = EasyVisuals.Gradient.new(
    uiInstance,           -- GuiObject or UIStroke
    colorSequence,        -- ColorSequence
    transparencySequence  -- NumberSequence or number (0-1)
)
```

#### Gradient Methods

**Offset Control** (moves the gradient along the UI element):

```lua
-- Set a specific offset value (0-1)
gradient:SetOffset(0.5, acceleration)
-- acceleration: 0-1, how fast to reach the target (1 = instant)

-- Set offset speed (continuous animation)
gradient:SetOffsetSpeed(speed, acceleration)
-- speed: how fast the offset changes per second
-- acceleration: 0-1, how fast to reach target speed
```

**Transparency Control**:

```lua
-- Set transparency offset (moves transparency gradient)
gradient:SetTransparencyOffset(offset, acceleration)

-- Set transparency offset speed (continuous animation)
gradient:SetTransparencyOffsetSpeed(speed, acceleration)

-- Set transparency sequence
gradient:SetTransparencySequence(transparency, acceleration)
-- transparency: number (0-1) or NumberSequence
```

**Rotation Control**:

```lua
-- Set rotation angle (degrees)
gradient:SetRotation(rotation, acceleration)

-- Set rotation speed (continuous rotation)
gradient:SetRotationSpeed(speed, acceleration)
-- speed: degrees per second
```

**Color Control**:

```lua
-- Change the color sequence
gradient:SetColorSequence(colorSequence, blendRate)
-- blendRate: 0-1, how fast to blend to new colors (1 = instant)
```

#### Gradient Example

```lua
local EasyVisuals = require(path.to.EasyVisuals)

-- Create a rainbow gradient
local rainbowGradient = EasyVisuals.Gradient.new(
    textLabel,
    EasyVisuals.Templates.Rainbow.Color,
    0  -- No transparency
)

-- Animate it moving left to right
rainbowGradient:SetOffsetSpeed(0.5, 1)  -- Speed of 0.5, instant acceleration
```

---

### Stroke

The `Stroke` class creates animated UIStroke effects with customizable color, transparency, and thickness.

#### Creating a Stroke

```lua
local EasyVisuals = require(path.to.EasyVisuals)

local stroke = EasyVisuals.Stroke.new(
    uiInstance,    -- GuiObject or UIStroke
    size,          -- Thickness (number)
    color,         -- Color3 (optional, default: white)
    transparency   -- number 0-1 (optional, default: 0)
)
```

#### Stroke Methods

```lua
-- Change stroke size
stroke:SetSize(size, acceleration)
-- size: new thickness value
-- acceleration: 0-1, how fast to reach target size

-- Change stroke color
stroke:SetColor(color, acceleration)
-- color: Color3
-- acceleration: 0-1, how fast to blend to new color

-- Change stroke transparency
stroke:SetTransparency(transparency, acceleration)
-- transparency: 0-1
-- acceleration: 0-1, how fast to reach target transparency
```

#### Stroke Example

```lua
local EasyVisuals = require(path.to.EasyVisuals)

-- Create a stroke
local stroke = EasyVisuals.Stroke.new(textLabel, 3, Color3.new(1, 0, 0))

-- Animate it pulsing
stroke:SetSize(5, 0.1)  -- Grow to size 5 slowly
task.wait(1)
stroke:SetSize(3, 0.1)  -- Shrink back to size 3
```

---

### Dropshadow

The `Dropshadow` class creates a shadow effect by cloning the UI element and positioning it behind.

#### Creating a Dropshadow

```lua
local EasyVisuals = require(path.to.EasyVisuals)

local dropshadow = EasyVisuals.Dropshadow.new(
    uiInstance,    -- GuiObject or UIStroke
    color,         -- Color3 (optional, default: black)
    transparency,  -- number 0-1 (optional, default: 0)
    offset         -- Vector2 (optional, default: Vector2.new(-4, 4))
)
```

#### Dropshadow Methods

```lua
-- Change shadow offset
dropshadow:SetOffset(offset, acceleration)
-- offset: Vector2 (X, Y pixel offset)
-- acceleration: 0-1

-- Change shadow color
dropshadow:SetColor(color, acceleration)

-- Change shadow transparency
dropshadow:SetTransparency(transparency, acceleration)
```

#### Dropshadow Example

```lua
local EasyVisuals = require(path.to.EasyVisuals)

-- Create a dropshadow
local shadow = EasyVisuals.Dropshadow.new(
    textLabel,
    Color3.new(0, 0, 0),
    0.5,
    Vector2.new(-3, 3)
)

-- Animate shadow offset
shadow:SetOffset(Vector2.new(-5, 5), 0.2)
```

---

## Creating Custom Presets

Presets are ModuleScripts that return a function. This function receives the UI instance and parameters, then returns a table with effect objects.

### Preset Function Signature

```lua
return function(
    uiInstance: GuiObject,
    speed: number,
    size: number,
    customColor: ColorSequence | Color3?,
    customTransparency: NumberSequence | number?
): {
    Effects: { Effect },
    Connections: { RBXScriptConnection }?  -- Optional
}
```

### Simple Preset Example

Here's a simple preset that applies a rainbow gradient:

```lua
local EasyVisuals = require(script.Parent.Parent)

return function(uiInstance: GuiObject, speed: number, size: number)
    -- Create a gradient using the Rainbow template
    local gradient = EasyVisuals.Gradient.new(
        uiInstance,
        EasyVisuals.Templates.Rainbow.Color,
        0  -- No transparency
    )
    
    -- Animate the gradient offset
    gradient:SetOffsetSpeed(speed, 1)
    
    -- Return the effects
    return {
        Effects = { gradient }
    }
end
```

### Complex Preset Example

Here's a preset that combines multiple effects (like `RainbowStroke`):

```lua
local EasyVisuals = require(script.Parent.Parent)

return function(uiInstance: GuiObject, speed: number, size: number)
    -- Create gradient on the main UI element
    local mainGradient = EasyVisuals.Gradient.new(
        uiInstance,
        EasyVisuals.Templates.Rainbow.Color,
        0
    )
    mainGradient:SetOffsetSpeed(speed, 1)
    
    -- Create a stroke
    local stroke = EasyVisuals.Stroke.new(uiInstance, size)
    
    -- Create gradient on the stroke (moving opposite direction)
    local strokeGradient = EasyVisuals.Gradient.new(
        stroke.Instance,
        EasyVisuals.Templates.Rainbow.Color,
        0
    )
    strokeGradient:SetOffsetSpeed(-speed, 1)  -- Negative speed = opposite direction
    
    return {
        Effects = { mainGradient, strokeGradient, stroke }
    }
end
```

### Preset with Custom Connections

Some presets need custom RunService connections. Here's an example with rotation:

```lua
local RunService = game:GetService("RunService")
local EasyVisuals = require(script.Parent.Parent)

return function(uiInstance: GuiObject, speed: number, size: number)
    local stroke = EasyVisuals.Stroke.new(uiInstance, size)
    local gradient = EasyVisuals.Gradient.new(
        stroke.Instance,
        EasyVisuals.Templates.Rainbow.Color,
        0
    )
    
    local rotation = 0
    local connection = RunService.Heartbeat:Connect(function(dt)
        if not stroke.Instance or stroke.Instance.Parent == nil then
            connection:Disconnect()
            return
        end
        
        rotation = rotation + speed * dt
        gradient:SetRotation(rotation, 1)
    end)
    
    return {
        Effects = { gradient, stroke },
        Connections = { connection }  -- Important: return connections so they can be cleaned up
    }
end
```

### Using Custom Colors/Transparency

Presets can use the `customColor` and `customTransparency` parameters:

```lua
local EasyVisuals = require(script.Parent.Parent)

return function(uiInstance: GuiObject, speed: number, size: number, customColor, customTransparency)
    -- Use custom color if provided, otherwise use template
    local colorSequence = customColor or EasyVisuals.Templates.Rainbow.Color
    local transparency = customTransparency or 0
    
    local gradient = EasyVisuals.Gradient.new(uiInstance, colorSequence, transparency)
    gradient:SetOffsetSpeed(speed, 1)
    
    return {
        Effects = { gradient }
    }
end
```

---

## Creating Custom Gradient Templates

Gradient templates are ModuleScripts that return a function. This function returns a UIGradient instance.

### Template Function Signature

```lua
return function(): UIGradient
```

### Template Example

```lua
return function()
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)),      -- Red at start
        ColorSequenceKeypoint.new(0.5, Color3.new(0, 1, 0)),    -- Green at middle
        ColorSequenceKeypoint.new(1, Color3.new(0, 0, 1)),      -- Blue at end
    })
    return gradient
end
```

### Using Templates in Presets

```lua
local EasyVisuals = require(script.Parent.Parent)

return function(uiInstance: GuiObject, speed: number, size: number)
    -- Access templates via EasyVisuals.Templates
    local gradient = EasyVisuals.Gradient.new(
        uiInstance,
        EasyVisuals.Templates.YourTemplateName.Color,  -- Access the Color property
        0
    )
    
    -- Templates can also have Transparency
    -- EasyVisuals.Templates.YourTemplateName.Transparency
    
    gradient:SetOffsetSpeed(speed, 1)
    return {
        Effects = { gradient }
    }
end
```

### Template with Transparency

```lua
return function()
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
    })
    gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),    -- Opaque at start
        NumberSequenceKeypoint.new(0.5, 1),  -- Transparent at middle
        NumberSequenceKeypoint.new(1, 0),    -- Opaque at end
    })
    return gradient
end
```

---

## Advanced Examples

### Pulsing Stroke Effect

```lua
local RunService = game:GetService("RunService")
local EasyVisuals = require(script.Parent.Parent)

return function(uiInstance: GuiObject, speed: number, size: number)
    local stroke = EasyVisuals.Stroke.new(uiInstance, size)
    local gradient = EasyVisuals.Gradient.new(
        stroke.Instance,
        EasyVisuals.Templates.Rainbow.Color,
        0
    )
    
    local pulseDirection = 1
    local currentSize = size
    local minSize = size * 0.5
    local maxSize = size * 1.5
    
    local connection = RunService.Heartbeat:Connect(function(dt)
        if not stroke.Instance or stroke.Instance.Parent == nil then
            connection:Disconnect()
            return
        end
        
        currentSize = currentSize + (speed * pulseDirection * dt)
        
        if currentSize >= maxSize then
            currentSize = maxSize
            pulseDirection = -1
        elseif currentSize <= minSize then
            currentSize = minSize
            pulseDirection = 1
        end
        
        stroke:SetSize(currentSize, 1)
        gradient:SetOffsetSpeed(speed, 1)
    end)
    
    return {
        Effects = { stroke, gradient },
        Connections = { connection }
    }
end
```

### Multi-Layer Effect

```lua
local EasyVisuals = require(script.Parent.Parent)

return function(uiInstance: GuiObject, speed: number, size: number)
    -- Main gradient
    local mainGradient = EasyVisuals.Gradient.new(
        uiInstance,
        EasyVisuals.Templates.Rainbow.Color,
        0
    )
    mainGradient:SetOffsetSpeed(speed, 1)
    
    -- Outer stroke
    local outerStroke = EasyVisuals.Stroke.new(uiInstance, size)
    local outerGradient = EasyVisuals.Gradient.new(
        outerStroke.Instance,
        EasyVisuals.Templates.Rainbow.Color,
        0
    )
    outerGradient:SetOffsetSpeed(-speed * 0.5, 1)
    
    -- Inner stroke (smaller)
    local innerStroke = EasyVisuals.Stroke.new(uiInstance, size * 0.5)
    local innerGradient = EasyVisuals.Gradient.new(
        innerStroke.Instance,
        EasyVisuals.Templates.Rainbow.Color,
        0
    )
    innerGradient:SetOffsetSpeed(speed * 1.5, 1)
    
    return {
        Effects = { mainGradient, outerGradient, outerStroke, innerGradient, innerStroke }
    }
end
```

---

## Best Practices

### 1. Always Clean Up Connections

If your preset creates custom RunService connections, always return them in the `Connections` array:

```lua
return {
    Effects = { ... },
    Connections = { connection1, connection2 }  -- These will be cleaned up automatically
}
```

### 2. Check for Destroyed Instances

In custom connections, always check if instances still exist:

```lua
RunService.Heartbeat:Connect(function(dt)
    if not stroke.Instance or stroke.Instance.Parent == nil then
        connection:Disconnect()
        return
    end
    -- Your code here
end)
```

### 3. Use Appropriate Speed Ranges

- **Gradients**: Speed typically ranges from `0.1` to `1.0` for smooth animations
- **Outlines**: Speed can be higher (1-100) for rotation-based effects
- **Strokes**: Speed depends on what you're animating (size, color, etc.)

### 4. Acceleration Values

- `1` = Instant change (no interpolation)
- `0.1-0.3` = Smooth, gradual change
- `0.5-0.8` = Moderate speed change

### 5. Template Keypoints

- Keep ColorSequence keypoints between 0 and 1
- Use 2-7 keypoints for most effects (Roblox limit is 19)
- Space keypoints evenly for smooth gradients

### 6. Performance Considerations

- Effects automatically pause when UI elements are hidden
- Destroy effects when no longer needed to free resources
- Avoid creating too many effects on the same frame

### 7. Testing Your Presets

```lua
local EasyVisuals = require(path.to.EasyVisuals)

-- Test your preset
local testLabel = Instance.new("TextLabel")
testLabel.Text = "Test"
testLabel.Size = UDim2.new(0, 200, 0, 50)
testLabel.Parent = game.Players.LocalPlayer.PlayerGui

local effect = EasyVisuals.new(testLabel, "YourPresetName", 0.5, 3)
```

---

## Common Patterns

### Pattern 1: Simple Gradient Animation

```lua
local gradient = EasyVisuals.Gradient.new(uiInstance, template.Color, 0)
gradient:SetOffsetSpeed(speed, 1)
```

### Pattern 2: Stroke with Animated Gradient

```lua
local stroke = EasyVisuals.Stroke.new(uiInstance, size)
local strokeGradient = EasyVisuals.Gradient.new(stroke.Instance, template.Color, 0)
strokeGradient:SetOffsetSpeed(speed, 1)
```

### Pattern 3: Opposing Animations

```lua
-- Main gradient moves one way
mainGradient:SetOffsetSpeed(speed, 1)
-- Stroke gradient moves opposite
strokeGradient:SetOffsetSpeed(-speed, 1)
```

### Pattern 4: Transparency Animation

```lua
local gradient = EasyVisuals.Gradient.new(uiInstance, template.Color, template.Transparency)
gradient:SetOffsetSpeed(speed, 1)
gradient:SetTransparencyOffsetSpeed(speed * 0.9, 1)  -- Slightly different speed for depth
```

---

## Troubleshooting

### Effect Not Showing

- Check that the UI element is visible (`Visible = true` or `Enabled = true`)
- Verify the preset name matches exactly (case-sensitive)
- Ensure the UI element is a valid `GuiObject`

### Effect Too Fast/Slow

- Adjust the `speed` parameter when creating the effect
- For gradients, typical speeds are `0.1-1.0`
- For outlines with rotation, speeds can be `1-100`

### Custom Preset Not Working

- Ensure your preset ModuleScript returns a function
- Check that the function returns a table with `Effects` array
- Verify all effect objects are included in the `Effects` array
- Make sure custom connections are returned in `Connections` array

### Template Not Found

- Ensure template ModuleScript name matches what you're accessing
- Check that `EasyVisuals.Templates.YourTemplateName` exists
- Verify template returns a function that returns a UIGradient

---

## Summary

1. **Presets** combine Gradients, Strokes, and Dropshadows to create effects
2. **Templates** define reusable color/transparency sequences
3. **Effects** can be paused, resumed, and destroyed
4. **Custom presets** allow you to create unique effects without modifying the core library
5. **Connections** must be returned for proper cleanup

For more examples, check out the built-in presets in `lib/EasyVisuals/Presets/` and templates in `lib/EasyVisuals/GradientTemplates/`.
