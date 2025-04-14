local url = "https://raw.githubusercontent.com/nirokay/cc-tweaked/refs/heads/master/storage/"
local fileName = "install.lua"

local function urlToFile(name)
    local file = io.open(name, "w")
    local internet = http.get(url .. name)
    local text = internet.readAll()
    if file ~= nil then
        file:write(text)
        file:close()
        print("Installed file '" .. name .. "'!")
    else
        print("Failed to open file '" .. name .. "'!")
    end
end

print("Downloading install file...")
urlToFile(fileName)

local file = io.open(fileName, "r")
if file ~= nil then
    file:close()
    print("Installing...")
    os.run({}, "/" .. fileName)
    print("Installation completed!")
else
    print("Failed to run install, file '" .. fileName .. "' not found!")
end

