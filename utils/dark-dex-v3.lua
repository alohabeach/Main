local API = "http://localhost:1234/"

getgenv().decompile = function(script: Instance)
    local scriptBytecode = getscriptbytecode(script)
    if not scriptBytecode then return end

    local output = request({
        Url = `{API}decompile`,
        Method = "POST",
        Body = scriptBytecode,
    })

    if output.StatusCode == 200 then
        return output.Body
    end

    return `Failed to decompile bytecode\n{scriptBytecode}`
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua"))()