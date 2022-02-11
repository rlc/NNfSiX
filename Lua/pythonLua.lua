--- python emulation/mockup in Lua

-- NOTE: these functions are written to handle the use cases specified
-- in the NNfS examples and hence contains only bare-minimum error
-- handling and not very suitable for explorations outside the examples

local _print = print
local function arrayToString(a)
    local out = {}
    for i, v in ipairs(a) do
        if type(v) == "table" then
            out[i] = arrayToString(v)
        else
            out[i] = v
        end
    end

    return string.format("{%s}", table.concat(out, ", "))
end

-- handle printing array content
function print(...)
    local args = {...}
    for i, arg in ipairs(args) do
        if type(arg) == "table" then
            -- assume all tables are arrays
            args[i] = arrayToString(arg)
        end
    end
    _print(table.unpack(args))
end

-- iterator for paired arrays
function zip(a, b)
    local i = 0
    return function()
        i = i + 1
        return a[i], b[i]
    end
end
