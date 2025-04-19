local userdata = require("disk/userdata.lua")

if userdata == nil then
    if not fs.exists("disk") then
        error("Uninitialised userdata.lua file, please insert disk into disk drive.")
    end
    if not fs.exists("disk/userdata.lua") then
        local template = io.open("templateUserData.lua", "r")
        if template == nil then
            error("User Data Template file does not exist, cannot initialise.")
        end
        local target = io.open("disk/userdata.lua", "w")
        if target == nil then
            error("Could not open file '/disk/userdata.lua' to write init.")
            template:close()
        end
        target:write(template:read())

        target:close()
        template:close()
    end
    error("Initialised userdata file, please modify it (location: '/disk/userdata.lua')!")
end

local device = {
    paymentInput = nil,
    paymentStorage = nil,
    goodsStorage = nil,
    goodsOutput = nil
}

local function findOrWrap(name)
    local functions = {
        peripheral.find,
        peripheral.wrap
    }

    local result = nil
    for _, fn in pairs(functions) do
        if result ~= nil then return result end
        result = fn(name)
    end
    return result
end

function device.findDevices()
    device.paymentInput = findOrWrap(userdata.ids.paymentInput) or error("Failed to mount payment input")
    device.paymentStorage = findOrWrap(userdata.ids.paymentStorage) or error("Failed to mount payment storage")
    device.goodsOutput = findOrWrap(userdata.ids.goodsOutput) or error("Failed to mount goods output")
    device.goodsStorage = findOrWrap(userdata.ids.goodsStorage) or error("Failed to mount goods storage")
end

device.findDevices()

return device
