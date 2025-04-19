local userdata = require("disk/userdata")
local device = {}

function device.findOrWrap(name) -- unused, i will need ids further on
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

device.paymentInput = peripheral.wrap(userdata.ids.paymentInput) or error("Failed to mount payment input")
device.paymentStorage = peripheral.wrap(userdata.ids.paymentStorage) or error("Failed to mount payment storage")
device.goodsOutput = peripheral.wrap(userdata.ids.goodsOutput) or error("Failed to mount goods output")
device.goodsStorage = peripheral.wrap(userdata.ids.goodsStorage) or error("Failed to mount goods storage")

return device
