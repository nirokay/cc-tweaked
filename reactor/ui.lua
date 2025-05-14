local devices = require("devices")
local monitor = devices.monitor
local reactor = devices.reactor

monitor.setTextScale(1)

local ui = {}

local additionalLines = 1

function ui.writeCentered(line, text)
    local width, _ = monitor.getSize()
    monitor.setCursorPos((width - #text) / 2 + 1, line + additionalLines)
    monitor.clearLine()
    monitor.write(text)
end
function ui.writeColouredCentered(line, colour, text)
    monitor.setTextColor(colour)
    ui.writeCentered(line, text)
end

function fmt(num)
    return math.floor(num * 100) / 100
end

function ui.update()
    ui.writeColouredCentered(
        1,
        colours.yellow,
        "Set burn rate: " .. reactor.getBurnRate()
    )
    ui.writeColouredCentered(
        2,
        colours.orange,
        "Temperature: " .. fmt(reactor.getTemperature()) .. "K"
    )
    ui.writeColouredCentered(
        3,
        colours.red,
        "Damage: " .. fmt(reactor.getDamagePercent()) .. "%"
    )
    ui.writeColouredCentered(
        4,
        colours.brown,
        "Waste: " .. fmt(reactor.getWasteFilledPercentage()) .. "%"
    )
end

return ui
