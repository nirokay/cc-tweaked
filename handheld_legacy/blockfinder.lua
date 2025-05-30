-- Load Geoscanner:
scan = peripheral.wrap("back")

-- Terminal Stuff
function screenClear()
    term.clear()
    term.setCursorPos(1, 1)
end


-- VARIABLES:
char = {
    empty  = ".",
    player = "@",
    
    -- Density Mode:
    block  = "x",
    super  = "X",
    
    -- Height Mode:
    high   = "+",
    low    = "-",
    level  = "*"
}
charMode = {
    density = "modeDENSITY",
    height  = "modeHEIGHT"
}

local function promptBlock()
    screenClear()
    print("What block do you want to search for?")
    io.write("? ")
    return io.read()
end


-- CONFIG:
target = ... or promptBlock()

refreshrate = 3
radius = 8

mode = charMode.height


-- FUNCTIONS:



-- Do stuff with blocks idk man:
local function scanBlocks()
    local temp = scan.scan(radius)
    return temp
end

function isolateBlocks(blocks)
    -- Loop through blocks
    local temp = {}
    for i, v in pairs(blocks) do
        if v.name == target then
            table.insert(temp, v)
        end
    end
    return temp
end

-- Map:
function newMap()
    local map = {}
    -- Generate Map:
    for i=1, radius*2+1 do
        -- Generate Lines:
        local line = {}
        for j=1, radius*2+1 do
            table.insert(line, char.empty)
        end
        table.insert(map, line)
    end
    return map
end

function printChar(ch)
    local bg = colours.grey
    term.setBackgroundColour(bg)
    
    if ch == char.empty then
        term.setTextColour(colours.white)
    elseif ch == char.player then
        term.setTextColor(colours.lightBlue)
    else
        term.setTextColour(colours.pink)
    end
    
    io.write(ch)
    
    -- Colour Reset:
    term.setTextColour(colours.white)
    term.setBackgroundColour(colours.black)
end

function drawMap(blocks)
    local map = newMap()
    -- Draw Player Position:
    local temp = map[radius+1]
    temp[radius+1] = char.player
    
    -- Add Block Data to Map
    for i, b in pairs(blocks) do
        local x, z, y = b.x, b.z, b.y
        x = x + radius+1
        z = z + radius+1
        y = y - 1

        -- Display Modes:
        local function modeHeight()
            if y == 0 then
                map[z][x] = char.level
            elseif y < 0 then
                map[z][x] = char.low
            elseif y > 0 then
                map[z][x] = char.high
            end
        end
        local function modeDensity()
            if map[z][x] == char.block then
                map[z][x] = char.super
            elseif map[z][x] == char.empty then
                map[z][x] = char.block
            end
        end

        -- Display Selection:
        if     mode == charMode.density then modeDensity()
        elseif mode == charMode.height  then modeHeight()
        end
    end
    
    -- Print Map:
    for i, line in pairs(map) do
        local ln = ""
        for j, row in pairs(line) do
            printChar(row)
        end
        io.write("\n")
    end
end

-- Software Info Shit:
function printSoftware(x, y)
    term.setCursorPos(x, y)
    term.setTextColour(colours.pink)
    io.write("Kay's Sneaky Blockfinder")
    term.setTextColour(colours.white)
end

-- MAIN:
local search = 1
function main()
    local blocks = isolateBlocks(scanBlocks())
    printSoftware(1, 1)
    term.setCursorPos(1, 2)
    print("Found blocks: " .. #blocks)
    term.setCursorPos(1, 3)
    if #blocks > 0 then
        drawMap(blocks)
    else
        print("Nothing found.")
    end
    io.write(target)
end

while true do
    -- Pre-execution:
    screenClear()
    
    -- Code Execution:
    main()
    
    -- Background stuff:
    os.sleep(refreshrate)
    search = search + 1
end

