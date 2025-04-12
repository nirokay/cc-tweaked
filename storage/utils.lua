local utils = {}

function utils.getItemNameComponents(itemName)
    local nameMod, nameItem = itemName:match("([^,]+):([^,]+)")
    return {
        mod = nameMod,
        item = nameItem
    }
end

return utils
