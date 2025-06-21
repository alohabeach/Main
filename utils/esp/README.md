# Advanced ESP System for Roblox

A high-performance, feature-rich ESP (Extra Sensory Perception) system for Roblox with adaptive performance optimization, comprehensive player visualization, and multi-game compatibility.

## 🌟 Features

### Player ESP
- **Bounding Boxes** - Customizable colored boxes around players
- **Health Bars** - Visual health indicators with color-coded health levels
- **Tracers** - Lines connecting from screen positions to players
- **Name Display** - Player names with customizable fonts and sizes
- **Distance Indicators** - Real-time distance measurements in studs
- **Direction Arrows** - Shows which way players are facing
- **Skeleton ESP** - Full body skeleton visualization (R6 and R15 compatible)
- **Team Color Support** - Automatic team-based coloring
- **Rainbow Mode** - Animated rainbow colors

### Object ESP
- **Custom Object Tracking** - Track any workspace objects
- **Distance Display** - Show distance to objects
- **Custom Names** - Override default object names
- **Tracer Support** - Lines to tracked objects

### Performance Features
- **Adaptive Frame Rate** - Automatically adjusts update rate based on performance
- **Distance-Based Culling** - Reduces rendering for distant players
- **Level-of-Detail System** - Different detail levels based on distance
- **Efficient Caching** - Position and color caching with automatic cleanup
- **Memory Management** - Automatic cache cleanup and garbage collection

### Game Compatibility
- **Phantom Forces** - Special health and replication handling
- **Arsenal** - Custom health system integration
- **Murder Mystery 2** - Role-based team assignment
- **Universal Support** - Works with any Roblox game

## 📋 Table of Contents

