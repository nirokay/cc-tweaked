local options = require("options")
local chests = require("chests")
local storage = {}

--[[
function storage.findChestWithItem(itemName)
    local result = {}
    for name, chest in pairs(chests.storage) do
        local list = chest.list()
        for i, slot in pairs(list) do

        end
    end
    if #result == 0 then result[1] = chests.storage end
end

]]--

function storage.pushSlotToChests(slot)
    local itemCount = chests.input.getItemDetail(slot)
    if itemCount == nil then return end

    for name, chest in ipairs(chests.storage) do
        local pushedItems = chest.input.pushItems(name, slot)
        print("Pushed " .. pushedItems .. " items")
        if chests.input.getItemDetail(slot) == nil or chests.input.getItemDetail(slot) == 0 then return end
    end
    if chests.input.getItemDetail(slot) ~= nil and chests.input.getItemDetail(slot) ~= 0 then
        print("Could not push items!")
    end
end

function storage.pushAllItemsToChests()
    for slot, item in ipairs(chests.input.list()) do
        storage.pushSlotToChests(slot)
    end
end

return storage
