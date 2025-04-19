-- Init user data:
require("initUserdata")

-- Load devices:
local device = require("devices")
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

    return true
end

print("Initialised, listening for redstone requests...")
while true do
    -- Perform purchase or exit early:
    local moreTime = main()

    -- Reset comments after being drawn:
    comments = {}

    -- Sleep:
    local sleepTime = 0.25
    if moreTime then sleepTime = 5 end
    os.sleep(sleepTime)
end
