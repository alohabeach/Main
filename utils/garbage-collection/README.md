# Garbage Collection

### Overview

The `GarbageCollection` module provides a method for searching through the game's garbage collector to find functions and tables that match the provided criteria. It then sets the found functions or tables to specific names in the global environment. It will also kick the player with an error message if any of the items don't get found in the garbage collection that shows which items didn't get picked up.

### Function Definitions

#### `GarbageCollection:attemptCollection(maxAttempts, garbageInfo)`

Attempts to collect garbage based on the provided parameters.

- `maxAttempts` (number): The maximum number of collection attempts.
- `garbageInfo` (table): A table that contains detailed information about what garbage to collect, with fields for `tables` and `functions`.

  - `tables` (table): A table that contains information of what to look for. For example this network table is looking for a table that contains an element with a key of `FireServer` and a paired value type of `function`.
    - Example: `{ network = { FireServer = "function" } }`
  
  - `functions` (table): A table of functions that need to be found. For example this will look for a function that is in the `ItemSystem` script and a function name of `handleEquipped` which will then be set to the global environment as `handleEquippedCollected`.
    - Example: `{ handleEquippedCollected = { script = services.ReplicatedStorage.Game.ItemSystem.ItemSystem, functionName = "handleEquipped" } }`

Returns: None.

### Example comparison for [Jailbreak](https://www.roblox.com/games/606849621/Jailbreak)
```lua
local LocalScript = game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript

loadstring(game:HttpGet("https://raw.githubusercontent.com/alohabeach/Main/refs/heads/master/utils/garbage-collection/source.lua"))():attemptCollection(10, {
    tables = {
        network = { FireServer = "function" },
    },
    functions = {
        openHatch = {
            script = LocalScript,
            functionName = "Action",
            constants = { "FireServer", "SewerHatch" },
        },
    }
})
```


```lua
local LocalScript = game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript

for _, garbage in pairs(getgc(true)) do
    if type(garbage) == "function" and islclosure(garbage) then
        local constants, info, script = getconstants(garbage), getinfo(garbage), getfenv(garbage).script

        if table.find(constants, "FireServer") and table.find(constants, "SewerHatch") and info.name == "Action" and script == LocalScript then
            getgenv().openHatch = garbage
        end
    elseif type(garbage) == "table" then
        if rawget(garbage, "FireServer") and type(garbage.FireServer) == "Function" then
            getgenv().network = garbage
        end
    end
end
```
---

## License

This code is free to use and modify with credit to the original creator.
