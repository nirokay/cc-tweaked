local devices = require("devices")

local reactor = devices.reactor
local turbine = devices.turbine

local monitorReactor = devices.monitor.reactor
local monitorTurbine = devices.monitor.turbine

local currentMonitor = monitorReactor


local ui = {}

local additionalLines = 0

function ui.writeCentered(line, text)
    local width, _ = currentMonitor.getSize()
    currentMonitor.setCursorPos((width - #text) / 2 + 1, line + additionalLines)
    currentMonitor.clearLine()
    currentMonitor.write(text)
end
function ui.writeColouredCentered(line, colour, text)
    currentMonitor.setTextColor(colour)
    ui.writeCentered(line, text)
end

function fmtDecimal(num)
    if num == nil then return 0 end
    return math.floor(num * 100) / 100
end

function fmtEnergy(num)
    -- Display upto 999.99 FE
    local fe = fmtDecimal((num or 0) / 2.5) -- why do i need to do this?
    if fe < 1000 then
        return fmtDecimal(fe) .. " FE/t"
    end

    -- Display upto 999.99 kFE
    local kFe = fmtDecimal(fe / 1000)
    if kFe < 1000 then
        return fmtDecimal(kFe) .. " kFE/t"
    end

    -- Display upto 999.99 mFE/t
    local mFE = fmtDecimal(fe / 1000)
    if mFE < 1000 then
        return fmtDecimal(mFE) .. " kFE/t"
    end

    -- Display x gFE/t for all above
    local gFE = fmtDecimal(mFE / 1000)
    return fmtDecimal(gFE .. " gFE/t")
end


function ui.updateReactor()
    currentMonitor = monitorReactor
    ui.writeColouredCentered(
        1,
        colours.yellow,
        "Set burn rate: " .. reactor.getBurnRate()
    )
    ui.writeColouredCentered(
        2,
        colours.orange,
        "Temperature: " .. fmtDecimal(reactor.getTemperature()) .. "K"
    )
    ui.writeColouredCentered(
        3,
        colours.red,
        "Damage: " .. fmtDecimal(reactor.getDamagePercent()) .. "%"
    )
    ui.writeColouredCentered(
        4,
        colours.brown,
        "Waste: " .. fmtDecimal(reactor.getWasteFilledPercentage()) .. "%"
    )
end

function ui.updateTurbine()
    currentMonitor = monitorTurbine
    ui.writeColouredCentered(
        1,
        colours.yellow,
        "Production: " .. fmtEnergy(turbine.getProductionRate())
    )
    ui.writeColouredCentered(
        2,
        colours.lightGrey,
        "Steam: " .. fmtDecimal(turbine.getSteamFilledPercentage()) .. "%"
    )
end

return ui
