--[[
Doing dot product with a layer of neurons and multiple inputs
Associated YT NNFS tutorial: https://www.youtube.com/watch?v=tMrbN67U9d4
--]]

require("pythonLua")
local np = require("numpyLua")

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
