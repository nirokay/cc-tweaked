-- Crude and un-portable script, it just has to work lol

local runs = 0

local items = {
    stationary = "pamhc2foodcore:juiceritem",
    ingredient = "minecraft:egg",
    target = "pamhc2foodcore:mayonaiseitem"
}
local craftingGrid = {
    1, 2, 3,
    5, 6, 7,
    9, 10, 11
}

local function handleItem(details)
    if details == nil then return end
    local name = details.name
    if name == items.stationary then
        return
    elseif name == items.ingredient then
        turtle.dropUp()
    elseif name == items.target then
        turtle.dropDown()
    else
        turtle.drop()
    end
end
function clearInventory()
    for slot = 1, 16 do
        turtle.select(slot)
        handleItem(turtle.getItemDetail())
    end
end

function tryCrafting()
    turtle.select(2)

    local status, message = turtle.craft()
    if turtle.getItemDetail() == nil then return end
    clearInventory()
end

while true do
    print("Running " .. runs)
    tryCrafting()

    -- Scheduled inv clear:
    if runs % 20 == 0 then
        clearInventory()
    end

    runs = runs + 1
    sleep(2)
end
