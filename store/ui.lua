local userdata = require("disk/userdata")
local ui = {}

local additionalLines = 1
local monitor = peripheral.find("monitor") or error("You need to connect a monitor.")


function ui.writeCentered(line, text)
    local width, _ = monitor.getSize()
    monitor.setCursorPos((width - #text) / 2 + 1, line + additionalLines)
    monitor.write(text)
end

function ui.update()
    ui.writeCentered(1, userdata.owner .. "'s shop")
    ui.writeCentered(2, userdata.description)

    ui.writeCentered(4, "Selling:")
    ui.writeCentered(5, userdata.transaction.goods.quantity .. "x " .. userdata.transaction.goods.name)

    local costString = ""
    if #userdata.transaction.payments > 1 then
        costString = "Choose Payment:"
    else
        costString = "Payment"
    end
    ui.writeCentered(7, costString)
    for index, item in pairs(userdata.transaction.payments) do
        ui.writeCentered(7 + index, item.quantity .. "x " .. item.name)
    end
end

ui.update()

return ui
