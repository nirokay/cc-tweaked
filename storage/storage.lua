local utils = require("utils")
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
    print("Failed to push items from slot " .. slot .. "...")
end
function storage.pushAllItemsToChests()
    print("Pushing items to storage...")
    for slot, item in pairs(chests.input.list()) do
        storage.pushSlotToChests(slot)
    end
end

-- @returns `table` { chest_name = {slot_1, slot2, ...}, ... }
function storage.findItemByName(modlessName)
    local result = {}
    for chestName, chest in pairs(chests.storage) do
        for slot, item in pairs(chest.list()) do
            if utils.getItemNameComponents(item.name).item == modlessName then
                if result[chestName] == nil then result[chestName] = {} end
                table.insert(result[chestName], slot)
            end
        end
    end
    return result
end

function storage.pullItemByName(name)
    local modlessName = utils.getItemNameComponents(name).item
    local locations = storage.findItemByName(name)
    if locations == {} then
        print("Item " .. modlessName .. " not found :(")
        return
    end

    for chestName, slots in pairs(locations) do
        for index = 1, #slots do
            local slot = slots[index]
            local itemCount = chests.output.pullItems(chestName, slot)
            if itemCount == 0 then
                print("Could not pull item...")
            end
        end
    end
end

return storage
