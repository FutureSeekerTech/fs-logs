local QBCore = exports['qb-core']:GetCoreObject()
local TablePlayer = {}
local DebugMode = true -- Set to true to see debug messages on console
-- type: player/server
-- category: inventory/money/item/activity
-- message: Message to saved on log
function AddToLog(type, category, message, args)
    Citizen.CreateThread(function()
        print("AddToLog: "..type.." "..category.." "..message.." "..args)
        local gt = os.date('*t')
        local date = gt['day'].."-"..gt['month'].."-"..gt['year']
        local h = gt['hour'] if h < 10 then h = "0"..h end
        local m = gt['min'] if m < 10 then m = "0"..m end
        local s = gt['sec'] if s < 10 then s = "0"..s end
        local formattedlog = string.format("[%s %s:%s:%s] [%s] %s \n",date,h,m,s,category,message)
        if type == "player" then
            if TablePlayer[args] == nil then print("table empty") print(json.encode(TablePlayer)) return end
            local filelocation = "logs/player/"..TablePlayer[args]['filename']..".log"
            local f,err = io.open(filelocation,"a")
            if not f then return print(err) end
            f:write(formattedlog)
            f:close()
            if DebugMode then
                print("log message: "..message)
                print("Saved log player to "..filelocation)
            end
        elseif type == "server" then
            if args ~= "keyforserverlog" then return end
            local filelocation = "logs/server/server.log"
            local f,err = io.open(filelocation,"a")
            if not f then return print(err) end
            f:write(formattedlog)
            f:close()
            if DebugMode then
                print("log message: "..message)
                print("Saved log server to "..filelocation)
            end
        end
    end)
end

RegisterNetEvent('fs-logs:server:log')
AddEventHandler('fs-logs:server:log', function(type, category, message, args)
    if type == "player" and args ~= nil then
        AddToLog(type, category, message, args)
    elseif type == "player" and args == nil then
        AddToLog(type, category, message, source)
    elseif type == "server" then
        AddToLog(type, category, message, args)
    end
end)

RegisterNetEvent('fs-logs:server:playerLoaded')
AddEventHandler('fs-logs:server:playerLoaded', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerData = Player.PlayerData
    local SteamName = GetPlayerName(src)
    local FullName = PlayerData.charinfo.firstname .. ' ' .. PlayerData.charinfo.lastname
    local FormatedFileName = string.gsub(FullName, ' ', '_')
    local FormatedFileName = string.gsub(FormatedFileName, "'", '')
    local FormatedFileName = string.gsub(FormatedFileName, '"', '')
    TablePlayer[src] = {
        ['fullname'] = FullName,
        ['filename'] = FormatedFileName,
        ['steamname'] = SteamName,
    }
    AddToLog("player", "player", "Player "..FullName.." ("..SteamName..") loaded", src)
end)

-- RegisterNetEvent('fs-logs:server:playerDropped')
-- AddEventHandler('fs-logs:server:playerDropped', function()
--     local src = source
--     TablePlayer[src] = nil
-- end)

AddEventHandler('onResourceStart', function(resource)
    AddToLog("server", "resource", "Resource "..resource.." started", "keyforserverlog")
end)

AddEventHandler('onResourceStop', function(resource)
    AddToLog("server", "resource", "Resource "..resource.." stop", "keyforserverlog")
end)
