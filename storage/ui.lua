local storage = require("storage")

local ui = {}
local monitor = peripheral.find("monitor")
local lineNumbers = {
    title = 2,
    slots = 4,
    items = 6
}

local details = {} --storage.getInformation()

function ui.noMonitor()
    local result = monitor == nil
    if result == nil then
        print("No monitor found, cannot render to it.")
    end
    return result
end

function ui.writeCentered(line, text)
    local _, width = monitor.getSize()
    monitor.setCursorPos(line, (width - #text) / 2)
    monitor.write(line)
end


function ui.writeSlots()
    ui.writeCentered(lineNumbers.slots, details.slots.occupied .. " / " .. details.slots.total .. " (" .. details.slots.available .. ")")
end
function ui.writeItems()
    ui.writeCentered(lineNumbers.items, details.items.occupied .. " / " .. details.items.total .. " (" .. details.items.available .. ")")
end

function ui.update()
    if ui.noMonitor() then return end
    details = storage.getInformation()

    ui.writeCentered(lineNumbers.title, "Storage System")
    ui.writeSlots()
    ui.writeItems()
end

return ui
