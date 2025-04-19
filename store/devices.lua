local userdata = require("disk/userdata")

local device = {
    paymentInput = nil,
    paymentStorage = nil,
    goodsStorage = nil,
    goodsOutput = nil
}

local function findOrWrap(name)
    local functions = {
        peripheral.wrap,
        peripheral.find
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
