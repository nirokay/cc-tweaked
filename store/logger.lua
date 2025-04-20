local logger = {
    file = "disk/history.log"
}

function logger.getTimeStamp()
    return os.date()
end

local function logLine(text)
    return "\n" .. logger.getTimeStamp() .. " --- " .. text
end

if not fs.exists(logger.file) then
    local file = io.open(logger.file, "w")
    if file == nil then
        error("Could not init file '" .. logger.file .. "'!")
    end
    file:write(logLine("File init\n"))
end

function logger.write(line)
    local file = io.open(logger.file, "a")
    if file == nil then
        print(logLine("Failed to log to log file!"))
        return
    end
    file:write(logLine(line))
    file:close()
end

return logger
