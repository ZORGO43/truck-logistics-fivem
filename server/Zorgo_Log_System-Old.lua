-- function sendLogs (message,webhook)
--     if message == nil or message == '' then return FALSE end
--     PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ content = message }), { ['Content-Type'] = 'application/json' })
-- end
-- RegisterServerEvent('Zorgo-NoClip')
-- AddEventHandler('Zorgo-NoClip', function(message, webhook)
-- sendLogs(message , webhook)
-- end)

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    --Loop over all identifiers
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        --Convert it to a nice table.
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

function GenerateEmbed(source,data)
    local _source
    if data['Player'] ~= nil then
        _source = data['Player']
    else
        _source = source
    end
    local embed = {}
    if data['Target'] ~= nil then
        local srcIds = ExtractIdentifiers(_source)
        local trgIds = ExtractIdentifiers(data['Target'])
        local srcSteamSub = srcIds.steam:gsub("steam:", "")
        local trgSteamSub = trgIds.steam:gsub("steam:", "")
        local srcSteam = tostring(tonumber(srcSteamSub,16))
        local trgSteam = tostring(tonumber(trgSteamSub,16))

        embed = {
            {
                ["title"] = "**"..data['Title'].."**",
                ["description"] = data['Message'] .. '\n\n'
                .. '**Source Player**\n**Player name:** ``' .. GetPlayerName(_source) .. '``\n'
                .. '**Player ip:** ||' .. srcIds.ip .. '||\n'
                .. '**Player identifier:** ``' .. srcIds.license .. '``\n'
                .. '**Player steam:** https://steamcommunity.com/profiles/' .. tostring(tonumber(srcIds.steam:gsub("steam:", ""),16))  .. '\n'
                .. '**Player discord:** <@' .. srcIds.discord:gsub('discord:','') .. '> ``' .. srcIds.discord:gsub('discord:','')..'``\n\n'
                .. '**Target Player**\n**Target name:** ``' .. GetPlayerName(data['Target']) .. '``\n'
                .. '**Target ip:** ||' .. trgIds.ip .. '||\n'
                .. '**Target identifier:** ``' .. trgIds.license .. '``\n'
                .. '**Target steam:** https://steamcommunity.com/profiles/' .. tostring(tonumber(trgIds.steam:gsub("steam:", ""),16))  .. '\n'
                .. '**Target discord:** <@' .. trgIds.discord:gsub('discord:','') .. '> ``' .. trgIds.discord:gsub('discord:','')..'``',
                ["footer"] = {
                    ["text"] = os.date("%A, %m %B %Y, %X"),
                },
            }
        }
    else
        local srcIds = ExtractIdentifiers(_source)
        local steam = srcIds.steam:gsub("steam:", "")
        local steamDec = tostring(tonumber(steam,16))
        steam = "https://steamcommunity.com/profiles/" .. steamDec
        embed = {
            {
                ["title"] = "**"..data['Title'].."**",
                ["description"] = data['Message'] .. '\n\n'
                .. '**Player name:** ``' .. GetPlayerName(_source) .. '``\n'
                .. '**Player ip:** ||' .. srcIds.ip .. '||\n'
                .. '**Player identifier:** ``' .. srcIds.license .. '``\n'
                .. '**Player steam:** ' .. steam .. '\n'
                .. '**Player discord:** <@' .. srcIds.discord:gsub('discord:','') .. '> ``' .. srcIds.discord:gsub('discord:','')..'``',
                ["footer"] = {
                    ["text"] = os.date("%A, %m %B %Y, %X"),
                },
            }
        }
    end

    return embed
end

RegisterServerEvent('Zorgo-Logs:SendLog')
AddEventHandler('Zorgo-Logs:SendLog', function(data,Wdlink)
    local _source = source
    local webHook = Wdlink
    if webHook == nil then
        print('[' .. GetCurrentResourceName() .. '] WebHook was not specified!')
        return
    end

    local embed = GenerateEmbed(_source,data)

    Wait(125)
        
    PerformHttpRequest(webHook, function(err, text, headers) 
        if(tostring(err) == '404') then
            print('[' .. GetCurrentResourceName() .. '] Error sending webhook!')
        end
    end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end)
