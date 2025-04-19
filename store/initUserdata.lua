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
        error("Could not open file '/disk/userdata.lua' to write init.")
        template:close()
    end
    target:write(template:read("a"))

    target:close()
    template:close()

    error("Initialised userdata file, please modify it (location: '/disk/userdata.lua')!")
end
