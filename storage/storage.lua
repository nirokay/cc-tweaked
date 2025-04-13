local utils = require("utils")
local options = require("options")
local chests = require("chests")

local storage = {}

-- @returns `table` {
--     [chest_name] = {
--         slot_1, slot2, ...
--     },
--     ...
-- }
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

-- @returns `table` {
--     [item_name] = {
--          [chest_name] = {
--              slot_1, slot_2, ...
--          },
--          ...
--     },
--     ...
-- }
function storage.findItemBySubstring(substring)
    local result = {}
    for chestName, chest in pairs(chests.storage) do
        for slot, item in pairs(chest.list()) do
            if string.find(item.name, substring) ~= nil then
                -- New object:
                if result[item.name] == nil then
                    result[item.name] = {
                        count = 0,
                        chests = {}
                    }
                end

                -- Item count:
                result[item.name].count = result[item.name].count + item.count

                -- Chest slots:
                local t = result[item.name].chests[chestName] or {}
                table.insert(t, slot)
                result[item.name].chests[chestName] = t
            end
        end
    end
    return result
end


function storage.pushSlotToChests(slot)
    if chests.input.getItemDetail(slot) == nil then return 0 end
    for name, _ in pairs(chests.storage) do
        local amount = chests.input.pushItems(name, slot)
        if chests.input.getItemDetail(slot) == nil then return amount end
    end
    print("Failed to push items from slot " .. slot .. "...")
    return 0
end

function storage.pushAllItemsToChests()
    print("Pushing items to storage...")
    local itemCount = 0
    for slot, item in pairs(chests.input.list()) do
        itemCount = itemCount + storage.pushSlotToChests(slot)
    end
    print("Pushed " .. itemCount .. "items to storage.")
end


function storage.pullItemByName(name)
    local modlessName = utils.getItemNameComponents(name).item
    local locations = storage.findItemByName(name)
    if locations == {} then
        print("Item " .. modlessName .. " not found :(")
        return
    end

    local itemCount = 0
    print("Pulling items...")
    for chestName, slots in pairs(locations) do
        for index = 1, #slots do
            local slot = slots[index]
            local amount = chests.output.pullItems(chestName, slot)
            itemCount = itemCount + amount
            if amount == 0 then
                print("Pulled " .. itemCount .. "items from storage, but was stopped... is output chest filled up?")
                return
            end
        end
    end
    print("Pulled " .. itemCount .. "items from storage.")
end

return storage
