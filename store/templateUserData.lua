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

return userdata
