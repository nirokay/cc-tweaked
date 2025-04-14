local storage = require("storage")

local ui = {}
local monitor = peripheral.find("monitor")
local lineNumbers = {
    title = 2,
    slots = 4,
    items = 6
}

local details = storage.getInformation()

local function noMonitor()
    local result = monitor == nil
    if result == nil then
        print("No monitor found, cannot render to it.")
    end
    return result
end

local function writeCentered(line, text)
    local x, _ = monitor.getSize()
    monitor.setCursorPos(line, (x - #text) / 2)
end


function ui.writeSlots()
    writeCentered(lineNumbers.slots, details.slots.occupied .. " / " .. details.slots.total .. " (" .. details.slots.available .. ")")
end
function ui.writeItems()
    writeCentered(lineNumbers.items, details.items.occupied .. " / " .. details.items.total .. " (" .. details.items.available .. ")")
end

function ui.update()
    if noMonitor() then return end
    details = storage.getInformation()

    writeCentered(lineNumbers.title, "Storage System")
    ui.writeSlots()
    ui.writeItems()
end

return ui
