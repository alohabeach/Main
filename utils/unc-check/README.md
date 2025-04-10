# Function Integrity Check

### Overview

This script checks the integrity of functions in the Lua environment to ensure they exist and are working as expected. It verifies that the listed functions are available and functional, checking their integrity by ensuring they can be called properly without errors. You may remove or add to the list based on which functions your script actually needs.

### Example Usage

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/alohabeach/Main/refs/heads/master/utils/unc-check/source.lua"))()({
    "getgc",
    "hookfunction",
    "islclosure",
    "newcclosure",
    "debug.getinfo",
    "debug.getconstants",
    "debug.getupvalues",
    "debug.setupvalue",
    "debug.traceback",
    "getgenv",
    "loadstring",
    "hookmetamethod",
    "clonefunction",
    "readfile",
    "writefile",
    "delfile",
    "makefolder",
    "delfolder",
    "isfolder",
    "isfile",
    "fireclickdetector",
    "getconnections",
})
```
---

## License

This code is free to use and modify with credit to the original creator.