1. [Installation](#installation)
2. [Quick Start](#quick-start)
3. [Configuration](#configuration)
4. [API Reference](#api-reference)
5. [Performance Tuning](#performance-tuning)
6. [Game-Specific Features](#game-specific-features)
7. [Troubleshooting](#troubleshooting)
8. [Contributing](#contributing)

## 🚀 Installation

### Load The Module
```lua
local MainESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/alohabeach/Main/refs/heads/master/utils/esp/source.lua"))()
```

## 🎯 Quick Start

### Basic Usage
```lua
-- Enable basic ESP
MainESP.Options.Enabled = true
MainESP.Options.Box = true
MainESP.Options.Name = true
MainESP.Options.Distance = true

-- Add tracers
MainESP.Options.Tracer = true
MainESP.Options.TracerOrigin = "Bottom" -- "Top", "Middle", or "Bottom"

-- Enable team colors
MainESP.Options.UseTeamColor = true
```

### Advanced Configuration
```lua
-- Full feature setup
MainESP.Options.Enabled = true
MainESP.Options.Box = true
MainESP.Options.Health = true
MainESP.Options.Tracer = true
MainESP.Options.Name = true
MainESP.Options.Distance = true
MainESP.Options.Direction = true
MainESP.Options.Skeleton = true
MainESP.Options.Rainbow = true
MainESP.Options.TeamCheck = false -- Show all players regardless of team
```

### Object Tracking
```lua
-- Track a specific object
local targetObject = workspace.SomeObject
MainESP:CreateESP(nil, targetObject, "Custom Name")

-- Enable object ESP
MainESP.ObjectOptions.Enabled = true
MainESP.ObjectOptions.Name = true
MainESP.ObjectOptions.Distance = true
MainESP.ObjectOptions.Tracer = true
```

## ⚙️ Configuration

### Player ESP Options
```lua
MainESP.Options = {
    Enabled = false,              -- Master toggle for player ESP
    Box = false,                  -- Show bounding boxes
    Health = false,               -- Show health bars
    Tracer = false,               -- Show tracer lines
    TracerOrigin = "Bottom",      -- Tracer origin point
    Name = false,                 -- Show player names
    Distance = false,             -- Show distance
    Direction = false,            -- Show facing direction
    Skeleton = false,             -- Show skeleton
    TextOutline = false,          -- Add text outlines
    Color = Color3.new(1, 1, 1),  -- Default ESP color
    UseTeamColor = true,          -- Use team colors
    Rainbow = false,              -- Rainbow color mode
    Font = 1,                     -- Text font (0-3)
    FontSize = 20,                -- Text size
    TeamCheck = false,            -- Hide teammates
    BoxThickness = 0,             -- Box line thickness
    TracerThickness = 0,          -- Tracer line thickness
    DirectionThickness = 0,       -- Direction arrow thickness
    SkeletonThickness = 0,        -- Skeleton line thickness
}
```

### Object ESP Options
```lua
MainESP.ObjectOptions = {
    Enabled = false,                    -- Master toggle for object ESP
    Tracer = false,                     -- Show tracers to objects
    TextOutline = false,                -- Add text outlines
    Distance = false,                   -- Show distance to objects
    Name = false,                       -- Show object names
    Font = 1,                           -- Text font
    FontSize = 20,                      -- Text size
    Rainbow = false,                    -- Rainbow colors
    Color = Color3.fromRGB(255, 255, 0), -- Default object color
    TracerOrigin = "Bottom",            -- Tracer origin
    TracerThickness = 0,                -- Tracer thickness
}
```

### Performance Settings
```lua
-- Access performance settings (advanced users)
local ESPPerf = {
    targetFPS = 55,          -- Target FPS to maintain
    minInterval = 1/30,      -- Minimum update rate (30 FPS)
    maxInterval = 1/120,     -- Maximum update rate (120 FPS)
    adjustmentRate = 0.1,    -- How aggressively to adjust performance
}

-- Culling settings
local CullingSystem = {
    maxRenderDistance = 2000, -- Maximum render distance in studs
    nearDistance = 500,       -- Full detail distance
    farDistance = 1000,       -- Reduced detail distance
}
```

## 📖 API Reference

### Core Functions

#### `MainESP:CreateESP(player, object, customName, customPredicate)`
Creates ESP for a player or object.

**Parameters:**
- `player` (Player, optional): The player to track
- `object` (Instance, optional): The object to track
- `customName` (string, optional): Custom name override
- `customPredicate` (function, optional): Custom visibility condition

**Examples:**
```lua
-- Create ESP for a player
MainESP:CreateESP(game.Players.SomePlayer)

-- Create ESP for an object with custom name
MainESP:CreateESP(nil, workspace.ImportantObject, "Target")

-- Create ESP with custom predicate
MainESP:CreateESP(nil, workspace.ConditionalObject, "Conditional", function(obj)
    return obj.BrickColor == BrickColor.new("Bright red")
end)
```

#### `MainESP:RemoveESP(value)`
Removes ESP from a player or object.

**Parameters:**
- `value` (Player/Instance): The player or object to stop tracking

**Example:**
```lua
MainESP:RemoveESP(game.Players.SomePlayer)
MainESP:RemoveESP(workspace.SomeObject)
```

#### `MainESP:GetColor(player, useTeamColor, rainbow, defaultColor)`
Gets the appropriate color for ESP elements.

**Parameters:**
- `player` (Player): The target player
- `useTeamColor` (boolean): Whether to use team colors
- `rainbow` (boolean): Whether to use rainbow colors
- `defaultColor` (Color3): Fallback color

**Returns:**
- `Color3`: The calculated color

### Utility Functions

#### `MainESP.GetHealth(player)`
Gets a player's health information.

**Parameters:**
- `player` (Player): The target player

**Returns:**
- `number`: Current health
- `number`: Maximum health

#### `MainESP:PlayerAlive(player)`
Checks if a player is alive and has a valid character.

**Parameters:**
- `player` (Player): The target player

**Returns:**
- `boolean`: Whether the player is alive

#### `MainESP.GetDistanceFromPlayer(player, position)`
Calculates distance between a player and a position.

**Parameters:**
- `player` (Player): The reference player
- `position` (Vector3): The target position

**Returns:**
- `number`: Distance in studs

## 🔧 Performance Tuning

### Automatic Performance Optimization
The ESP system includes several automatic performance optimizations:

1. **Adaptive Frame Rate**: Automatically adjusts update frequency based on current FPS
2. **Distance Culling**: Stops rendering players beyond a certain distance
3. **Level of Detail**: Reduces visual complexity for distant players
4. **Caching System**: Reuses calculations to reduce computational overhead

### Manual Performance Tweaks

#### Reduce Update Frequency
```lua
-- Manually set update interval (higher = less frequent updates)
ESPPerf.interval = 1/30 -- 30 FPS update rate
```

#### Adjust Culling Distance
```lua
-- Reduce maximum render distance
CullingSystem.maxRenderDistance = 1000 -- Reduce from 2000 to 1000 studs
```

#### Disable Expensive Features
```lua
-- Disable performance-heavy features
MainESP.Options.Skeleton = false    -- Skeleton is computationally expensive
MainESP.Options.Rainbow = false     -- Rainbow colors require frequent updates
MainESP.Options.Direction = false   -- Direction arrows require extra calculations
```

### Performance Monitoring
The system includes built-in performance monitoring:
```lua
-- Monitor performance (check console output)
-- The system will print FPS and update rate information periodically
```

## 🎮 Game-Specific Features

### Phantom Forces (Place ID: 292439477)
- Custom health system integration
- Body part replication handling
- Enhanced player detection

### Arsenal (Place ID: 286090429)
- NRPBS health system support
- Optimized for fast-paced gameplay

### Murder Mystery 2 (Place ID: 142823291)
- Automatic role detection
- Team assignment based on roles:
  - Murderer (Red team)
  - Sheriff (Blue team)
  - Innocent (Green team)

### Universal Compatibility
The ESP system works with any Roblox game, with automatic fallbacks for unsupported games.

## 🎨 Customization Examples

### Custom Color Schemes
```lua
-- Neon green theme
MainESP.Options.Color = Color3.fromRGB(0, 255, 0)
MainESP.Options.UseTeamColor = false

-- Team-based with custom colors
MainESP.Options.UseTeamColor = true
-- Team colors will be used automatically

-- Rainbow mode
MainESP.Options.Rainbow = true
```

### Text Customization
```lua
-- Large, outlined text
MainESP.Options.FontSize = 24
MainESP.Options.TextOutline = true
MainESP.Options.Font = 2 -- Different font style
```

### Tracer Configurations
```lua
-- Tracers from top of screen
MainESP.Options.TracerOrigin = "Top"
MainESP.Options.TracerThickness = 2

-- Thick, visible tracers
MainESP.Options.TracerThickness = 3
```

### Skeleton Customization
```lua
-- Thick skeleton lines
MainESP.Options.SkeletonThickness = 2
MainESP.Options.Skeleton = true
```

## 🐛 Troubleshooting

### Common Issues

#### ESP Not Showing
```lua
-- Check if ESP is enabled
print(MainESP.Options.Enabled) -- Should be true

-- Enable basic features
MainESP.Options.Enabled = true
MainESP.Options.Box = true
MainESP.Options.Name = true
```

#### Performance Issues
```lua
-- Reduce visual complexity
MainESP.Options.Skeleton = false
MainESP.Options.Rainbow = false

-- Increase culling distance
CullingSystem.maxRenderDistance = 1000
```

#### Players Not Detected
```lua
-- Check if players have valid characters
for _, player in pairs(game.Players:GetPlayers()) do
    print(player.Name, player.Character ~= nil)
end

-- Verify team check settings
MainESP.Options.TeamCheck = false -- Show all players
```

#### Memory Issues
```lua
-- Manual cache cleanup
CacheManager:CleanupCaches()

-- Check cache sizes
print("Color cache size:", #MainESP._colorCache)
print("Position cache size:", #MainESP._positionCache)
```

### Debug Information
The system provides debug output for troubleshooting:
```lua
-- Enable debug mode (modify the script to show debug info)
-- Check console for performance metrics and cache cleanup messages
```

## 📊 Performance Metrics

### Typical Performance Impact
- **Low Impact**: Name, Distance, Box ESP
- **Medium Impact**: Tracers, Health bars, Direction
- **High Impact**: Skeleton, Rainbow colors

### Recommended Settings by Device

#### High-End Devices
```lua
-- Full features enabled
MainESP.Options.Enabled = true
MainESP.Options.Box = true
MainESP.Options.Health = true
MainESP.Options.Tracer = true
MainESP.Options.Name = true
MainESP.Options.Distance = true
MainESP.Options.Direction = true
MainESP.Options.Skeleton = true
```

#### Mid-Range Devices
```lua
-- Reduced feature set
MainESP.Options.Enabled = true
MainESP.Options.Box = true
MainESP.Options.Name = true
MainESP.Options.Distance = true
MainESP.Options.Tracer = true
-- Skeleton and Direction disabled for performance
```

#### Low-End Devices
```lua
-- Minimal feature set
MainESP.Options.Enabled = true
MainESP.Options.Box = true
MainESP.Options.Name = true
-- Most features disabled for maximum performance
```

## 🔄 Updates and Maintenance

### Cache Management
The system automatically manages memory usage through:
- Automatic cache cleanup every 10 seconds
- 30-second maximum cache age
- Intelligent cache key management

### Performance Monitoring
- Real-time FPS tracking
- Automatic update rate adjustment
- Performance metrics logging

## 🤝 Contributing

### Code Style Guidelines
- Use descriptive variable names
- Comment complex logic
- Follow existing naming conventions
- Test with multiple games

### Performance Considerations
- Always profile performance changes
- Consider memory usage impact
- Test on various device types
- Maintain backward compatibility

## 📝 License

This ESP system is provided as-is for educational and research purposes. Use responsibly and in accordance with Roblox Terms of Service.

## ⚠️ Disclaimer

This tool is intended for educational purposes and game development. Users are responsible for ensuring compliance with game rules and platform terms of service. The developers are not responsible for any consequences resulting from misuse of this tool.

---

*Last updated: 06/19/2025*