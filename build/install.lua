function Write_File(path, data)
    fs.delete(path)

    local file = fs.open(path, "w")

    if file then
        file.write(data) -- Write content to the file
        file.close()     -- Close the file
        print(" - " .. path)
        return true
    end

    print("File failed to create")
    return false
end

function Github_Download(path, githubPath)
    local url = "https://raw.githubusercontent.com/Jerry-Todd/Boxel/main/"
    local cacheBuster = os.epoch("utc") -- Get the current timestamp
    local file = http.get(url .. githubPath .. "?t=" .. cacheBuster)
    if file then
        file = file.readAll()
        if not Write_File(path, file) then return false end
        return true
    else
        print("Github / Cant get file: " .. githubPath)
        return false
    end
end

local x, y = term.getCursorPos()
local input = ""
while true do
    term.setCursorPos(x, y)
    write('Start boxel when computer starts?\nY/N/C - Yes/No/Cancel')
    local event, key = os.pullEvent("key")
    input = string.lower(keys.getName(key))
    if input == 'y' or input == 'n' then
        break
    elseif input == 'c' then
        print("Canceled install.")
        return
    end
end

term.clear()
term.setCursorPos(1,1)
if Github_Download("boxel.lua", "build/app.lua") then
    fs.delete("boxelAPI.lua")
    print("Boxel installed")
    if input == 'y' then
        print("Boxel will start automatically")
        Write_File("startup.lua", "shell.run('boxel')")
    end
    sleep(2)
    os.reboot()
else
    print("Boxel failed to install")
end
