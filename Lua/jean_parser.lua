local JeanParser = {}

local function is_whitespace(c)
    return c == " " or c == "\t" or c == "\n" or c == "\r"
end

function JeanParser.parse_jean_data(text)
    local tokens = {}
    local i = 1
    local n = #text

    while i <= n do
        local char = text:sub(i, i)

        if is_whitespace(char) then
            i = i + 1

        elseif char == "%" then
            while i <= n and text:sub(i, i) ~= "\n" and text:sub(i, i) ~= "\r" do
                i = i + 1
            end

        elseif char == '"' then
            local str_start = i + 1
            i = i + 1
            while i <= n and text:sub(i, i) ~= '"' do
                i = i + 1
            end

            if i > n then
                io.stderr:write("JEAN Parser: Unterminated string literal\n")
                return tokens
            end

            table.insert(tokens, text:sub(str_start, i - 1))
            i = i + 1

        else
            local word_start = i
            while i <= n and not is_whitespace(text:sub(i, i)) and text:sub(i, i) ~= "%" do
                i = i + 1
            end

            local word = text:sub(word_start, i - 1)

            if #word > 0 then
                if word == "t" then
                    table.insert(tokens, true)
                elseif word == "f" then
                    table.insert(tokens, false)
                else
                    local num = tonumber(word)
                    if num ~= nil then
                        table.insert(tokens, num)
                    else
                        io.stderr:write("JEAN Parser: Unrecognized token '" .. word .. "'\n")
                    end
                end
            end
        end
    end

    return tokens
end

function JeanParser.parse_jean_file(file_path)
    local file, err = io.open(file_path, "r")
    if not file then
        io.stderr:write("JEAN Parser: Could not open file - " .. tostring(err) .. "\n")
        return {}
    end

    local content = file:read("*a")
    file:close()

    return JeanParser.parse_jean_data(content)
end

return JeanParser