local FunctionalTable = {}

local methods = {}

local function shallowCopy(tbl)
    local copy = {}
    for k, v in ipairs(tbl) do
        copy[k] = v
    end
    return copy
end

local function wrap(result, tbl)
    return setmetatable({_result = result, _table = tbl}, {
        __index = function(self, key)
            if methods[key] then
                return function(_, ...)
                    return methods[key](self._table, ...)
                end
            end
        end,
        __call = function(self)
            return self._result
        end
    })
end

function methods:andThen(callback)
    if self._result ~= nil then
        callback(self._result, self)
    else
        callback(self)
    end
    return wrap(nil, self)
end

function methods:pop()
    local value = table.remove(self, #self)
    return wrap(value, self)
end

function methods:push(value)
    self[#self + 1] = value
    return wrap(#self, self)
end

function methods:map(callback)
    local result = {}
    for _, value in ipairs(self) do
        table.insert(result, callback(value))
    end
    return wrap(nil, FunctionalTable.new(result))
end

function methods:reduce(callback, initial)
    local accumulator = initial or 0
    for _, value in ipairs(self) do
        accumulator = callback(accumulator, value)
    end
    return wrap(accumulator, self)
end

function methods:filter(predicate)
    local result = {}
    for _, value in ipairs(self) do
        if predicate(value) then
            table.insert(result, value)
        end
    end
    return wrap(nil, FunctionalTable.new(result))
end

function methods:shift()
    local value = table.remove(self, 1)
    return wrap(value, self)
end

function methods:unshift(value)
    table.insert(self, 1, value)
    return wrap(#self, self)
end

function methods:forEach(callback)
    for i, value in ipairs(self) do
        callback(value, i, self)
    end
    return wrap(nil, self)
end

function methods:find(predicate)
    for _, value in ipairs(self) do
        if predicate(value) then
            return wrap(value, self)
        end
    end
    return wrap(nil, self)
end

function methods:findIndex(predicate)
    for i, value in ipairs(self) do
        if predicate(value) then
            return wrap(i, self)
        end
    end
    return wrap(-1, self)
end

function methods:every(predicate)
    for _, value in ipairs(self) do
        if not predicate(value) then
            return wrap(false, self)
        end
    end
    return wrap(true, self)
end

function methods:some(predicate)
    for _, value in ipairs(self) do
        if predicate(value) then
            return wrap(true, self)
        end
    end
    return wrap(false, self)
end

function methods:slice(startIdx, endIdx)
    startIdx = startIdx or 1
    endIdx = endIdx or #self
    local result = {}
    for i = startIdx, endIdx do
        table.insert(result, self[i])
    end
    return wrap(nil, FunctionalTable.new(result))
end

function methods:reverse()
    local result = {}
    for i = #self, 1, -1 do
        table.insert(result, self[i])
    end
    return wrap(nil, FunctionalTable.new(result))
end

function methods:concat(otherTable)
    local result = shallowCopy(self)
    for _, value in ipairs(otherTable) do
        table.insert(result, value)
    end
    return wrap(nil, FunctionalTable.new(result))
end

function methods:sort(compareFunc)
    local result = shallowCopy(self)
    table.sort(result, compareFunc)
    return wrap(nil, FunctionalTable.new(result))
end

function methods:splice(start, deleteCount, ...)
    local removed = {}
    local additions = { ... }

    -- Handle removed elements
    for i = start, start + deleteCount - 1 do
        table.insert(removed, self[i])
        table.remove(self, i)
    end

    -- Insert new elements
    for i = #additions, 1, -1 do
        table.insert(self, start, additions[i])
    end

    return wrap(nil, self)
end

function FunctionalTable.new(tbl)
    tbl = tbl or {}
    setmetatable(tbl, {
        __index = methods,
        __call = function(self, callback)
            return self:andThen(callback)
        end,
    })
    return tbl
end




--[[
-- Helper function for assertions
local function assertEqual(actual, expected, testName)
    if actual == expected then
        print("[PASS] " .. testName)
    else
        print("[FAIL] " .. testName .. " | Expected: " .. tostring(expected) .. ", Got: " .. tostring(actual))
    end
end

-- Test cases
local function runTests()
    local ft = FunctionalTable.new({1, 2, 3, 4, 5})

    -- pop
    local popped = ft:pop()()
    assertEqual(popped, 5, "pop() returns the last element")

    -- push
    local newLength = ft:push(6)()
    assertEqual(ft[#ft], 6, "push() adds an element to the end")
    assertEqual(newLength, 5, "push() returns the new length")

    -- map
    ft:map(function(x) return x * 2 end)
        :andThen(function(tbl)
            assertEqual(tbl[1], 2, "map() doubles the first element")
            assertEqual(tbl[5], 12, "map() doubles the last element")
        end)

    -- reduce
    local sum = ft:reduce(function(acc, x) return acc + x end)()
    assertEqual(sum, 16, "reduce() sums the elements")

    -- filter
    ft:filter(function(x) return x % 2 == 0 end)
        :andThen(function(tbl)
            assertEqual(#tbl, 3, "filter() retains only even numbers")
        end)

    -- shift
    local shifted = ft:shift()()
    assertEqual(shifted, 1, "shift() removes and returns the first element")

    -- unshift
    newLength = ft:unshift(0)()
    assertEqual(ft[1], 0, "unshift() adds an element to the beginning")
    assertEqual(newLength, 5, "unshift() returns the new length")

    -- forEach
    local forEachSum = 0
    ft:forEach(function(x) forEachSum = forEachSum + x end)
    assertEqual(forEachSum, 15, "forEach() iterates through all elements")

    -- find
    local found = ft:find(function(x) return x == 4 end)()
    assertEqual(found, 4, "find() finds the first matching element")

    -- findIndex
    local index = ft:findIndex(function(x) return x == 4 end)()
    assertEqual(index, 4, "findIndex() finds the index of the matching element")

    -- every
    local allEven = ft:every(function(x) return x % 2 == 0 end)()
    assertEqual(allEven, false, "every() returns false if not all match")

    -- some
    local hasEven = ft:some(function(x) return x % 2 == 0 end)()
    assertEqual(hasEven, true, "some() returns true if any match")

    -- slice
    ft:slice(2, 4)
        :andThen(function(tbl)
            assertEqual(tbl[1], 2, "slice() starts from the correct index")
            assertEqual(tbl[3], 4, "slice() ends at the correct index")
        end)

    -- reverse
    ft:reverse()
        :andThen(function(tbl)
            assertEqual(tbl[1], 6, "reverse() reverses the table")
            assertEqual(tbl[#tbl], 0, "reverse() has the correct last element")
        end)

    -- concat
    ft:concat({7, 8})
        :andThen(function(tbl)
            assertEqual(tbl[#tbl - 1], 7, "concat() appends new elements")
            assertEqual(tbl[#tbl], 8, "concat() appends the last element")
        end)

    -- sort
    ft:sort(function(a, b) return a > b end)
        :andThen(function(tbl)
            assertEqual(tbl[1], 6, "sort() orders elements correctly")
            assertEqual(tbl[#tbl], 0, "sort() has the smallest last element")
        end)

    -- splice
    ft:splice(2, 2, 7, 8)
        :andThen(function(tbl)
            assertEqual(tbl[2], 7, "splice() inserts new elements")
            assertEqual(tbl[3], 8, "splice() inserts the second new element")
        end)

    print("All tests completed!")
end

-- Run the test suite
runTests()

]]