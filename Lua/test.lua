local JeanParser = require("Lua.jean_parser")

-- Standard Lua:
local function read_file(file_path)
    local file, err = io.open(file_path, "r")
    if not file then
        print("Error opening file: " .. tostring(err))
        return nil
    end

    local content = file:read("*a")
    file:close()
    
    return content
end

local file = read_file("example.jean")

if file then
    local data = JeanParser.parse_jean_data(file)
    print(table.unpack(data))
end

-- LOVE2D Lua:
local file = love.filesystem.read("example.jean")

if file then
    local data = JeanParser.parse_jean_data(file)
    print(table.unpack(data))
end