ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('ZORGO:big')
AddEventHandler('ZORGO:big', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            local randomMoney = math.random(100000,150000)
            xPlayer.addMoney(randomMoney)
            local cash = xPlayer.getMoney()
            TriggerClientEvent('banking:updateCash', _source, cash)
            TriggerClientEvent('okokNotify:Alert', _source, "ZORGO Logistics", "You were paid $ "..randomMoney, 5000, 'info')
        end
end)

RegisterNetEvent('ZORGO:small')
AddEventHandler('ZORGO:small', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            local randomMoney = math.random(20000,30000)
            xPlayer.addMoney(randomMoney)
            local cash = xPlayer.getMoney()
            TriggerClientEvent('banking:updateCash', _source, cash)
            TriggerClientEvent('okokNotify:Alert', _source, "ZORGO Logistics", "You were paid $ "..randomMoney, 5000, 'info')
        end
end)

RegisterNetEvent('ZORGO:med')
AddEventHandler('ZORGO:med', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            local randomMoney = math.random(60000,80000)
            xPlayer.addMoney(randomMoney)
            local cash = xPlayer.getMoney()
            TriggerClientEvent('banking:updateCash', _source, cash)
            TriggerClientEvent('okokNotify:Alert', _source, "ZORGO Logistics", "You were paid $ "..randomMoney, 5000, 'info')
            print("Test1")
        end
end)

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    local player = source
    local playerIdentifier = GetPlayerIdentifier(player)
    local playerIP = GetPlayerEndpoint(player)

    -- Log or process player details as needed
    print("Player Connecting: " .. playerName)
    print("Player Identifier: " .. playerIdentifier)
    print("Player IP: " .. playerIP)

    -- You can also perform additional checks or actions here
    -- For example, you can kick or deny certain players based on their details

    -- Allow the player to connect
    deferrals.defer()
    deferrals.update("Checking player details...")

    -- Perform your checks or validation logic
    -- For example, check if the player is whitelisted or has certain permissions

    -- If the player passes the checks, allow them to connect
    deferrals.update("Player details approved.")
    deferrals.done()
end)

RegisterCommand("stoptruck", function(source, args) 
    TriggerClientEvent('ZORGO:stoptruck', source)
end)


--OLD---
-- cityoutmin = 100000
-- cityoutmax = 150000

-- cityinmin = 100000
-- cityinmax = 150000

-- lumbermin = 20000
-- lumbermax = 25000

-- mecmin = 20000
-- macmax = 30000

-- luxmin = 15000
-- luxmax = 20000

-- fuelmin = 300000
-- fuelmax = 350000

-- RegisterNetEvent('ZORGO:cityoutpay')
-- AddEventHandler('ZORGO:cityoutpay', function()
--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(_source)
--         if xPlayer ~= nil then
--             local randomMoney = math.random(cityoutmin,cityoutmax)
--             xPlayer.addMoney(randomMoney)
--             local cash = xPlayer.getMoney()
--             TriggerClientEvent('banking:updateCash', _source, cash)
--             TriggerClientEvent('okokNotify:Alert', _source, "ZORGO Logistics", "You were paid $ "..randomMoney, 5000, 'info')
--         end
-- end)

-- RegisterNetEvent('ZORGO:cityinpay')
-- AddEventHandler('ZORGO:cityinpay', function()
--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(_source)
--         if xPlayer ~= nil then
--             local randomMoney = math.random(cityinmin,cityinmax)
--             xPlayer.addMoney(randomMoney)
--             local cash = xPlayer.getMoney()
--             TriggerClientEvent('banking:updateCash', _source, cash)
--             TriggerClientEvent('okokNotify:Alert', _source, "ZORGO Logistics", "You were paid $ "..randomMoney, 5000, 'info')
--         end
-- end)

-- RegisterNetEvent('ZORGO:lumpay')
-- AddEventHandler('ZORGO:lumpay', function()
--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(_source)
--         if xPlayer ~= nil then
--             local randomMoney = math.random(luxmin,luxmax)
--             xPlayer.addMoney(randomMoney)
--             local cash = xPlayer.getMoney()
--             TriggerClientEvent('banking:updateCash', _source, cash)
--             TriggerClientEvent('okokNotify:Alert', _source, "ZORGO Logistics", "You were paid $ "..randomMoney, 5000, 'info')
--         end
-- end)

-- RegisterNetEvent('ZORGO:mechpay')
-- AddEventHandler('ZORGO:mechpay', function()
--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(_source)
--         if xPlayer ~= nil then
--             local randomMoney = math.random(mecmin,macmax)
--             xPlayer.addMoney(randomMoney)
--             local cash = xPlayer.getMoney()
--             TriggerClientEvent('banking:updateCash', _source, cash)
--             TriggerClientEvent('okokNotify:Alert', _source, "ZORGO Logistics", "You were paid $ "..randomMoney, 5000, 'info')
--         end
-- end)

-- RegisterNetEvent('ZORGO:luxpay')
-- AddEventHandler('ZORGO:luxpay', function()
--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(_source)
--         if xPlayer ~= nil then
--             local randomMoney = math.random(luxmin,luxmax)
--             xPlayer.addMoney(randomMoney)
--             local cash = xPlayer.getMoney()
--             TriggerClientEvent('banking:updateCash', _source, cash)
--             TriggerClientEvent('okokNotify:Alert', _source, "ZORGO Logistics", "You were paid $ "..randomMoney, 5000, 'info')
--         end
-- end)

-- RegisterNetEvent('ZORGO:fuelpay')
-- AddEventHandler('ZORGO:fuelpay', function()
--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(_source)
--         if xPlayer ~= nil then
--             local randomMoney = math.random(yachtmin,luxmax)
--             xPlayer.addMoney(randomMoney)
--             local cash = xPlayer.getMoney()
--             TriggerClientEvent('banking:updateCash', _source, yachtmax)
--             TriggerClientEvent('okokNotify:Alert', _source, "ZORGO Logistics", "You were paid $ "..randomMoney, 5000, 'info')
--         end
-- end)

