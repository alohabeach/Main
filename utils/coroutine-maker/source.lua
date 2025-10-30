-- Loop Maker | alohabeach
-- June 15, 2021

local thread = {}

function thread:new(threadType, waitTimeSeconds, callback, threadEnded)
	self._checkArgs({ threadType, waitTimeSeconds, callback }, { { "string" }, { "nil", "number" }, { "function" } })
	if not self or type(self) ~= "table" then
		return error("Expected ':' not '.' calling member of function new")
	end

	local newThread = self:_insertSelf({
		threadType = threadType,
		waitTimeSeconds = waitTimeSeconds,
		callback = callback,
		enabled = false,
		isRunning = false,
	})

	if threadType == "coroutine" then
		newThread.coroutine = coroutine.create(function()
			while true do
				if not newThread.enabled then
					newThread.isRunning = false
					coroutine.yield()
				end
				newThread.isRunning = true

				if threadEnded then
					task.defer(newThread.callback)
					threadEnded.Event:Wait()
				else
					local success, errorMessage = pcall(newThread.callback)
					if not success then
						task.spawn(error, errorMessage)
					end
				end

				task.wait(newThread.waitTimeSeconds)
			end
		end)
	else
		newThread.connection = game:GetService("RunService")[threadType]:Connect(function(...)
			if not newThread.enabled then
				newThread.isRunning = false
				return
			end
			newThread.isRunning = true

			task.spawn(newThread.callback, ...)
		end)
	end

	return newThread
end

function thread:setEnabled(enabled)
	self._checkArgs({ enabled }, { { "boolean" } })
	if not self or type(self) ~= "table" then
		return error("Expected ':' not '.' calling member of function setEnabled")
	end
	if not self.threadType then
		return error("Invalid thread to setEnabled")
	end

	self.enabled = enabled

	if self.threadType == "coroutine" and enabled and not self.isRunning then
		coroutine.resume(self.coroutine)
	end

	while self.enabled ~= self.isRunning do
		task.wait()
	end

	return self
end

function thread:destroy(shouldDestroyInstantly)
	if not self or type(self) ~= "table" then
		return error("Expected ':' not '.' calling member of function destroy")
	end
	if not self.threadType then
		return error("Invalid thread to destroy")
	end

	if not shouldDestroyInstantly then
		self.enabled = false
		repeat
			task.wait()
		until not self.isRunning
	end

	if self.threadType == "coroutine" then
		pcall(coroutine.close, self.coroutine)
	else
		pcall(self.connection.Disconnect, self.connection)
	end

	table.clear(self)
	setmetatable(self, nil)
end

function thread._checkArgs(args, expected)
	for index = 1, #expected do
		local value = args[index]
		local argType = typeof(value)
		local expectations = expected[index]

		local valid = false
		for i = 1, #expectations do
			if argType == expectations[i] then
				valid = true
				break
			end
		end

		if not valid then
			local expectedString = table.concat(expectations, " or ")

			local funcName = debug.info(2, "n") or "unknown"

			error((
				"%s argument #%d to '%s' (%s expected%s)"
			):format(
				argType == "nil" and "missing" or "invalid",
				index,
				funcName,
				expectedString,
				argType ~= "nil" and ", got " .. argType or ""
			), 2)
		end
	end
end

function thread:_insertSelf(newThread)
	for funcName, func in pairs(self) do
		if typeof(func) ~= "function" then
			continue
		end

		newThread[funcName] = func
	end

	setmetatable(newThread, self)

	return newThread
end

return thread
