-- Init user data:
require("initUserdata")

-- Load devices:
local device = require("devices")
local storage = require("storage")
local relay = peripheral.find("redstone_relay") or error("Redstone relay required to be connected.")

-- Display on monitor:
local ui = require("ui")
local comments = {
    "System booted up!"
}


local function main()
    ui.update(comments)
    if not relay.getInput("front") then return false end

    -- Perform transaction:
    print("Performing transaction...")
    comments = storage.performTransactions()

    return true
end

print("Initialised, listening for redstone requests...")
while true do
    -- Perform purchase or exit early:
    local moreTime = main()
    ui.update(comments)

    -- Reset comments after being drawn:
    comments = {}

    -- Sleep:
    local sleepTime = 0.2
    if moreTime then sleepTime = 2 end
    os.sleep(sleepTime)
end
