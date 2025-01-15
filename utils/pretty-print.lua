local function robloxTypeToString(value)
    if value == nil then
        return "nil"
    elseif typeof(value) == "Vector3" then
        return string.format("Vector3.new(%.2f, %.2f, %.2f)", value.X, value.Y, value.Z)
    elseif typeof(value) == "Color3" then
        return string.format("Color3.new(%.2f, %.2f, %.2f)", value.R, value.G, value.B)
    elseif typeof(value) == "UDim2" then
        return string.format("UDim2.new(%f, %d, %f, %d)",
            value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset)
    elseif typeof(value) == "Instance" then
        return value:GetFullName()
    elseif typeof(value) == "string" then
        return `"{value}"`
    elseif typeof(value) == "ColorSequenceKeypoint" then
        return string.format("ColorSequenceKeypoint.new(%.2f, Color3.new(%.2f, %.2f, %.2f))",
            value.Time, value.Value.R, value.Value.G, value.Value.B)
    elseif typeof(value) == "NumberRange" then
        return string.format("NumberRange.new(%.2f, %.2f)", value.Min, value.Max)
    elseif typeof(value) == "NumberSequenceKeypoint" then
        return string.format("NumberSequenceKeypoint.new(%.2f, %.2f, %.2f)",
            value.Time, value.Value, value.Envelope)
    elseif typeof(value) == "PhysicalProperties" then
        return string.format("PhysicalProperties.new(%.2f, %.2f, %.2f, %.2f, %.2f)", 
            value.Density, value.Friction, value.Elasticity, value.FrictionWeight, value.ElasticityWeight)
    elseif typeof(value) == "Ray" then
        return string.format("Ray.new(Vector3.new(%.2f, %.2f, %.2f), Vector3.new(%.2f, %.2f, %.2f))",
            value.Origin.X, value.Origin.Y, value.Origin.Z,
            value.Direction.X, value.Direction.Y, value.Direction.Z)
    elseif typeof(value) == "Rect" then
        return string.format("Rect.new(%.2f, %.2f, %.2f, %.2f)", value.Min.X, value.Min.Y, value.Max.X, value.Max.Y)
    elseif typeof(value) == "Region3" then
        return string.format("Region3.new(Vector3.new(%.2f, %.2f, %.2f), Vector3.new(%.2f, %.2f, %.2f))",
            value.CFrame.Position.X - value.Size.X / 2, value.CFrame.Position.Y - value.Size.Y / 2, value.CFrame.Position.Z - value.Size.Z / 2,
            value.CFrame.Position.X + value.Size.X / 2, value.CFrame.Position.Y + value.Size.Y / 2, value.CFrame.Position.Z + value.Size.Z / 2)
    elseif typeof(value) == "TweenInfo" then
        return string.format("TweenInfo.new(%.2f, %s, %s, %d, %s, %.2f)",
            value.Time, tostring(value.EasingStyle), tostring(value.EasingDirection), value.RepeatCount, tostring(value.Reverses), value.DelayTime)
    elseif typeof(value) == "UDim" then
        return string.format("UDim.new(%.2f, %d)", value.Scale, value.Offset)
    elseif typeof(value) == "Vector2" then
        return string.format("Vector2.new(%.2f, %.2f)", value.X, value.Y)
    elseif typeof(value) == "Vector2int16" then
        return string.format("Vector2int16.new(%d, %d)", value.X, value.Y)
    elseif typeof(value) == "Vector3" then
        return string.format("Vector3.new(%.2f, %.2f, %.2f)", value.X, value.Y, value.Z)
    elseif typeof(value) == "Vector3int16" then
        return string.format("Vector3int16.new(%d, %d, %d)", value.X, value.Y, value.Z)
    elseif typeof(value) == "function" then
        local info = getinfo(value)
        local environment = getfenv(value)
        local scriptPath = (environment.script and environment.script.Parent and environment.script:GetFullName()) or ""
        return string.format("function_info = { name = %s, numparams = %d, source = %s }", info.name, info.numparams, scriptPath)
    else
        return tostring(value)
    end
end

local function fancyFormat(value: any, recursions: number): string
    recursions = recursions or 0

    if type(value) ~= "table" then
        return robloxTypeToString(value)
    end

    local padding = string.rep("  ", recursions)
    if recursions >= 20 then
        print("Reached recursion limit")
        return
    end

    local length = 0
    for _ in pairs(value) do
        length += 1
    end
    if length == 0 then
        return "{}"
    end

    local stringValue = "{"..(length == 1 and "" or "\n")
    for key, subValue in pairs(value) do
        if length == 1 then
            stringValue = stringValue .. ` [{type(key) == "string" and `"{key}"` or key}] = {fancyFormat(subValue, recursions + 1)}`..(length == 1 and " " or "\n")
        else
            stringValue = stringValue .. `{padding}  [{type(key) == "string" and `"{key}"` or key}] = {fancyFormat(subValue, recursions + 1)},\n`
        end
    end
    stringValue = stringValue .. (length == 1 and "" or padding) .. "}"

    return stringValue
end

local function printFancyFormat(formattedInput: string)
    for _, stringValue in pairs(formattedInput:split("\n")) do
        print(stringValue)
    end
end

local testFunc
for _, garbage in pairs(getgc()) do
    if type(garbage) == "function" and islclosure(garbage) then
        testFunc = garbage
    end
end

local testCase = {
    nilValue = nil,
    vector3Value = Vector3.new(1.5, 2.5, 3.5),
    color3Value = Color3.new(0.1, 0.2, 0.3),
    udim2Value = UDim2.new(0.5, 10, 0.5, 20),
    instanceValue = game.Workspace,
    stringValue = "Hello, world!",
    colorSequenceKeypointValue = ColorSequenceKeypoint.new(0.5, Color3.new(1, 0, 0)),
    numberRangeValue = NumberRange.new(0, 10),
    numberSequenceKeypointValue = NumberSequenceKeypoint.new(0.5, 10, 0.1),
    physicalPropertiesValue = PhysicalProperties.new(1, 0.5, 0.2, 0.7, 0.8),
    rayValue = Ray.new(Vector3.new(0, 0, 0), Vector3.new(1, 1, 1)),
    rectValue = Rect.new(0, 0, 100, 100),
    region3Value = Region3.new(Vector3.new(-1, -1, -1), Vector3.new(1, 1, 1)),
    tweenInfoValue = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),
    udimValue = UDim.new(0.5, 5),
    vector2Value = Vector2.new(10, 20),
    vector2int16Value = Vector2int16.new(300, 600),
    vector3int16Value = Vector3int16.new(1000, 2000, 3000),
    luaTypes = {
        boolValue = true,
        numberValue = 1007,
        stringValue = "testing",
        tableValue = { "value 1" },
        functionValue = testFunc,
    },
}

printFancyFormat(fancyFormat(testCase))