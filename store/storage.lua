local device = require("devices")
local userdata = require("disk/userdata")
local storage = {}

function storage.getGoodsCount()
    local result = 0
    local chest = device.goodsStorage
    if chest == nil then error("Goods storage is not defined.") end
    for slot, item in pairs(chest.list()) do
        if item.name == userdata.transaction.goods.name then
            result = result + item.count
        end
    end
    return result
end

return storage
