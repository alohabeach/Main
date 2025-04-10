local originalGameIndex
originalGameIndex = hookmetamethod(game, "__index", function(object, key)
    if checkcaller() and object == game then
        local success, service = pcall(function() return game:GetService(key) end)
        if success then return service end
    end

    return originalGameIndex(object, key)
end)

-- character utilities
local function getTeam(player)
    return player.Team.Name
end

local function isAlive(player)
    return player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

local function playerTP(...)
    if not isAlive(game.Players.LocalPlayer) then
        return false
    end

    local target = CFrame.new(...)

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target

    task.wait()

    return true
end

local function getPlayerPos(player)
    if not isAlive(player) then
        return Vector3.new()
    end

    return player.Character.HumanoidRootPart.Position
end

local function getDistance(...)
    if not isAlive(game.Players.LocalPlayer) then
        return 0
    end

    return (getPlayerPos(game.Players.LocalPlayer) - (CFrame.new(...).Position)).Magnitude
end

-- returns a list of objects ordered from the closest to the farthest from the player
local function getClosestObjs(objs)

    local sortedObjs = {}
    local distances = {}
    local list = (type(objs) == "userdata" and objs:IsA("Model") and objs:GetChildren()) or (type(objs) == "table" and objs) or {}

    -- insert distances and sort them from lowest to highest
    for _, instance in pairs(list) do
        local part = (instance:IsA("Model") and (instance.PrimaryPart or instance:FindFirstChildWhichIsA("BasePart"))) or (instance:IsA("BasePart") and instance)

        if part then
            table.insert(distances, math.floor(getDistance(part.Position)))
        end
    end

    table.sort(distances)

    -- loop through the objects again to get the actual objects in order
    for _, distance in pairs(distances) do
        for _, instance in pairs(list) do
            local part = (instance:IsA("Model") and (instance.PrimaryPart or instance:FindFirstChildWhichIsA("BasePart"))) or (instance:IsA("BasePart") and instance)

            if part and math.floor(getDistance(part.Position)) == distance then
                table.insert(sortedObjs, instance)
            end
        end
    end

    return sortedObjs
end

-- returns a list of all parts touching the ray
local function getPartsOnRay(origin, direction, filterList)
    local partsOnRay = {}
    local lastPart

    repeat
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        raycastParams.FilterDescendantsInstances = filterList

        local raycastResult = workspace:Raycast(origin, direction, raycastParams)
        lastPart = raycastResult

        if raycastResult then
            table.insert(partsOnRay, raycastResult.Instance)
            table.insert(filterList, raycastResult.Instance)
        end
    until not lastPart

    return partsOnRay
end

-- will check the specified positon for any collidable blocks blocking the path
local function isTargetBlocked(target, filterList)
    -- will not run if the player is dead
    if not isAlive(game.Players.LocalPlayer) then
        return true
    end

    -- get all parts hitting the ray
    local origin = getPlayerPos(game.Players.LocalPlayer)
    local direction = target - origin
    local hitParts = getPartsOnRay(origin, direction, filterList)

    -- filter out all parts that are non collidable
    local filtered = {}

    for i, v in pairs(hitParts) do
        if v:IsA("BasePart") and v.CanCollide then
            table.insert(filtered, v)
        end
    end

    -- return if there are parts blocking the target
    return #filtered > 0
end

-- recursively clones a table and all its elements
local function deepClone(original)
    if type(original) ~= "table" then
        return original
    end
    
    local copy = {}
    for key, value in pairs(original) do
        copy[deepClone(key)] = deepClone(value)
    end
    
    return copy
end