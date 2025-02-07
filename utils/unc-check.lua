--- Custom Kick Message ---
local function customKick(title, message)
    local LocalPlayer = game.GetService(game, "Players").LocalPlayer
    LocalPlayer.Kick(LocalPlayer, message)

    local prompt = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ErrorPrompt
    prompt.TitleFrame.ErrorTitle.Text = title
    prompt.MessageArea.ErrorFrame.ErrorMessage.Text = message
end


-- quick writefile check
if not writefile then
    return customKick("UNC Check Failed", "Your executor is missing the 'writefile' function. Please do not ask for this executor to be supported.")
end



--- Univsersal Naming Convention Check ---
local BASE_FOLDER = "Aloha Configs"
local UNC_TEST_PATH = string.format("%s/unc-check.txt", BASE_FOLDER)
writefile(UNC_TEST_PATH, "UNC Environment Check\n✅ - Pass, ⛔ - Fail, ⏺️ - No test, ⚠️ - Missing aliases\n\n")

local passes, fails, undefined = 0, 0, 0

local function getGlobal(path)
    local value = getfenv(0)

    while value ~= nil and path ~= "" do
        local name, nextValue = string.match(path, "^([^.]+)%.?(.*)$")
        value = value[name]
        path = nextValue
    end

    return value
end

local tests = setmetatable({}, {
    __index = function(_, key)
        error(string.format("No such test called '%s'", key))
    end
})

local function addTest(name, aliases, callback)
    tests[name] = {
        aliases = aliases,
        callback = callback,
    }
end

local function test(testNames)
    local running = 0

    for _, name in pairs(testNames) do
        running += 1

        task.spawn(function()
            if not tests[name].callback then
                appendfile(UNC_TEST_PATH, "⏺️ " .. name)
            elseif not getGlobal(name) then
                fails += 1
                appendfile(UNC_TEST_PATH, "⛔ " .. name)
            else
                local success, message = pcall(tests[name].callback)

                if success then
                    passes += 1
                    appendfile(UNC_TEST_PATH, "✅ " .. name .. (message and " • " .. message or ""))
                else
                    fails += 1
                    appendfile(UNC_TEST_PATH, "⛔ " .. name .. " failed: " .. message)
                end
            end
            appendfile(UNC_TEST_PATH, "\n")

            local undefinedAliases = {}

            for _, alias in ipairs(tests[name].aliases) do
                if getGlobal(alias) == nil then
                    table.insert(undefinedAliases, alias)
                end
            end

            if #undefinedAliases > 0 then
                undefined += 1
                appendfile(UNC_TEST_PATH, "⚠️ " .. table.concat(undefinedAliases, ", "))
            end

            running -= 1
        end)
    end

    repeat task.wait() until running == 0

    local rate = math.round(passes / (passes + fails) * 100)
    local outOf = passes .. " out of " .. (passes + fails)

    appendfile(UNC_TEST_PATH, string.format("\n\nUNC Summary\n✅ Tested with a %d%% success rate ( %s )\n⛔ %d tests failed\n⚠️ %s globals are missing aliases", rate, outOf, fails, undefined))

    if fails > 0 then
        customKick("UNC Check Failed", "Your executor did not pass the UNC check for this script. You can find the log file in your executor's workspace under:\n\n" .. UNC_TEST_PATH)
    end
end

-- Cache

addTest("cache.invalidate", {}, function()
	local container = Instance.new("Folder")
	local part = Instance.new("Part", container)
	cache.invalidate(container:FindFirstChild("Part"))
	assert(part ~= container:FindFirstChild("Part"), "Reference `part` could not be invalidated")
end)

addTest("cache.iscached", {}, function()
	local part = Instance.new("Part")
	assert(cache.iscached(part), "Part should be cached")
	cache.invalidate(part)
	assert(not cache.iscached(part), "Part should not be cached")
end)

addTest("cache.replace", {}, function()
	local part = Instance.new("Part")
	local fire = Instance.new("Fire")
	cache.replace(part, fire)
	assert(part ~= fire, "Part was not replaced with Fire")
end)

