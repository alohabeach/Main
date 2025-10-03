# MD5 + HMAC for Luau

### Overview

The `md5_hmac` module provides a drop-in MD5 hashing and HMAC (Hash-based Message Authentication Code) implementation for Luau/Roblox environments. It offers both one-shot and streaming interfaces for MD5 hashing, along with HMAC functions for message authentication. All operations are performed using pure Lua with bit32 operations, making it compatible with Luau's sandboxed environment.

### Function Definitions

#### MD5 Functions

##### `md5.sum(message)`

Computes the MD5 hash of a message in one shot.

- `message` (string): The input message to hash.

Returns: A binary 16-byte MD5 digest string.

##### `md5.sumhexa(message)`

Computes the MD5 hash of a message and returns it as a hexadecimal string.

- `message` (string): The input message to hash.

Returns: A 32-character hexadecimal string representation of the MD5 digest.

##### `md5.new()`

Creates a new MD5 context for streaming/incremental hashing.

Returns: A context object with the following methods:
- `context:update(chunk)`: Adds data to the hash. Can be called multiple times.
  - `chunk` (string): Data to add to the hash.
  - Returns: The context object (for method chaining).
- `context:finish()`: Finalizes the hash and returns the binary digest.
  - Returns: A binary 16-byte MD5 digest string.
- `context:hexdigest()`: Finalizes the hash and returns the hexadecimal digest.
  - Returns: A 32-character hexadecimal string.

#### HMAC Functions

##### `hmac.new(key, message, hashFunction)`

Computes HMAC using a custom hash function.

- `key` (string): The secret key for authentication.
- `message` (string): The message to authenticate.
- `hashFunction` (function): A hash function that takes a string and returns a binary digest.

Returns: A binary HMAC digest.

##### `hmac.md5(key, message)`

Computes HMAC-MD5 of a message.

- `key` (string): The secret key for authentication.
- `message` (string): The message to authenticate.

Returns: A binary 16-byte HMAC-MD5 digest.

##### `hmac.md5hexa(key, message)`

Computes HMAC-MD5 of a message and returns it as a hexadecimal string.

- `key` (string): The secret key for authentication.
- `message` (string): The message to authenticate.

Returns: A 32-character hexadecimal string representation of the HMAC-MD5 digest.

### Example Usage

#### Basic MD5 Hashing

```lua
local crypto = require(script.md5_hmac)

-- One-shot hashing (hexadecimal output)
local hash = crypto.md5.sumhexa("Hello, World!")
print(hash) -- "65a8e27d8879283831b664bd8b7f0ad4"

-- One-shot hashing (binary output)
local binaryHash = crypto.md5.sum("Hello, World!")
print(#binaryHash) -- 16
```

#### Streaming MD5 Hashing

```lua
local crypto = require(script.md5_hmac)

-- Create a context for incremental hashing
local ctx = crypto.md5.new()

-- Add data in chunks
ctx:update("Hello, ")
ctx:update("World!")

-- Get the final hash
local hash = ctx:hexdigest()
print(hash) -- "65a8e27d8879283831b664bd8b7f0ad4"
```

#### HMAC Authentication

```lua
local crypto = require(script.md5_hmac)

local secretKey = "my-secret-key"
local message = "Important message"

-- Compute HMAC-MD5 (hexadecimal)
local mac = crypto.hmac.md5hexa(secretKey, message)
print(mac) -- HMAC signature as hex string

-- Compute HMAC-MD5 (binary)
local binaryMac = crypto.hmac.md5(secretKey, message)
print(#binaryMac) -- 16
```

#### Custom Hash Function with HMAC

```lua
local crypto = require(script.md5_hmac)

-- Define a custom hash function
local function customHash(data)
    return crypto.md5.sum(data)
end

-- Use HMAC with custom hash
local mac = crypto.hmac.new("secret", "message", customHash)
```

### Use Cases

- **Data Integrity**: Verify that data hasn't been tampered with during transmission
- **Message Authentication**: Ensure messages come from a trusted source using HMAC
- **Non-Cryptographic Hashing**: Generate checksums for game assets or save data
- **API Signatures**: Sign API requests for game backend communication

### Important Notes

- This implementation is suitable for checksums and non-cryptographic purposes
- MD5 is **not cryptographically secure** for password hashing or sensitive security applications
- For secure password storage, use bcrypt or similar algorithms
- The module uses bit32 operations available in Luau/Roblox environments

---

## License

MIT or Unlicensed. Free to use, modify, distribute.
