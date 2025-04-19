local url = "https://raw.githubusercontent.com/nirokay/cc-tweaked/refs/heads/master/store/"
local files = {
    "devices.lua",
    "startup.lua",
    "templateUserData.lua"
}

local function urlToFile(name)
    local file = io.open(name, "w")
    local internet = http.get(url .. name)
    if internet == nil then
        print("Failed to load file '" .. name .. "'!")
        return
    end
    local text = internet.readAll()
    if file ~= nil then
        file:write(text)
        file:close()
        print("Installed file '" .. name .. "'!")
    else
        print("Failed to open file '" .. name .. "'!")
    end
end

print("Installing through the internet...")
for _, name in pairs(files) do
    print("Installing '" .. name .. "'")
    urlToFile(name)
end
print("Finished installation!")
