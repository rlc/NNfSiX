-- numpy emulation/mockup in Lua

-- NOTE: these functions are written to handle the use cases specified
-- in the NNfS examples and hence contains only bare-minimum error
-- handling and not very suitable for explorations outside the examples
require("pythonLua")-- for the zip

local numpyLua = {}
local mt_npArray = {
    __add = function(a, b)
        local out = {}
        for i, v in ipairs(a) do
            out[i] = v + b[i] or 0
        end

        return out
    end
}

-- returned table is expected to have npArray behaviour
function numpyLua.dot(ta, b)
    local out = {}

    -- use the first argument ta as the iterator
    for _, a in ipairs(ta) do
        local sumproductAB = numpyLua.sumproduct(a, b)
        table.insert(out, sumproductAB)
    end

    -- convert to numpyArray before returning
    numpyLua.array(out)
    return out
end

function numpyLua.sumproduct(a, b)
    local sumproduct = 0
    for va, vb in zip(a, b) do
        sumproduct = sumproduct + va*vb
    end

    return sumproduct
end

-- convert regular table to npArray
function numpyLua.array(t)
    return setmetatable(t, mt_npArray)
end

return numpyLua
