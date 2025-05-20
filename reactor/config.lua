local config = {
    id = {
        relay = {
            fuel = "redstone_relay_4",
            water = "redstone_relay_3",
            burnRateOutput = "redstone_relay_2",
            burnRateInput = "redstone_relay_5",
            shutdown = "redstone_relay_6"
        },
        reactor = "back",
        turbine = "turbineValve_1",
        monitor = {
            reactor = "monitor_1",
            turbine = "monitor_2"
        }
    },

    direction = {
        relay = {
            redstoneOutput = "bottom",
            burnRateInput = "top",
            shutdownInput = "top"
        }
    },

    redstoneLimit = 10,

    mathRoundingFunction = math.floor
}

return config
