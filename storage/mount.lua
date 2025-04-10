local options = require("options")
local chests = {
    input = peripheral.wrap(options.chest.input),
    output = peripheral.wrap(options.chest.output),
    storage = {}
}

local function addChest(chestPrefix, name)
    local prefix = string.sub(name, 1, #name)
    if prefix ~= chestPrefix then return end
    if name == options.chest.input or name == options.chest.output then return end
    local block = peripheral.wrap(name)
    chests.storage[#chests.storage + 1] = block
end

for name in ipairs(peripheral.getNames()) do
    for i, chestPrefix in ipairs(options.chest.storagePrefix) do
        if #name > #chestPrefix then
            addChest(chestPrefix, name)
        end
    end
end

return chests
