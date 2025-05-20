local config = require("config")

local devices = {
    relay = {
        fuel = peripheral.wrap(config.id.relay.fuel),
        water = peripheral.wrap(config.id.relay.water),
        burnRateOutput = peripheral.wrap(config.id.relay.burnRateOutput),
        burnRateInput = peripheral.wrap(config.id.relay.burnRateInput),
        shutdown = peripheral.wrap(config.id.relay.shutdown)
    },
    reactor = peripheral.wrap(config.id.reactor),
    turbine = peripheral.wrap(config.id.turbine),
    monitor = {
        reactor = peripheral.wrap(config.id.monitor.reactor),
        turbine = peripheral.wrap(config.id.monitor.turbine)
    }
}

function devices.setPower(device, level)
    device.setAnalogOutput(config.direction.relay.redstoneOutput, level)
end


-- Safe guards:

if devices.relay.fuel == nil then error("Fuel display unconnected!") end
if devices.relay.water == nil then error("Water display unconnected!") end
if devices.relay.burnRateOutput == nil then error("Burn rate display unconnected!") end
if devices.relay.burnRateInput == nil then error("Burn rate input unconnected!") end


return devices
