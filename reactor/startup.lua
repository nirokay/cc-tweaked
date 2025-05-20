local devices = require("devices")
local config = require("config")
local utils = require("utils")
local ui = require("ui")

local reactor = devices.reactor

local debugPrint = true
while true do
    -- Input:
    if devices.relay.shutdown ~= nil then
        if devices.relay.shutdown.getAnalogInput(config.direction.relay.shutdownInput) ~= 0 then
            if reactor.getStatus() then reactor.scram() end
        end
    end
    reactor.setBurnRate(
        math.min(
            devices.relay.burnRateInput.getAnalogInput(config.direction.relay.burnRateInput) or 0,
            reactor.getMaxBurnRate() or 0
        )
    )

    -- Displays:
    devices.setPower(
        devices.relay.fuel,
        utils.getPercentage(
            reactor.getFuel().amount or 0,
            reactor.getFuelCapacity() or 0,
            config.redstoneLimit
        )
    )
    devices.setPower(
        devices.relay.water,
        utils.getPercentage(
            reactor.getCoolant().amount or 0,
            reactor.getCoolantCapacity() or 0,
            config.redstoneLimit
        )
    )
    devices.setPower(
        devices.relay.burnRateOutput,
        math.min(config.mathRoundingFunction(reactor.getActualBurnRate() or 0), 15)
    )

    -- Monitor:
    if devices.monitor ~= nil then
        ui.updateReactor()
        ui.updateTurbine()
    end

    -- Log:
    if debugPrint then
        local lines = {
            "Top redstone output: " .. config.redstoneLimit,
            "- - - - - - - - - - - -",
            "Fuel percentage: " .. reactor.getFuelFilledPercentage(),
            "Coolant percentage: " .. reactor.getCoolantFilledPercentage(),
            "Set burn rate: " .. reactor.getBurnRate(),
            "Current burn rate: " .. reactor.getActualBurnRate(),
        }
        term.setCursorPos(1, 1)
        term.clear()
        print(table.concat(lines, "\n"))
    end
    os.sleep(0.25)
end
