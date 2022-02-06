--[[
Doing dot product with a layer of neurons and multiple inputs
Associated YT NNFS tutorial: https://www.youtube.com/watch?v=tMrbN67U9d4
--]]
--- Helper functions ----------
-- NOTE: these functions are written to handle the use case specified in the example
-- and hence contains only bare-minimum error handling
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

function print(t)
    if type(t) == "table" then
        -- assume all tables are arrays
        _print(arrayToString(t))
    else
        _print(t)
    end
end

function zip(a, b)
    local i = 0
    return function()
        i = i + 1
        return a[i], b[i]
    end
end

-- np simulation
local np = {}
local mt_npArray = {
    __add = function(a, b)
        local out = {}
        for i, v in ipairs(a, b) do
            out[i] = v + b[i] or 0
        end

        return out
    end
}

function np.dot(ta, b)
    local out = {}
    setmetatable(out, mt_npArray)

    -- use the first argument ta as the iterator
    for _, a in ipairs(ta) do
        local sumproduct = 0
        for va, vb in zip(a, b) do
            sumproduct = sumproduct + va*vb
        end
        table.insert(out, sumproduct)
    end

    return out
end

--- Code starts here ----------
inputs = {1.0, 2.0, 3.0, 2.5}
weights = {{0.2, 0.8, -0.5, 1.0},
           {0.5, -0.91, 0.26, -0.5},
           {-0.26, -0.27, 0.17, 0.87}}

biases = {2.0, 3.0, 0.5}

-- First version
layer_outputs = {} -- Output of current layer
for neuron_weights, neuron_bias in zip(weights, biases) do
    local neuron_output = 0 -- Output of given neuron
    for n_input, weight in zip(inputs, neuron_weights) do
        neuron_output = neuron_output + n_input*weight
    end
    neuron_output = neuron_output + neuron_bias
    table.insert(layer_outputs, neuron_output)
end

print(layer_outputs)

-- Second version
layer_outputs = np.dot(weights, inputs) + biases
print(layer_outputs)
