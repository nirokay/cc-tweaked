local storage = require("storage")
local userdata = require("disk/userdata")

local ui = {}

local additionalLines = 1
local monitor = peripheral.find("monitor") or error("You need to connect a monitor.")

function ui.writeCentered(line, text)
    local width, _ = monitor.getSize()
    monitor.setCursorPos((width - #text) / 2 + 1, line + additionalLines)
    monitor.write(text)
end

function ui.resetColors()
    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.white)
end
function ui.setCustomFontColour(col)
    monitor.setTextColor(col or colors.white)
end

function ui.writeComments(comments)
    if comments == nil then return end
    if #comments == 0 then return end
    monitor.setBackgroundColor(colors.red)
    monitor.setTextColor(colors.white)
    for line, comment in pairs(comments) do
        monitor.setCursorPos(1, line)
        monitor.write(comment)
    end
    ui.resetColors()
end

function ui.update(comments)
    monitor.setTextScale(userdata.text.fontScale or 1)
    ui.resetColors()
    monitor.clear()

    ui.setCustomFontColour(userdata.text.owner.color)
    ui.writeCentered(1, userdata.text.owner.text .. "'s shop")
    ui.setCustomFontColour(userdata.text.description.color)
    ui.writeCentered(2, userdata.text.description.text)

    ui.setCustomFontColour(userdata.text.availability.color)
    ui.writeCentered(4, "Selling, " .. storage.getAllPossibleTransactions() ..  " available:")

    ui.setCustomFontColour(userdata.transaction.goods.color)
    ui.writeCentered(5, userdata.transaction.goods.quantity .. "x " .. userdata.transaction.goods.name)

    local costString = ""
    if #userdata.transaction.payments > 1 then
        costString = "Choose Payment:"
    else
        costString = "Payment:"
    end
    ui.setCustomFontColour(userdata.text.payment.color)
    ui.writeCentered(7, costString)

    for index, item in pairs(userdata.transaction.payments) do
        ui.setCustomFontColour(item.color)
        ui.writeCentered(7 + index, item.quantity .. "x " .. item.name)
    end

    ui.resetColors()
    ui.writeComments(comments)
end

ui.update()

return ui
