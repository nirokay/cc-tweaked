local options = require("options")
local chests = {
    input = peripheral.wrap(options.chest.input),
    output = peripheral.wrap(options.chest.output),
    storage = {}
}

local chestCount = 0

local function addChest(chestPrefix, name)
    local prefix = string.sub(name, 1, #chestPrefix)
    if prefix ~= chestPrefix then return end
    if name == options.chest.input or name == options.chest.output then return end
    local block = peripheral.wrap(name)
    chests.storage[name] = block
    chestCount = chestCount + 1
end

function chests.mountChests()
    for index = 1, #peripheral.getNames() do
        local name = peripheral.getNames()[index]
        for _, chestPrefix in pairs(options.chest.storagePrefix) do
            if #name >= #chestPrefix then
                addChest(chestPrefix, name)
            end
        end
    end
    print("Mounted " .. chestCount .. " chests as storage!")
    chestCount = 0
end

chests.mountChests()

return chests
