local utils = {}

function utils.getItemNameComponents(itemName)
    local nameMod, nameItem = itemName:match("([^,]+):([^,]+)")
    local result = {
        mod = nameMod or "minecraft",
        item = nameItem or itemName
    }
    return result
end

assert(utils.getItemNameComponents("minecraft:stone").item == "stone", "Failed test 0")
assert(utils.getItemNameComponents("minecraft:stone").mod == "minecraft", "Failed test 1")
assert(utils.getItemNameComponents("stone").item == "stone", "Failed test 2")
assert(utils.getItemNameComponents("stone").mod == "minecraft", "Failed test 3")

return utils