addTest("cloneref", {}, function()
	local part = Instance.new("Part")
	local clone = cloneref(part)
	assert(part ~= clone, "Clone should not be equal to original")
	clone.Name = "Test"
	assert(part.Name == "Test", "Clone should have updated the original")
end)

addTest("compareinstances", {}, function()
	local part = Instance.new("Part")
	local clone = cloneref(part)
	assert(part ~= clone, "Clone should not be equal to original")
	assert(compareinstances(part, clone), "Clone should be equal to original when using compareinstances()")
end)

-- Closures

local function shallowEqual(t1, t2)
	if t1 == t2 then
		return true
	end

	local UNIQUE_TYPES = {
		["function"] = true,
		["table"] = true,
		["userdata"] = true,
		["thread"] = true,
	}

	for k, v in pairs(t1) do
		if UNIQUE_TYPES[type(v)] then
			if type(t2[k]) ~= type(v) then
				return false
			end
		elseif t2[k] ~= v then
			return false
		end
	end

	for k, v in pairs(t2) do
		if UNIQUE_TYPES[type(v)] then
			if type(t2[k]) ~= type(v) then
				return false
			end
		elseif t1[k] ~= v then
			return false
		end
	end

	return true
end

addTest("checkcaller", {}, function()
	assert(checkcaller(), "Main scope should return true")
end)

addTest("clonefunction", {}, function()
	local function cloneFuncTest()
		return "success"
	end
	local copy = clonefunction(cloneFuncTest)
	assert(cloneFuncTest() == copy(), "The clone should return the same value as the original")
	assert(test ~= copy, "The clone should not be equal to the original")
end)

addTest("getcallingscript", {})

addTest("getscriptclosure", {"getscriptfunction"}, function()
	local module = game:GetService("CoreGui").RobloxGui.Modules.Common.CommonUtil
	local utils = getrenv().require(module)
	local generated = getscriptclosure(module)()
	assert(utils ~= generated, "Generated module should not match the original")
	assert(shallowEqual(utils, generated), "Generated constant table should be shallow equal to the original")
end)

addTest("hookfunction", {"replaceclosure"}, function()
	local function hookFunctionTest()
		return true
	end
	local ref = hookfunction(hookFunctionTest, function()
		return false
	end)
	assert(hookFunctionTest() == false, "Function should return false")
	assert(ref() == true, "Original function should return true")
	assert(test ~= ref, "Original function should not be same as the reference")
end)

addTest("iscclosure", {}, function()
	assert(iscclosure(print) == true, "Function 'print' should be a C closure")
	assert(iscclosure(function() end) == false, "Executor function should not be a C closure")
end)

addTest("islclosure", {}, function()
	assert(islclosure(print) == false, "Function 'print' should not be a Lua closure")
	assert(islclosure(function() end) == true, "Executor function should be a Lua closure")
end)

addTest("isexecutorclosure", {"checkclosure", "isourclosure"}, function()
	assert(isexecutorclosure(isexecutorclosure) == true, "Did not return true for an executor global")
	assert(isexecutorclosure(newcclosure(function() end)) == true, "Did not return true for an executor C closure")
	assert(isexecutorclosure(function() end) == true, "Did not return true for an executor Luau closure")
	assert(isexecutorclosure(print) == false, "Did not return false for a Roblox global")
end)

addTest("loadstring", {}, function()
	local animate = game:GetService("Players").LocalPlayer.Character.Animate
	local bytecode = getscriptbytecode(animate)
	local func = loadstring(bytecode)
	assert(type(func) ~= "function", "Luau bytecode should not be loadable!")
	assert(assert(loadstring("return ... + 1"))(1) == 2, "Failed to do simple math")
	assert(type(select(2, loadstring("f"))) == "string", "Loadstring did not return anything for a compiler error")
end)

addTest("newcclosure", {}, function()
	local function newcclosureTest()
		return true
	end
	local testC = newcclosure(newcclosureTest)
	assert(newcclosureTest() == testC(), "New C closure should return the same value as the original")
	assert(newcclosureTest ~= testC, "New C closure should not be same as the original")
	assert(iscclosure(testC), "New C closure should be a C closure")
end)

-- Console

addTest("rconsoleclear", {"consoleclear"})

