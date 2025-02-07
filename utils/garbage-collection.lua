--- Custom Kick Message ---
local function customKick(title, message)
    local LocalPlayer = game.GetService(game, "Players").LocalPlayer
    LocalPlayer.Kick(LocalPlayer, message)

    local prompt = game.CoreGui.RobloxPromptGui.promptOverlay.ErrorPrompt
    prompt.TitleFrame.ErrorTitle.Text = title
    prompt.MessageArea.ErrorFrame.ErrorMessage.Text = message
end



--- Garbage Collection ---
local garbageCollection = {}

function garbageCollection:attemptCollection(garbageInfo, maxAttempts)
    local failedCollections

    for _ = 0, maxAttempts or 1 do
        failedCollections = {}

        for _, garbage in pairs(getgc(true)) do
            if type(garbage) == "function" and islclosure(garbage) then
                local constants = getconstants(garbage)
                local upvalues = getupvalues(garbage)
                local environment = getfenv(garbage)
                local info = getinfo(garbage)

                for name, details in pairs(garbageInfo.functions) do
                    if environment.script ~= details.script then continue end
                    if details.functionName and info.name ~= details.functionName then
                        continue
                    end

                    if details.constants and #details.constants > 0 then
                        local allConstantsMatch = true
                        for _, constant in ipairs(details.constants) do
                            if not table.find(constants, constant) then
                                allConstantsMatch = false
                                break
                            end
                        end
                        if not allConstantsMatch then continue end
                    end

                    if details.upvalues and #details.upvalues > 0 then
                        local allUpvaluesMatch = true
                        for _, upvalue in ipairs(details.upvalues) do
                            if not table.find(upvalues, upvalue) then
                                allUpvaluesMatch = false
                                break
                            end
                        end

                        if not allUpvaluesMatch then continue end
                    end

                    getgenv()[name] = garbage
                    break
                end
            elseif type(garbage) == "table" then
                for name, info in pairs(garbageInfo.tables) do
                    local allRawGetsMatch = true
                    for key, typeCheck in pairs(info) do
                        if not rawget(garbage, key) or type(rawget(garbage, key)) ~= typeCheck then
                            allRawGetsMatch = false
                            break
                        end
                    end
                    if not allRawGetsMatch then continue end

                    getgenv()[name] = garbage
                    break
                end
            end
        end

        for _, garbageTypes in pairs(garbageInfo) do
            for garbageName in pairs(garbageTypes) do
                if not getgenv()[garbageName] then
                    table.insert(failedCollections, garbageName)
                end
            end
        end

        if #failedCollections == 0 then break end
    end

    if #failedCollections > 0 then
        customKick("Garbage Collection Failed", "Please screenshot and report this in the discord\nFailed to collect the following:\n\n"..table.concat(failedCollections, ", "))
    end
end

return garbageCollection