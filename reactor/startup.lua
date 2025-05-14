local devices = require("devices")
local config = require("config")
local utils = require("utils")
local ui = require("ui")

local reactor = devices.reactor

local debugPrint = true
while true do
    -- Input:
    reactor.setBurnRate(
        math.min(
            devices.relay.burnRateInput.getAnalogInput(config.relayInputPowerDirection),
            reactor.getMaxBurnRate()
        )
    )

    -- Displays:
    devices.setPower(
        devices.relay.fuel,
        utils.getPercentage(
            reactor.getFuel().amount,
            reactor.getFuelCapacity(),
            config.redstoneLimit
        )
    )
    devices.setPower(
        devices.relay.water,
        utils.getPercentage(
            reactor.getCoolant().amount,
            reactor.getCoolantCapacity(),
            config.redstoneLimit
        )
    )
    devices.setPower(
        devices.relay.burnRateOutput,
        math.min(config.mathRoundingFunction(reactor.getActualBurnRate()), 15)
    )

    -- Monitor:
    if devices.monitor then
        ui.update()
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
