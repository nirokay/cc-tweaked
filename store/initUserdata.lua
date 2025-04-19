local pathUserData = "disk/userdata.lua"

if not fs.exists(pathUserData) then
    if not fs.exists("disk") then
        error("Please insert disk into disk drive.")
    end

    local template = io.open("templateUserData.lua", "r")
    if template == nil then
        error("User Data Template file does not exist, cannot initialise.")
    end
    local target = io.open(pathUserData, "w")
    if target == nil then
        template:close()
        error("Could not open file '/" .. pathUserData .. "' to write init, you may have to manually do that.")
    end
    target:write(template:read("a"))

    target:close()
    template:close()

    os.run({}, "edit /" .. pathUserData)
    -- error("Initialised userdata file, please modify it (location: '/" .. pathUserData.. "')!")
    error("Modified userdata file, please restart the computer.")
end
