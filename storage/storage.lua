local options = require("options")
local chests = require("chests")
local storage = {}

function storage.pushSlotToChests(slot)
    if chests.input.getItemDetail(slot) == nil then return end
    for name, chest in pairs(chests.storage) do
        local amount = chests.input.pushItems(name, slot)

        if chests.input.getItemDetail(slot) == nil then
            print("Pushed " .. amount .. " items to chest " .. name .. "!")
            return
        end
    end
end

function storage.pushAllItemsToChests()
    print("Pushing items to storage...")
    for slot, item in pairs(chests.input.list()) do
        storage.pushSlotToChests(slot)
    end
end

return storage