addTest("rconsolecreate", {"consolecreate"})

addTest("rconsoledestroy", {"consoledestroy"})

addTest("rconsoleinput", {"consoleinput"})

addTest("rconsoleprint", {"consoleprint"})

addTest("rconsolesettitle", {"rconsolename", "consolesettitle"})

-- Crypt

addTest("crypt.base64encode", {"crypt.base64.encode", "crypt.base64_encode", "base64.encode", "base64_encode"}, function()
	assert(crypt.base64encode("test") == "dGVzdA==", "Base64 encoding failed")
end)

addTest("crypt.base64decode", {"crypt.base64.decode", "crypt.base64_decode", "base64.decode", "base64_decode"}, function()
	assert(crypt.base64decode("dGVzdA==") == "test", "Base64 decoding failed")
end)

addTest("crypt.encrypt", {}, function()
	local key = crypt.generatekey()
	local encrypted, iv = crypt.encrypt("test", key, nil, "CBC")
	assert(iv, "crypt.encrypt should return an IV")
	local decrypted = crypt.decrypt(encrypted, key, iv, "CBC")
	assert(decrypted == "test", "Failed to decrypt raw string from encrypted data")
end)

addTest("crypt.decrypt", {}, function()
	local key, iv = crypt.generatekey(), crypt.generatekey()
	local encrypted = crypt.encrypt("test", key, iv, "CBC")
	local decrypted = crypt.decrypt(encrypted, key, iv, "CBC")
	assert(decrypted == "test", "Failed to decrypt raw string from encrypted data")
end)

