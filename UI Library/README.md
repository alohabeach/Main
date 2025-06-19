# Vigil UI Library

A modular, tween-based, drag-and-drop friendly UI framework for Roblox. Built with customization and script safety in mind, it uses a `SafeLoad` function to bypass common `CoreGui` protection in games like Da Hood or Peroxide.

---

## ✨ Features

- Secure loading via `SafeLoad`
- Tween-based transitions
- Drag & drop windows
- Fully modular page/section/component system
- Component types:
  - Label
  - Button
  - Keybind
  - Slider
  - Textbox
  - Dropdown (Single/Multi)
  - Toggle

---

## 🔧 Setup

```lua
local Vigil = loadstring(game:HttpGet("URL_TO_YOUR_VIGIL_FILE"))()

local Window = Vigil.new("Example UI", {
  Anchor = Vector2.new(0.5, 0.5),
  Size = UDim2.new(0, 600, 0, 526),
  Pos = UDim2.new(0.809, 0, 0.75, 0),
})

Vigil.init() -- Safely loads it into CoreGui
```

---

## 🧩 Structure

### Window Methods

```lua
Window:toggle()
Window:setPosition(UDim2)
Window:getPosition()
Window:addPage("Page Name")
```

---

### Page Methods

```lua
local page = Window:addPage("Main")
local section = page:addSection("Main Section")
```

---

### Section Methods

- **Add Label**
  ```lua
  section:addLabel({
    title = "Hello, world!",
  })
  ```

- **Add Button**
  ```lua
  section:addButton({
    title = "Click Me",
    callback = function()
      print("Clicked!")
    end,
  })
  ```

- **Add Keybind**
  ```lua
  section:addKeybind({
    title = "Open UI",
    default = Enum.KeyCode.RightControl,
    mode = "click",
    on_press = function(key) print("Pressed", key) end,
    on_update = function(newKey) print("Updated to", newKey) end,
  })
  ```

- **Add Slider**
  ```lua
  section:addSlider({
    title = "Volume",
    default = 50,
    min = 0,
    max = 100,
    decimals = false,
    suffix = "%",
    callback = function(value) print("Volume:", value) end,
  })
  ```

- **Add Textbox**
  ```lua
  section:addTextbox({
    title = "Enter Name",
    default = "alohabeach",
    callback = function(text) print("Name:", text) end,
  })
  ```

- **Add Dropdown**
  ```lua
  section:addDropdown({
    title = "Select Fruit",
    default = "Apple",
    list = {"Apple", "Banana", "Cherry"},
    mode = "single",
    callback = function(value) print("Selected:", value) end,
  })
  ```

- **Add Toggle**
  ```lua
  section:addToggle({
    title = "God Mode",
    toggled = false,
    callback = function(state) print("God Mode:", state) end,
  })
  ```

---

## 🧪 Example Script

```lua
local page = Window:addPage("Test Page")
local section = page:addSection("Controls")

section:addLabel({ title = "Vigil Loaded." })
section:addButton({
  title = "Print Hello",
  callback = function() print("Hello!") end
})
```

---

## ⚠️ Notes

- UI names are encrypted by default (`EncryptedString()`).
- Uses `cloneref` to avoid detection.
- Will try to insert into `CoreGui`, falls back to `PlayerGui`.

---

## 📜 License

MIT or Unlicensed. Free to use, modify, distribute.
