# Thread Module Documentation

The Thread Module is a framework for creating and managing threads in Lua. It supports two types of threads:
1. **Coroutine-based Threads**: Useful for timed operations that execute at intervals.
2. **RunService-based Threads**: Integrates with Roblox’s `RunService` events (“RenderStepped”, “Stepped”, “Heartbeat”).

---

## Functions

### thread:new
**Description**: Creates a new thread with the specified type, wait time, and callback function.

**Parameters**:
- `threadType` ("coroutine" | "RenderStepped" | "Stepped" | "Heartbeat"): The type of thread to create.
- `waitTime` (number, optional): Time interval for coroutine-based threads. Ignored for RunService threads.
- `callback` (function): The function executed when the thread is running.

**Returns**:
- A thread instance (table).

**Example Usage**:
```lua
local myThread = thread:new("coroutine", 1, function()
    print("Running thread!")
end)
```

---

### thread:setEnabled
**Description**: Enables or disables the thread's execution.

**Parameters**:
- `enabled` (boolean): Whether to enable or disable the thread.

**Returns**:
- The thread instance (table) for chaining.

**Example Usage**:
```lua
local myThread = thread:new("RenderStepped", nil, function()
    print("Rendering!")
end)
myThread:setEnabled(true)
```

---

### thread:destroy
**Description**: Stops and cleans up the thread, releasing resources.

**Parameters**:
- None.

**Returns**:
- The destroyed thread instance (table).

**Example Usage**:
```lua
local myThread = thread:new("Stepped", nil, function()
    print("Stepped event!")
end)
myThread:setEnabled(true):destroy()
```

---

## Internal Methods

### thread._checkArgs
**Description**: Validates function arguments against expected types.

**Parameters**:
- `args` (table): Arguments to validate.
- `expected` (table): Expected types for each argument.

---

### thread:_insertSelf
**Description**: Copies thread methods into a new thread instance.

**Parameters**:
- `newThread` (table): The new thread object.

**Returns**:
- The modified thread object (table).

---

## Chaining Functions

Thread methods are designed to support chaining for clean and efficient usage. For instance:

```lua
local myThread = thread:new("coroutine", 0.5, function()
    print("Thread running!")
end)

myThread:setEnabled(true):destroy()
```

In this example:
1. A coroutine thread is created with a 0.5-second wait interval.
2. The thread is enabled.
3. The thread is destroyed, cleaning up resources.

