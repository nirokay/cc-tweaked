-- Config:

local userdata = {
    owner = "", -- Player name of the shop owner,
    description = "", -- Shop description

    ids = {
        paymentInput = "", -- ID of storage device that accepts payments
        paymentStorage = "", -- ID of storage device that stores payments after purchase
        goodsStorage = "", -- ID of storage device that stores goods for trading
        goodsOutput = "" -- ID of storage device that outputs purchased goods
    },

    transaction = {
        goods = {
            name = "", -- Item name, example: "minecraft:wood_log",
            quantity = 0 -- Item quantity, example: 64
        },
        payments = { -- Multiple payment items supported
            {
                name = "", -- Item name, example: "minecraft:diamond",
                quantity = 0 -- Item quantity, example: 1
            }
        }
    }
}


-- Guard rails:

if userdata.ids.goodsOutput == "" then
    error("You need to specify output storage for goods.")
end
if userdata.ids.goodsStorage == "" then
    error("You need to specify storage for goods.")
end
if userdata.ids.paymentInput == "" then
    error("You need to specify payment input.")
end
if userdata.ids.paymentStorage == "" then
    error("You need to specify payment storage.")
end

if userdata.transaction.goods.name == "" or userdata.transaction.goods.quantity == 0 then
    error("You need to specify item information.")
end

if #userdata.transaction.payments == 0 then
    error("You need to have at least one payment item.")
end
for _, payment in pairs(userdata.transaction.payments) do
    if payment.name == "" or payment.quantity == 0 then
        error("You need to specify payment information.")
    end
end


return userdata
