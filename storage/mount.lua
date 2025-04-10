local options = require("options")
local chests = {
    input = peripheral.wrap(options.chest.input),
    output = peripheral.wrap(options.chest.output),
    storage = {}
}

local function addChest(chestPrefix, name, block)
    local prefix = string.sub(name, 1, #name)
    if prefix ~= chestPrefix then return end
    if name == options.chest.input or name == options.chest.output then return end
    chests.storage[#chests.storage + 1] = block
end

for name, block in ipairs(peripheral.getNames()) do
    for chestPrefix in options.chest.storagePrefix do
        if #name > #chestPrefix then
            addChest(chestPrefix, name, block)
        end
    end
end

return chests
