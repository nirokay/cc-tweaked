local config = require("config")

local devices = {
    relay = {
        fuel = peripheral.wrap(config.id.relay.fuel),
        water = peripheral.wrap(config.id.relay.water),
        burnRateOutput = peripheral.wrap(config.id.relay.burnRateOutput),
        burnRateInput = peripheral.wrap(config.id.relay.burnRateInput)
    },
    reactor = peripheral.wrap(config.id.reactor),
    monitor = peripheral.wrap(config.id.monitor)
}

function devices.setPower(device, level)
    device.setAnalogOutput(config.relayOutputPowerDirection, level)
end

if devices.relay.fuel == nil then error("Fuel display unconnected!") end
if devices.relay.water == nil then error("Water display unconnected!") end
if devices.relay.burnRateOutput == nil then error("Burn rate display unconnected!") end
if devices.relay.burnRateInput == nil then error("Burn rate input unconnected!") end


return devices
