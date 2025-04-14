local storage = require("storage")

local ui = {}
local monitor = peripheral.find("monitor")
local lineNumbers = {
    title = 2,
    slots = {
        title = 4,
        text = 5,
        chart = 6
    },
    items = {
        title = 8,
        text = 9,
        chart = 10
    }
}
local alreadyInit = false

local bgColour = colors.black

local details = {} --storage.getInformation()

function ui.noMonitor()
    local result = monitor == nil
    if result == nil then
        print("No monitor found, cannot render to it.")
    end
    return result
end

function ui.writeCentered(line, text)
    local width, _ = monitor.getSize()
    monitor.setCursorPos((width - #text) / 2, line)
    monitor.write(text)
end




function ui.drawChart(line, minMax)
    local percentage = minMax.occupied / minMax.total

    local barBgColour = colors.gray
    local barFgColour = colors.white

    if percentage <= 0.4 then barFgColour = colors.green
    elseif percentage <= 0.6 then barFgColour = colors.lime
    elseif percentage <= 0.75 then barFgColour = colors.yellow
    elseif percentage <= 0.85 then barFgColour = colors.orange
    else barFgColour = colors.red
    end

    local roundedNumber = percentage * 100
    if math.ceil(roundedNumber) == math.ceil(roundedNumber + 0.5) then
        roundedNumber = math.ceil(roundedNumber)
    else
        roundedNumber = math.floor(roundedNumber)
    end
    local prettyPercentage = " " .. roundedNumber .. "%"

    local width, _ = monitor.getSize()
    local barLength = width - 2 - #prettyPercentage
    for column = 1, barLength do
        monitor.setCursorPos(column + 1, line)
        local barPercentage = column / barLength * 100
        if math.floor(barPercentage) <= roundedNumber then
            monitor.setBackgroundColor(barFgColour)
        else
            monitor.setBackgroundColor(barBgColour)
        end
        monitor.write(" ")
    end
    monitor.setBackgroundColor(colors.black)
    monitor.write(prettyPercentage)
end

function ui.placeHolderLoading()
    for _, line in pairs({lineNumbers.slots.chart, lineNumbers.items.chart}) do
        ui.writeCentered(line, "Loading...")
    end
    
end

function ui.draw()
    ui.writeCentered(lineNumbers.title, "Storage System")
    ui.writeCentered(lineNumbers.slots.title, "Slots")
    ui.writeCentered(lineNumbers.items.title, "Items")

    if alreadyInit and details.slots ~= nil then
        ui.writeCentered(lineNumbers.slots.text, details.slots.occupied .. " / " .. details.slots.total .. " (" .. details.slots.available .. " free)")
        ui.writeCentered(lineNumbers.items.text, details.items.occupied .. " / " .. details.items.total .. " (" .. details.items.available .. " free)")

        ui.drawChart(lineNumbers.slots.chart, details.slots)
        ui.drawChart(lineNumbers.items.chart, details.items)
    else
        monitor.setForegroundColor(colors.lightGray)
        ui.writeCentered(lineNumbers.slots.text, "Loading...")
        ui.writeCentered(lineNumbers.items.text, "Loading...")
        monitor.setForegroundColor(colors.white)

        ui.drawChart(lineNumbers.slots.chart, {
            total = 1,
            occupied = 0,
            available = 1
        })
        ui.drawChart(lineNumbers.items.chart, {
            total = 1,
            occupied = 0,
            available = 1
        })
    end
end

function ui.update()
    if ui.noMonitor() then return end
    monitor.clear()

    -- Draw old screen or placeholder:
    ui.draw()

    -- Expensive task:
    details = storage.getInformation()

    -- Draw new screen:
    ui.draw()
    alreadyInit = true
end

return ui