addTest("crypt.generatebytes", {}, function()
	local size = math.random(10, 100)
	local bytes = crypt.generatebytes(size)
	assert(#crypt.base64decode(bytes) == size, "The decoded result should be " .. size .. " bytes long (got " .. #crypt.base64decode(bytes) .. " decoded, " .. #bytes .. " raw)")
end)

addTest("crypt.generatekey", {}, function()
	local key = crypt.generatekey()
	assert(#crypt.base64decode(key) == 32, "Generated key should be 32 bytes long when decoded")
end)

addTest("crypt.hash", {}, function()
	local algorithms = {'sha1', 'sha384', 'sha512', 'md5', 'sha256', 'sha3-224', 'sha3-256', 'sha3-512'}
	for _, algorithm in ipairs(algorithms) do
		local hash = crypt.hash("test", algorithm)
		assert(hash, "crypt.hash on algorithm '" .. algorithm .. "' should return a hash")
	end
end)

--- Debug

addTest("debug.traceback", {}, function()
    local function innerFunction()
        error("This is a test error!")
    end
    local function outerFunction()
        innerFunction()
    end
    pcall(function() getgenv().debug.traceback = getrenv().debug.traceback end)
    local success, message = xpcall(outerFunction, debug.traceback)
    assert(not success, "debug.traceback did not capture the error")
    assert(message:find("outerFunction"), "debug.traceback did not include 'outerFunction' in the stack trace")
    assert(message:find("innerFunction"), "debug.traceback did not include 'innerFunction' in the stack trace")
end)

addTest("debug.getconstant", {}, function()
	local function constantTest()
		print("Hello, world!")
	end
	assert(debug.getconstant(constantTest, 1) == "print", "First constant must be print")
	assert(debug.getconstant(constantTest, 2) == nil, "Second constant must be nil")
	assert(debug.getconstant(constantTest, 3) == "Hello, world!", "Third constant must be 'Hello, world!'")
end)

addTest("debug.getconstants", {}, function()
	local function constantTest()
		local num = 5000 .. 50000
		print("Hello, world!", num, warn)
	end
	local constants = debug.getconstants(constantTest)
	assert(constants[1] == 50000, "First constant must be 50000")
	assert(constants[2] == "print", "Second constant must be print")
	assert(constants[3] == nil, "Third constant must be nil")
	assert(constants[4] == "Hello, world!", "Fourth constant must be 'Hello, world!'")
	assert(constants[5] == "warn", "Fifth constant must be warn")
end)

addTest("debug.getinfo", {}, function()
	local types = {
		source = "string",
		short_src = "string",
		func = "function",
		what = "string",
		currentline = "number",
		name = "string",
		nups = "number",
		numparams = "number",
		is_vararg = "number",
	}
	local function getInfoTest(...)
		print(...)
	end
	local info = debug.getinfo(getInfoTest)
	for k, v in pairs(types) do
		assert(info[k] ~= nil, "Did not return a table with a '" .. k .. "' field")
		assert(type(info[k]) == v, "Did not return a table with " .. k .. " as a " .. v .. " (got " .. type(info[k]) .. ")")
	end
end)

addTest("debug.getproto", {}, function()
	local function getProtoTest()
		local function proto()
			return true
		end
	end
	local proto = debug.getproto(getProtoTest, 1, true)[1]
	local realproto = debug.getproto(getProtoTest, 1)
	assert(proto, "Failed to get the inner function")
	assert(proto() == true, "The inner function did not return anything")
	if not realproto() then
		return "Proto return values are disabled on this executor"
	end
end)

addTest("debug.getprotos", {}, function()
	local function getProtosTest()
		local function _1()
			return true
		end
		local function _2()
			return true
		end
		local function _3()
			return true
		end
	end
	for i in ipairs(debug.getprotos(getProtosTest)) do
		local proto = debug.getproto(getProtosTest, i, true)[1]
		local realproto = debug.getproto(getProtosTest, i)
		assert(proto(), "Failed to get inner function " .. i)
		if not realproto() then
			return "Proto return values are disabled on this executor"
		end
	end
end)

addTest("debug.getstack", {}, function()
	local _ = "a" .. "b"
	assert(debug.getstack(1, 1) == "ab", "The first item in the stack should be 'ab'")
	assert(debug.getstack(1)[1] == "ab", "The first item in the stack table should be 'ab'")
end)

addTest("debug.getupvalue", {}, function()
	local upvalue = function() end
	local function getUpValueTest()
		print(upvalue)
	end
	assert(debug.getupvalue(getUpValueTest, 1) == upvalue, "Unexpected value returned from debug.getupvalue")
end)

addTest("debug.getupvalues", {}, function()
	local upvalue = function() end
	local function getUpValuesTest()
		print(upvalue)
	end
	local upvalues = debug.getupvalues(getUpValuesTest)
	assert(upvalues[1] == upvalue, "Unexpected value returned from debug.getupvalues")
end)

addTest("debug.setconstant", {}, function()
	local function setConstantTest()
		return "fail"
	end
	debug.setconstant(setConstantTest, 1, "success")
	assert(setConstantTest() == "success", "debug.setconstant did not set the first constant")
end)

addTest("debug.setstack", {}, function()
	local function setStackTest()
		return "fail", debug.setstack(1, 1, "success")
	end
	assert(setStackTest() == "success", "debug.setstack did not set the first stack item")
end)

addTest("debug.setupvalue", {}, function()
	local function upvalue()
		return "fail"
	end
	local function setUpValueTest()
		return upvalue()
	end
	debug.setupvalue(setUpValueTest, 1, function()
		return "success"
	end)
	assert(setUpValueTest() == "success", "debug.setupvalue did not set the first upvalue")
end)

-- Filesystem

if isfolder and makefolder and delfolder then
	if isfolder(".tests") then
		delfolder(".tests")
	end
	makefolder(".tests")
end

addTest("readfile", {}, function()
	writefile(".tests/readfile.txt", "success")
	assert(readfile(".tests/readfile.txt") == "success", "Did not return the contents of the file")
end)

addTest("listfiles", {}, function()
	makefolder(".tests/listfiles")
	writefile(".tests/listfiles/test_1.txt", "success")
	writefile(".tests/listfiles/test_2.txt", "success")
	local files = listfiles(".tests/listfiles")
	assert(#files == 2, "Did not return the correct number of files")
	assert(isfile(files[1]), "Did not return a file path")
	assert(readfile(files[1]) == "success", "Did not return the correct files")
	makefolder(".tests/listfiles_2")
	makefolder(".tests/listfiles_2/test_1")
	makefolder(".tests/listfiles_2/test_2")
	local folders = listfiles(".tests/listfiles_2")
	assert(#folders == 2, "Did not return the correct number of folders")
	assert(isfolder(folders[1]), "Did not return a folder path")
end)

addTest("writefile", {}, function()
	writefile(".tests/writefile.txt", "success")
	assert(readfile(".tests/writefile.txt") == "success", "Did not write the file")
	local requiresFileExt = pcall(function()
		writefile(".tests/writefile", "success")
		assert(isfile(".tests/writefile.txt"))
	end)
	if not requiresFileExt then
		return "This executor requires a file extension in writefile"
	end
end)

addTest("makefolder", {}, function()
	makefolder(".tests/makefolder")
	assert(isfolder(".tests/makefolder"), "Did not create the folder")
end)

addTest("appendfile", {}, function()
	writefile(".tests/appendfile.txt", "su")
	appendfile(".tests/appendfile.txt", "cce")
	appendfile(".tests/appendfile.txt", "ss")
	assert(readfile(".tests/appendfile.txt") == "success", "Did not append the file")
end)

addTest("isfile", {}, function()
	writefile(".tests/isfile.txt", "success")
	assert(isfile(".tests/isfile.txt") == true, "Did not return true for a file")
	assert(isfile(".tests") == false, "Did not return false for a folder")
	assert(isfile(".tests/doesnotexist.exe") == false, "Did not return false for a nonexistent path (got " .. tostring(isfile(".tests/doesnotexist.exe")) .. ")")
end)

addTest("isfolder", {}, function()
	assert(isfolder(".tests") == true, "Did not return false for a folder")
	assert(isfolder(".tests/doesnotexist.exe") == false, "Did not return false for a nonexistent path (got " .. tostring(isfolder(".tests/doesnotexist.exe")) .. ")")
end)

addTest("delfolder", {}, function()
	makefolder(".tests/delfolder")
	delfolder(".tests/delfolder")
	assert(isfolder(".tests/delfolder") == false, "Failed to delete folder (isfolder = " .. tostring(isfolder(".tests/delfolder")) .. ")")
end)

addTest("delfile", {}, function()
	writefile(".tests/delfile.txt", "Hello, world!")
	delfile(".tests/delfile.txt")
	assert(isfile(".tests/delfile.txt") == false, "Failed to delete file (isfile = " .. tostring(isfile(".tests/delfile.txt")) .. ")")
end)

addTest("loadfile", {}, function()
	writefile(".tests/loadfile.txt", "return ... + 1")
	assert(assert(loadfile(".tests/loadfile.txt"))(1) == 2, "Failed to load a file with arguments")
	writefile(".tests/loadfile.txt", "f")
	local callback, err = loadfile(".tests/loadfile.txt")
	assert(err and not callback, "Did not return an error message for a compiler error")
end)

addTest("dofile", {})

-- Input

addTest("isrbxactive", {"isgameactive"}, function()
	assert(type(isrbxactive()) == "boolean", "Did not return a boolean value")
end)

addTest("mouse1click", {})

addTest("mouse1press", {})

addTest("mouse1release", {})

addTest("mouse2click", {})

addTest("mouse2press", {})

addTest("mouse2release", {})

addTest("mousemoveabs", {})

addTest("mousemoverel", {})

addTest("mousescroll", {})

-- Instances

addTest("fireclickdetector", {}, function()
	local detector = Instance.new("ClickDetector")
	fireclickdetector(detector, 50, "MouseHoverEnter")
end)

addTest("getcallbackvalue", {}, function()
	local bindable = Instance.new("BindableFunction")
	local function getCallbackValueTest()
	end
	bindable.OnInvoke = getCallbackValueTest
	assert(getcallbackvalue(bindable, "OnInvoke") == getCallbackValueTest, "Did not return the correct value")
end)

addTest("getconnections", {}, function()
	local types = {
		Enabled = "boolean",
		ForeignState = "boolean",
		LuaConnection = "boolean",
		Function = "function",
		Thread = "thread",
		Fire = "function",
		Defer = "function",
		Disconnect = "function",
		Disable = "function",
		Enable = "function",
	}
	local bindable = Instance.new("BindableEvent")
	bindable.Event:Connect(function() end)
	local connection = getconnections(bindable.Event)[1]
	for k, v in pairs(types) do
		assert(connection[k] ~= nil, "Did not return a table with a '" .. k .. "' field")
		assert(type(connection[k]) == v, "Did not return a table with " .. k .. " as a " .. v .. " (got " .. type(connection[k]) .. ")")
	end
end)

addTest("getcustomasset", {}, function()
	writefile(".tests/getcustomasset.txt", "success")
	local contentId = getcustomasset(".tests/getcustomasset.txt")
	assert(type(contentId) == "string", "Did not return a string")
	assert(#contentId > 0, "Returned an empty string")
	assert(string.match(contentId, "rbxasset://") == "rbxasset://", "Did not return an rbxasset url")
end)

addTest("gethiddenproperty", {}, function()
	local fire = Instance.new("Fire")
	local property, isHidden = gethiddenproperty(fire, "size_xml")
	assert(property == 5, "Did not return the correct value")
	assert(isHidden == true, "Did not return whether the property was hidden")
end)

addTest("sethiddenproperty", {}, function()
	local fire = Instance.new("Fire")
	local hidden = sethiddenproperty(fire, "size_xml", 10)
	assert(hidden, "Did not return true for the hidden property")
	assert(gethiddenproperty(fire, "size_xml") == 10, "Did not set the hidden property")
end)

addTest("gethui", {}, function()
	assert(typeof(gethui()) == "Instance", "Did not return an Instance")
end)

addTest("getinstances", {}, function()
	assert(getinstances()[1]:IsA("Instance"), "The first value is not an Instance")
end)

addTest("getnilinstances", {}, function()
	assert(getnilinstances()[1]:IsA("Instance"), "The first value is not an Instance")
	assert(getnilinstances()[1].Parent == nil, "The first value is not parented to nil")
end)

addTest("isscriptable", {}, function()
	local fire = Instance.new("Fire")
	assert(isscriptable(fire, "size_xml") == false, "Did not return false for a non-scriptable property (size_xml)")
	assert(isscriptable(fire, "Size") == true, "Did not return true for a scriptable property (Size)")
end)

addTest("setscriptable", {}, function()
	local fire = Instance.new("Fire")
	local wasScriptable = setscriptable(fire, "size_xml", true)
	assert(wasScriptable == false, "Did not return false for a non-scriptable property (size_xml)")
	assert(isscriptable(fire, "size_xml") == true, "Did not set the scriptable property")
	fire = Instance.new("Fire")
	assert(isscriptable(fire, "size_xml") == false, "⚠️⚠️ setscriptable persists between unique instances ⚠️⚠️")
end)

addTest("setrbxclipboard", {})

-- Metatable

addTest("getrawmetatable", {}, function()
	local metatable = { __metatable = "Locked!" }
	local object = setmetatable({}, metatable)
	assert(getrawmetatable(object) == metatable, "Did not return the metatable")
end)

addTest("hookmetamethod", {}, function()
	local object = setmetatable({}, { __index = newcclosure(function() return false end), __metatable = "Locked!" })
	local ref = hookmetamethod(object, "__index", function() return true end)
	assert(object.test == true, "Failed to hook a metamethod and change the return value")
	assert(ref() == false, "Did not return the original function")
end)

addTest("getnamecallmethod", {}, function()
	local method
	local ref
	ref = hookmetamethod(game, "__namecall", function(...)
		if not method then
			method = getnamecallmethod()
		end
		return ref(...)
	end)
	game:GetService("Lighting")
	assert(method == "GetService", "Did not get the correct method (GetService)")
end)

addTest("isreadonly", {}, function()
	local object = {}
	table.freeze(object)
	assert(isreadonly(object), "Did not return true for a read-only table")
end)

addTest("setrawmetatable", {}, function()
	local object = setmetatable({}, { __index = function() return false end, __metatable = "Locked!" })
	local objectReturned = setrawmetatable(object, { __index = function() return true end })
	assert(object, "Did not return the original object")
	assert(object.test == true, "Failed to change the metatable")
	if objectReturned then
		return objectReturned == object and "Returned the original object" or "Did not return the original object"
	end
end)

addTest("setreadonly", {}, function()
	local object = { success = false }
	table.freeze(object)
	setreadonly(object, false)
	object.success = true
	assert(object.success, "Did not allow the table to be modified")
end)

-- Miscellaneous

addTest("identifyexecutor", {"getexecutorname"}, function()
	local name, version = identifyexecutor()
	assert(type(name) == "string", "Did not return a string for the name")
	return type(version) == "string" and "Returns version as a string" or "Does not return version"
end)

addTest("lz4compress", {}, function()
	local raw = "Hello, world!"
	local compressed = lz4compress(raw)
	assert(type(compressed) == "string", "Compression did not return a string")
	assert(lz4decompress(compressed, #raw) == raw, "Decompression did not return the original string")
end)

addTest("lz4decompress", {}, function()
	local raw = "Hello, world!"
	local compressed = lz4compress(raw)
	assert(type(compressed) == "string", "Compression did not return a string")
	assert(lz4decompress(compressed, #raw) == raw, "Decompression did not return the original string")
end)

addTest("messagebox", {})

addTest("queue_on_teleport", {"queueonteleport"})

addTest("request", {"http.request", "http_request"}, function()
	local response = request({
		Url = "https://httpbin.org/user-agent",
		Method = "GET",
	})
	assert(type(response) == "table", "Response must be a table")
	assert(response.StatusCode == 200, "Did not return a 200 status code")
	local data = game:GetService("HttpService"):JSONDecode(response.Body)
	assert(type(data) == "table" and type(data["user-agent"]) == "string", "Did not return a table with a user-agent key")
	return "User-Agent: " .. data["user-agent"]
end)

addTest("setclipboard", {"toclipboard"})

addTest("setfpscap", {}, function()
	local renderStepped = game:GetService("RunService").RenderStepped
	local function step()
		renderStepped:Wait()
		local sum = 0
		for _ = 1, 5 do
			sum += 1 / renderStepped:Wait()
		end
		return math.round(sum / 5)
	end
	setfpscap(60)
	local step60 = step()
	setfpscap(0)
	local step0 = step()
	return step60 .. "fps @60 • " .. step0 .. "fps @0"
end)

-- Scripts

addTest("getgc", {}, function()
	local gc = getgc()
	assert(type(gc) == "table", "Did not return a table")
	assert(#gc > 0, "Did not return a table with any values")
end)

addTest("getreg", {}, function()
	local registry = getreg()
	assert(type(registry) == "table", "Did not return a table")
	assert(#registry > 0, "Did not return a table with any values")
end)

addTest("getgenv", {}, function()
	getgenv().__TEST_GLOBAL = true
	assert(__TEST_GLOBAL, "Failed to set a global variable")
	getgenv().__TEST_GLOBAL = nil
end)

addTest("getloadedmodules", {}, function()
	local modules = getloadedmodules()
	assert(type(modules) == "table", "Did not return a table")
	assert(#modules > 0, "Did not return a table with any values")
	assert(typeof(modules[1]) == "Instance", "First value is not an Instance")
	assert(modules[1]:IsA("ModuleScript"), "First value is not a ModuleScript")
end)

addTest("getrenv", {}, function()
	assert(_G ~= getrenv()._G, "The variable _G in the executor is identical to _G in the game")
end)

addTest("getrunningscripts", {}, function()
	local scripts = getrunningscripts()
	assert(type(scripts) == "table", "Did not return a table")
	assert(#scripts > 0, "Did not return a table with any values")
	assert(typeof(scripts[1]) == "Instance", "First value is not an Instance")
	assert(scripts[1]:IsA("ModuleScript") or scripts[1]:IsA("LocalScript"), "First value is not a ModuleScript or LocalScript")
end)

addTest("getscriptbytecode", {"dumpstring"}, function()
	local animate = game:GetService("Players").LocalPlayer.Character.Animate
	local bytecode = getscriptbytecode(animate)
	assert(type(bytecode) == "string", "Did not return a string for Character.Animate (a " .. animate.ClassName .. ")")
end)

addTest("getscripthash", {}, function()
	local animate = game:GetService("Players").LocalPlayer.Character.Animate:Clone()
	local hash = getscripthash(animate)
	local source = animate.Source
	animate.Source = "print('Hello, world!')"
	task.defer(function()
		animate.Source = source
	end)
	local newHash = getscripthash(animate)
	assert(hash ~= newHash, "Did not return a different hash for a modified script")
	assert(newHash == getscripthash(animate), "Did not return the same hash for a script with the same source")
end)

addTest("getscripts", {}, function()
	local scripts = getscripts()
	assert(type(scripts) == "table", "Did not return a table")
	assert(#scripts > 0, "Did not return a table with any values")
	assert(typeof(scripts[1]) == "Instance", "First value is not an Instance")
	assert(scripts[1]:IsA("ModuleScript") or scripts[1]:IsA("LocalScript"), "First value is not a ModuleScript or LocalScript")
end)

addTest("getsenv", {}, function()
	local animate = game:GetService("Players").LocalPlayer.Character.Animate
	local env = getsenv(animate)
	assert(type(env) == "table", "Did not return a table for Character.Animate (a " .. animate.ClassName .. ")")
	assert(env.script == animate, "The script global is not identical to Character.Animate")
end)

addTest("getthreadidentity", {"getidentity", "getthreadcontext"}, function()
	assert(type(getthreadidentity()) == "number", "Did not return a number")
end)

addTest("setthreadidentity", {"setidentity", "setthreadcontext"}, function()
	setthreadidentity(3)
	assert(getthreadidentity() == 3, "Did not set the thread identity")
end)

-- Drawing

addTest("Drawing", {})

addTest("Drawing.new", {}, function()
	local drawing = Drawing.new("Square")
	drawing.Visible = false
	local canDestroy = pcall(function()
		drawing:Destroy()
	end)
	assert(canDestroy, "Drawing:Destroy() should not throw an error")
end)

addTest("Drawing.Fonts", {}, function()
	assert(Drawing.Fonts.UI == 0, "Did not return the correct id for UI")
	assert(Drawing.Fonts.System == 1, "Did not return the correct id for System")
	assert(Drawing.Fonts.Plex == 2, "Did not return the correct id for Plex")
	assert(Drawing.Fonts.Monospace == 3, "Did not return the correct id for Monospace")
end)

addTest("isrenderobj", {}, function()
	local drawing = Drawing.new("Image")
	drawing.Visible = true
	assert(isrenderobj(drawing) == true, "Did not return true for an Image")
	assert(isrenderobj(newproxy()) == false, "Did not return false for a blank table")
end)

addTest("getrenderproperty", {}, function()
	local drawing = Drawing.new("Image")
	drawing.Visible = true
	assert(type(getrenderproperty(drawing, "Visible")) == "boolean", "Did not return a boolean value for Image.Visible")
	local success, result = pcall(function()
		return getrenderproperty(drawing, "Color")
	end)
	if not success or not result then
		return "Image.Color is not supported"
	end
end)

addTest("setrenderproperty", {}, function()
	local drawing = Drawing.new("Square")
	drawing.Visible = true
	setrenderproperty(drawing, "Visible", false)
	assert(drawing.Visible == false, "Did not set the value for Square.Visible")
end)

addTest("cleardrawcache", {}, function()
	cleardrawcache()
end)

-- WebSocket

addTest("WebSocket", {})

addTest("WebSocket.connect", {}, function()
	local types = {
		Send = "function",
		Close = "function",
		OnMessage = {"table", "userdata"},
		OnClose = {"table", "userdata"},
	}
	local ws = WebSocket.connect("ws://echo.websocket.events")
	assert(type(ws) == "table" or type(ws) == "userdata", "Did not return a table or userdata")
	for k, v in pairs(types) do
		if type(v) == "table" then
			assert(table.find(v, type(ws[k])), "Did not return a " .. table.concat(v, ", ") .. " for " .. k .. " (a " .. type(ws[k]) .. ")")
		else
			assert(type(ws[k]) == v, "Did not return a " .. v .. " for " .. k .. " (a " .. type(ws[k]) .. ")")
		end
	end
	ws:Close()
end)

return test