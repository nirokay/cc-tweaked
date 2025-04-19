local userdata = require("disk/userdata")
local device = {}

function device.findOrWrap(name)
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

device.paymentInput = device.findOrWrap(userdata.ids.paymentInput) or error("Failed to mount payment input")
device.paymentStorage = device.findOrWrap(userdata.ids.paymentStorage) or error("Failed to mount payment storage")
device.goodsOutput = device.findOrWrap(userdata.ids.goodsOutput) or error("Failed to mount goods output")
device.goodsStorage = device.findOrWrap(userdata.ids.goodsStorage) or error("Failed to mount goods storage")

return device
