local Base64 = {}

Base64.characterSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

function Base64:encode(input)
    assert(type(self) == "table", "invalid argument #1 to 'encode' (expected ':' not '.')")
    assert(typeof(input) == "string", "invalid argument #2 to 'encode' (string expected, got " .. typeof(input) .. ")")

    -- Convert each character to 8-bit binary
    local binaryString = input:gsub('.', function(character)
        local binary = ''
        local ascii = character:byte()
        for bitIndex = 8, 1, -1 do
            binary = binary .. ((ascii % 2^bitIndex - ascii % 2^(bitIndex - 1) > 0) and '1' or '0')
        end
        return binary
    end)

    -- Pad binary string and encode in chunks of 6 bits
    binaryString = binaryString .. '0000'
    local encoded = binaryString:gsub('%d%d%d?%d?%d?%d?', function(bits)
        if #bits < 6 then return '' end
        local value = 0
        for i = 1, 6 do
            if bits:sub(i, i) == '1' then
                value = value + 2^(6 - i)
            end
        end
        return self.characterSet:sub(value + 1, value + 1)
    end)

    -- Add padding
    local padding = ({ '', '==', '=' })[#input % 3 + 1]
    return encoded .. padding
end

function Base64:decode(input)
    assert(type(self) == "table", "invalid argument #1 to 'decode' (expected ':' not '.')")
    assert(typeof(input) == "string", "invalid argument #2 to 'decode' (string expected, got " .. typeof(input) .. ")")

    -- Remove invalid characters
    input = input:gsub('[^' .. self.characterSet .. '=]', '')

    -- Convert each character to 6-bit binary
    local binaryString = input:gsub('.', function(character)
        if character == '=' then return '' end
        local index = self.characterSet:find(character) - 1
        local binary = ''
        for bitIndex = 6, 1, -1 do
            binary = binary .. ((index % 2^bitIndex - index % 2^(bitIndex - 1) > 0) and '1' or '0')
        end
        return binary
    end)

    -- Convert binary back to ASCII characters
    return binaryString:gsub('%d%d%d?%d?%d?%d?%d?%d?', function(bits)
        if #bits ~= 8 then return '' end
        local ascii = 0
        for i = 1, 8 do
            if bits:sub(i, i) == '1' then
                ascii = ascii + 2^(8 - i)
            end
        end
        return string.char(ascii)
    end)
end

return Base64