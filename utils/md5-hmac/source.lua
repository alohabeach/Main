local md5 = {}
local hmac = {}

do
    -- MD5 Algorithm Constants
    local MD5_BLOCK_SIZE_BYTES = 64
    local MD5_DIGEST_SIZE_BYTES = 16
    local MD5_PADDING_TRIGGER_BYTE = 0x80
    local MD5_PADDING_FILL_BYTE = 0x00
    local MD5_LENGTH_FIELD_SIZE_BYTES = 8
    local MD5_LENGTH_FIELD_OFFSET = 56
    local BITS_PER_BYTE = 8
    local BITS_IN_32BIT_WORD = 32
    local BITMASK_32BIT = 0xFFFFFFFF
    local BITMASK_16BIT = 0xFFFF
    local BITMASK_8BIT = 0xFF
    local HEX_FORMAT_SPECIFIER = "%02x"
    
    -- MD5 Initial hash values (A, B, C, D)
    local MD5_INITIAL_STATE_A = 0x67452301
    local MD5_INITIAL_STATE_B = 0xEFCDAB89
    local MD5_INITIAL_STATE_C = 0x98BADCFE
    local MD5_INITIAL_STATE_D = 0x10325476
    
    -- MD5 constants (T table: sine-based constants for each round)
    local MD5_ROUND_CONSTANTS = {
        0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee, 0xf57c0faf, 0x4787c62a, 0xa8304613, 0xfd469501,
        0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be, 0x6b901122, 0xfd987193, 0xa679438e, 0x49b40821,
        0xf61e2562, 0xc040b340, 0x265e5a51, 0xe9b6c7aa, 0xd62f105d, 0x02441453, 0xd8a1e681, 0xe7d3fbc8,
        0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed, 0xa9e3e905, 0xfcefa3f8, 0x676f02d9, 0x8d2a4c8a,
        0xfffa3942, 0x8771f681, 0x6d9d6122, 0xfde5380c, 0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70,
        0x289b7ec6, 0xeaa127fa, 0xd4ef3085, 0x04881d05, 0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665,
        0xf4292244, 0x432aff97, 0xab9423a7, 0xfc93a039, 0x655b59c3, 0x8f0ccc92, 0xffeff47d, 0x85845dd1,
        0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1, 0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391,
    }

    -- MD5 left rotation shift amounts per round (s values)
    local MD5_SHIFT_AMOUNTS = {
        7,12,17,22, 7,12,17,22, 7,12,17,22, 7,12,17,22,
        5,9,14,20, 5,9,14,20, 5,9,14,20, 5,9,14,20,
        4,11,16,23, 4,11,16,23, 4,11,16,23, 4,11,16,23,
        6,10,15,21, 6,10,15,21, 6,10,15,21, 6,10,15,21,
    }
    
    -- MD5 round boundaries
    local MD5_ROUND_1_END = 15
    local MD5_ROUND_2_END = 31
    local MD5_ROUND_3_END = 47
    local MD5_TOTAL_ROUNDS = 64
    
    -- MD5 message schedule indexing constants
    local MD5_MESSAGE_SCHEDULE_SIZE = 16
    local MD5_ROUND_2_G_MULTIPLIER = 5
    local MD5_ROUND_2_G_OFFSET = 1
    local MD5_ROUND_3_G_MULTIPLIER = 3
    local MD5_ROUND_3_G_OFFSET = 5
    local MD5_ROUND_4_G_MULTIPLIER = 7
    
    -- Byte position constants for little-endian conversion
    local BYTE_POSITION_0 = 0
    local BYTE_POSITION_1 = 8
    local BYTE_POSITION_2 = 16
    local BYTE_POSITION_3 = 24
    
    -- Chunk processing constants
    local BYTES_PER_WORD = 4
    local WORD_BYTE_OFFSET_0 = 1
    local WORD_BYTE_OFFSET_1 = 2
    local WORD_BYTE_OFFSET_2 = 3
    local WORD_BYTE_OFFSET_3 = 4

    -- bit helpers (using bit32 available in Luau/Roblox)
    local bitwiseAnd = bit32.band
    local bitwiseOr = bit32.bor
    local bitwiseXor = bit32.bxor
    local bitwiseNot = bit32.bnot
    local leftShift = bit32.lshift
    local rightShift = bit32.rshift

    local function toUnsigned32Bit(value)
        return bitwiseAnd(value, BITMASK_32BIT)
    end

    local function add32BitValues(valueA, valueB)
        -- safe 32-bit addition
        -- split into 16-bit halves to avoid Lua number issues
        local lowHalf = (bitwiseAnd(valueA, BITMASK_16BIT) + bitwiseAnd(valueB, BITMASK_16BIT))
        local highHalf = rightShift(valueA, 16) + rightShift(valueB, 16) + rightShift(lowHalf, 16)
        return toUnsigned32Bit(bitwiseOr(leftShift(highHalf, 16), bitwiseAnd(lowHalf, BITMASK_16BIT)))
    end

    local function rotateLeft32Bit(value, bitCount)
        bitCount = bitCount % BITS_IN_32BIT_WORD
        -- ensure 32-bit result
        local leftPart = leftShift(value, bitCount)
        local rightPart = rightShift(value, BITS_IN_32BIT_WORD - bitCount)
        return toUnsigned32Bit(bitwiseOr(leftPart, rightPart))
    end

    -- MD5 auxiliary functions (F, G, H, I for each round)
    local function md5FunctionF(x, y, z)
        return bitwiseOr(bitwiseAnd(x, y), bitwiseAnd(bitwiseNot(x), z))
    end
    
    local function md5FunctionG(x, y, z)
        return bitwiseOr(bitwiseAnd(x, z), bitwiseAnd(y, bitwiseNot(z)))
    end
    
    local function md5FunctionH(x, y, z)
        return bitwiseXor(x, bitwiseXor(y, z))
    end
    
    local function md5FunctionI(x, y, z)
        return bitwiseXor(y, bitwiseOr(x, bitwiseNot(z)))
    end

    -- process a single 64-byte chunk
    local function processChunk(blockData, hashState)
        -- prepare message schedule (16 x 32-bit words from block)
        local messageSchedule = {}
        for wordIndex = 0, MD5_MESSAGE_SCHEDULE_SIZE - 1 do
            local byte1 = string.byte(blockData, wordIndex * BYTES_PER_WORD + WORD_BYTE_OFFSET_0)
            local byte2 = string.byte(blockData, wordIndex * BYTES_PER_WORD + WORD_BYTE_OFFSET_1)
            local byte3 = string.byte(blockData, wordIndex * BYTES_PER_WORD + WORD_BYTE_OFFSET_2)
            local byte4 = string.byte(blockData, wordIndex * BYTES_PER_WORD + WORD_BYTE_OFFSET_3)
            -- little-endian conversion
            messageSchedule[wordIndex] = bitwiseOr(
                byte1 or 0,
                leftShift(byte2 or 0, BYTE_POSITION_1),
                leftShift(byte3 or 0, BYTE_POSITION_2),
                leftShift(byte4 or 0, BYTE_POSITION_3)
            )
        end

        local registerA = hashState[1]
        local registerB = hashState[2]
        local registerC = hashState[3]
        local registerD = hashState[4]

        for roundIndex = 0, MD5_TOTAL_ROUNDS - 1 do
            local functionResult, messageScheduleIndex
            
            if roundIndex <= MD5_ROUND_1_END then
                -- Round 1: F function
                functionResult = md5FunctionF(registerB, registerC, registerD)
                messageScheduleIndex = roundIndex
            elseif roundIndex <= MD5_ROUND_2_END then
                -- Round 2: G function
                functionResult = md5FunctionG(registerB, registerC, registerD)
                messageScheduleIndex = (MD5_ROUND_2_G_MULTIPLIER * roundIndex + MD5_ROUND_2_G_OFFSET) % MD5_MESSAGE_SCHEDULE_SIZE
            elseif roundIndex <= MD5_ROUND_3_END then
                -- Round 3: H function
                functionResult = md5FunctionH(registerB, registerC, registerD)
                messageScheduleIndex = (MD5_ROUND_3_G_MULTIPLIER * roundIndex + MD5_ROUND_3_G_OFFSET) % MD5_MESSAGE_SCHEDULE_SIZE
            else
                -- Round 4: I function
                functionResult = md5FunctionI(registerB, registerC, registerD)
                messageScheduleIndex = (MD5_ROUND_4_G_MULTIPLIER * roundIndex) % MD5_MESSAGE_SCHEDULE_SIZE
            end

            -- temp = A + f + K[i] + M[g]
            local tempValue = add32BitValues(registerA, functionResult)
            tempValue = add32BitValues(tempValue, MD5_ROUND_CONSTANTS[roundIndex + 1])
            tempValue = add32BitValues(tempValue, messageSchedule[messageScheduleIndex])

            -- rotate and add
            tempValue = rotateLeft32Bit(tempValue, MD5_SHIFT_AMOUNTS[roundIndex + 1])
            tempValue = add32BitValues(registerB, tempValue)

            -- rotate registers (A, D, C, B = D, C, B, temp)
            registerA, registerD, registerC, registerB = registerD, registerC, registerB, tempValue
        end

        hashState[1] = toUnsigned32Bit(add32BitValues(hashState[1], registerA))
        hashState[2] = toUnsigned32Bit(add32BitValues(hashState[2], registerB))
        hashState[3] = toUnsigned32Bit(add32BitValues(hashState[3], registerC))
        hashState[4] = toUnsigned32Bit(add32BitValues(hashState[4], registerD))
    end

    local function convertUInt32ToLittleEndianBytes(value)
        return string.char(
            bitwiseAnd(value, BITMASK_8BIT),
            bitwiseAnd(rightShift(value, BYTE_POSITION_1), BITMASK_8BIT),
            bitwiseAnd(rightShift(value, BYTE_POSITION_2), BITMASK_8BIT),
            bitwiseAnd(rightShift(value, BYTE_POSITION_3), BITMASK_8BIT)
        )
    end

    -- one-shot MD5 (binary 16 bytes)
    function md5.sum(message)
        if type(message) ~= "string" then
            error("md5.sum expects a string")
        end

        -- initial hash state (A, B, C, D)
        local hashState = {
            MD5_INITIAL_STATE_A,
            MD5_INITIAL_STATE_B,
            MD5_INITIAL_STATE_C,
            MD5_INITIAL_STATE_D,
        }

        -- padding: append 0x80, then 0x00 until message length (mod 64) == 56,
        -- then append 8-byte little-endian length (bits)
        local messageLengthBytes = #message
        local messageLengthBits = (messageLengthBytes * BITS_PER_BYTE) % (2^64)

        local paddedMessage = message .. string.char(MD5_PADDING_TRIGGER_BYTE)
        while (#paddedMessage % MD5_BLOCK_SIZE_BYTES) ~= MD5_LENGTH_FIELD_OFFSET do
            paddedMessage = paddedMessage .. string.char(MD5_PADDING_FILL_BYTE)
        end

        -- append 64-bit little-endian length
        for byteIndex = 0, MD5_LENGTH_FIELD_SIZE_BYTES - 1 do
            paddedMessage = paddedMessage .. string.char(
                bitwiseAnd(rightShift(messageLengthBits, byteIndex * BITS_PER_BYTE), BITMASK_8BIT)
            )
        end

        -- process each 64-byte chunk
        for chunkStart = 1, #paddedMessage, MD5_BLOCK_SIZE_BYTES do
            local blockData = paddedMessage:sub(chunkStart, chunkStart + MD5_BLOCK_SIZE_BYTES - 1)
            processChunk(blockData, hashState)
        end

        -- output little-endian A,B,C,D as bytes
        return convertUInt32ToLittleEndianBytes(hashState[1]) ..
               convertUInt32ToLittleEndianBytes(hashState[2]) ..
               convertUInt32ToLittleEndianBytes(hashState[3]) ..
               convertUInt32ToLittleEndianBytes(hashState[4])
    end

    function md5.sumhexa(message)
        local binaryDigest = md5.sum(message)
        return (binaryDigest:gsub(".", function(char)
            return string.format(HEX_FORMAT_SPECIFIER, string.byte(char))
        end))
    end

    -- Streaming / incremental MD5 context
    function md5.new()
        local context = {}
        context._hashState = {
            MD5_INITIAL_STATE_A,
            MD5_INITIAL_STATE_B,
            MD5_INITIAL_STATE_C,
            MD5_INITIAL_STATE_D,
        }
        context._dataBuffer = ""       -- accumulated partial chunk
        context._totalBytesProcessed = 0        -- total message length in bytes

        function context:update(dataChunk)
            if type(dataChunk) ~= "string" then
                error("md5:update expects a string")
            end
            context._totalBytesProcessed = context._totalBytesProcessed + #dataChunk
            context._dataBuffer = context._dataBuffer .. dataChunk

            while #context._dataBuffer >= MD5_BLOCK_SIZE_BYTES do
                local blockData = context._dataBuffer:sub(1, MD5_BLOCK_SIZE_BYTES)
                processChunk(blockData, context._hashState)
                context._dataBuffer = context._dataBuffer:sub(MD5_BLOCK_SIZE_BYTES + 1)
            end
            return context
        end

        function context:finish()
            -- prepare padding based on total length
            local totalBitsProcessed = (context._totalBytesProcessed * BITS_PER_BYTE) % (2^64)
            local paddingData = string.char(MD5_PADDING_TRIGGER_BYTE)

            local currentBufferLength = (#context._dataBuffer + 1) % MD5_BLOCK_SIZE_BYTES
            local requiredPaddingLength = (currentBufferLength <= MD5_LENGTH_FIELD_OFFSET)
                and (MD5_LENGTH_FIELD_OFFSET - currentBufferLength)
                or (MD5_LENGTH_FIELD_OFFSET + MD5_BLOCK_SIZE_BYTES - currentBufferLength)
                
            if requiredPaddingLength > 0 then
                paddingData = paddingData .. string.rep(string.char(MD5_PADDING_FILL_BYTE), requiredPaddingLength)
            end

            -- append length little-endian (8 bytes)
            for byteIndex = 0, MD5_LENGTH_FIELD_SIZE_BYTES - 1 do
                paddingData = paddingData .. string.char(
                    bitwiseAnd(rightShift(totalBitsProcessed, byteIndex * BITS_PER_BYTE), BITMASK_8BIT)
                )
            end

            -- process final blocks
            local finalMessage = context._dataBuffer .. paddingData
            for chunkStart = 1, #finalMessage, MD5_BLOCK_SIZE_BYTES do
                local blockData = finalMessage:sub(chunkStart, chunkStart + MD5_BLOCK_SIZE_BYTES - 1)
                processChunk(blockData, context._hashState)
            end

            -- produce final digest
            local digest =
                convertUInt32ToLittleEndianBytes(context._hashState[1]) ..
                convertUInt32ToLittleEndianBytes(context._hashState[2]) ..
                convertUInt32ToLittleEndianBytes(context._hashState[3]) ..
                convertUInt32ToLittleEndianBytes(context._hashState[4])

            return digest
        end

        function context:hexdigest()
            return (context:finish():gsub('.', function(char)
                return string.format(HEX_FORMAT_SPECIFIER, string.byte(char))
            end))
        end

        return context
    end
end

-- HMAC helpers
do
    -- HMAC constants
    local HMAC_BLOCK_SIZE_BYTES = 64
    local HMAC_OPAD_XOR_VALUE = 0x5C
    local HMAC_IPAD_XOR_VALUE = 0x36

    -- MD5 Algorithm Constants
    local MD5_PADDING_FILL_BYTE = 0x00

    -- generic HMAC: key (string), message (string), hashFunction -> returns binary digest
    -- hashFunction should be a function that returns binary digest for given message (e.g., md5.sum)
    function hmac.new(key, message, hashFunction)
        if type(key) ~= "string" or type(message) ~= "string" or type(hashFunction) ~= "function" then
            error("hmac.new expects (string, string, function)")
        end

        -- if key is longer than block size, hash it first
        if #key > HMAC_BLOCK_SIZE_BYTES then
            key = hashFunction(key)
        end

        -- pad key to block size
        if #key < HMAC_BLOCK_SIZE_BYTES then
            key = key .. string.rep(string.char(MD5_PADDING_FILL_BYTE), HMAC_BLOCK_SIZE_BYTES - #key)
        end

        local outerKeyPad = {}
        local innerKeyPad = {}
        for byteIndex = 1, HMAC_BLOCK_SIZE_BYTES do
            local keyByte = string.byte(key, byteIndex)
            outerKeyPad[byteIndex] = string.char(bit32.bxor(keyByte, HMAC_OPAD_XOR_VALUE))
            innerKeyPad[byteIndex] = string.char(bit32.bxor(keyByte, HMAC_IPAD_XOR_VALUE))
        end
        outerKeyPad = table.concat(outerKeyPad)
        innerKeyPad = table.concat(innerKeyPad)

        local innerHashInput = innerKeyPad .. message
        local innerHashResult = hashFunction(innerHashInput)
        return hashFunction(outerKeyPad .. innerHashResult)
    end

    function hmac.md5(key, message)
        return hmac.new(key, message, md5.sum)
    end

    function hmac.md5hexa(key, message)
        return (hmac.md5(key, message):gsub(".", function(char)
            return string.format(HEX_FORMAT_SPECIFIER, string.byte(char))
        end))
    end
end

-- return modules
return {
    md5 = md5,
    hmac = hmac,
}
