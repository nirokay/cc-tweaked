local device = require("devices")
local userdata = require("disk/userdata")
local storage = {
    warnings = {}
}

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

function storage.getMaxPossibleTransactions()
    local result = math.floor(storage.getGoodsCount() / userdata.transaction.goods.quantity)
    return result
end

function storage.returnChangeToBuyer(itemsTable)
end

function storage.transactionGiveGoods()
    local amountToGive = userdata.transaction.goods.quantity
    for slot, item in pairs(device.goodsStorage.list()) do
        --local item = device.goodsStorage.getItemDetail(slot)
        print(slot, item)
        if item ~= nil then
            if item.name == userdata.transaction.goods.name then
                local currentPush = device.goodsOutput.pullItems(userdata.ids.goodsStorage, slot, amountToGive)
                amountToGive = amountToGive - currentPush
                if amountToGive <= 0 then return true end
            end
        end
    end
end

function storage.refundMoney(paymentItemName, count)
    if count == 0 then return end
    local toRefund = count
    for slot, item in pairs(device.paymentStorage.list()) do
        if item.name == paymentItemName then
            device.paymentStorage.pushItems(userdata.ids.paymentInput, slot, toRefund)
            if toRefund == 0 then
                return
            end
        end
    end
end

function storage.transactionTakeMoney(payment)
    local moneyTaken = 0
    for slot, item in pairs(device.paymentInput.list()) do
        if item.name == payment.name then
            moneyTaken = moneyTaken + device.paymentInput.pushItems(userdata.ids.paymentStorage, slot)
        end
    end

    local transactions = math.floor(moneyTaken / payment.quantity)
    local refund = 0
    if transactions == 0 then
        refund = moneyTaken
    else
        refund = moneyTaken % (payment.quantity * transactions)
    end
    storage.refundMoney(payment.name, refund)
    if refund ~= 0 then
        print("Refunding " .. refund .. "x " .. payment.name)
    end
    return transactions
end

-- @returns `table` array of strings (comments)
function storage.performTransactions()
    local maxTransactions = storage.getMaxPossibleTransactions()
    if maxTransactions == 0 then return {
        "No supply left."
    } end

    local result = {}
    local paidTransactions = 0
    for _, payment in pairs(userdata.transaction.payments) do
        paidTransactions = paidTransactions + storage.transactionTakeMoney(payment)
        if paidTransactions > maxTransactions then
            local refundTransactions = paidTransactions - maxTransactions
            local refundItems = refundTransactions * payment.quantity
            storage.refundMoney(payment.name, refundItems)
            table.insert(result, "Refunded " .. refundTransactions .. " transactions (" .. refundItems .. "x " .. payment.name .. ")")
            paidTransactions = paidTransactions - refundTransactions
        end
    end
    if paidTransactions == 0 then return {
        "No payment given."
    } end
    for transaction = 1, paidTransactions do
        print(transaction, paidTransactions)
        storage.transactionGiveGoods()
    end
end

return storage
