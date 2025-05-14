local config = {
    id = {
        relay = {
            fuel = "redstone_relay_4",
            water = "redstone_relay_3",
            burnRateOutput = "redstone_relay_2",
            burnRateInput = "redstone_relay_5"
        },
        reactor = "back",
        monitor = "monitor_1"
    },

    relayOutputPowerDirection = "bottom",
    relayInputPowerDirection = "top",

    redstoneLimit = 10,

    mathRoundingFunction = math.floor
}

return config
