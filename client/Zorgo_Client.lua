-- ------------------------------------- DO NOT TOUCH THESE | ZORGO ----------------------------------------
onJob = false
pAnim = nil
pCoords = nil
jobMenu = nil
sC3 = nil
j1 = false;
j5 = false;
j6 = false;
j8 = false;
j10 = false;
-- ------------------------------------- ZORGO ----------------------------------------

ESX = exports["es_extended"]:getSharedObject()


Citizen.CreateThread(function()
    while true do
        player = PlayerPedId()
        coords = GetEntityCoords(player)
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local s = true
        local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, 110.5714, -2577.218, 5.784204, false)
        if jobMenu ~= nil then
            while jobMenu ~= nil and dist > 1.5 do jobMenu = nil Citizen.Wait(1) end
            if jobMenu == nil then ESX.UI.Menu.CloseAll() end
        else
            if dist < 18 then
                s = false
                if dist < 13 then
                    DynaMarker(27, 110.5714, -2577.218, 5.7, 0.0, 0.0, 600, 100, true)
                    if dist < 1.5 then
                        DrawText3Ds(110.5714, -2577.218, 6.684204, "~r~[~g~E~r~]" .. " ~w~Open Logistics Menu")
                        if IsControlJustPressed(0, 38) then
                            OpenJobMenu1()
                            
                        end
                    end
                end
            end
        end
        if s then Citizen.Wait(1000) end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local s = true
        local dist2 = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, 114.1451, 6372.62, 31.36926, false)
        if jobMenu ~= nil then
            while jobMenu ~= nil and dist > 1.5 do jobMenu = nil Citizen.Wait(1) end
            if jobMenu == nil then TriggerEvent("zorgo:uioff",true) end
        else
            if dist2 < 18 then
                s = false
                if dist2 < 13 then
                    DynaMarker(27, 114.1451, 6372.62, 30.4, 0.0, 0.0, 600, 100, true)
                    if dist2 < 1.5 then
                        DrawText3Ds(114.1451, 6372.62, 31.36926, "~r~[~g~E~r~]" .. " ~w~Open ZORGO Logistics Menu")
                        if IsControlJustPressed(0, 38) then
                            OpenJobMenu()
                        end
                    end
                end
            end
        end
        if s then Citizen.Wait(1000) end
    end
end)

--UI--
RegisterNetEvent("faizu:onPaleto")
AddEventHandler("faizu:onPaleto", function(value)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "ui",
        display = true
    })

end)
RegisterNetEvent("faizu:offPaleto")
AddEventHandler("faizu:offPaleto", function(value)
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "ui",
        display = false
    })
end)
RegisterNetEvent("faizu:onCity")
AddEventHandler("faizu:onCity", function(value)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "uiCity",
        display = true
    })

end)
RegisterNetEvent("faizu:offCity")
AddEventHandler("faizu:offCity", function(value)
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "uiCity",
        display = false
    })
end)

RegisterNetEvent("zorgo:uioff")
AddEventHandler("zorgo:uioff",function(value)
    SetNuiFocus(false, false)
    TriggerEvent("faizu:offPaleto", true)
    TriggerEvent("faizu:offCity", true)
end)
--UI--

RegisterNetEvent("zorgo:notify")
AddEventHandler("zorgo:notify",function(string)
    exports['okokNotify']:Alert("ZORGO Logistics",string, 5000, 'info')
end)


----ZORGO Job Menu Function START----
function OpenJobMenu()
    TriggerEvent("faizu:onPaleto", true)
    RegisterNUICallback("action", function(data)
        if data.action == 'goods' then
            if onJob == false then
                onJob = true
                startJob5()
                SetNuiFocus(false, false)
                TriggerEvent("faizu:offPaleto", true)
            else
                exports['okokNotify']:Alert("ZORGO Logistics", "You Already on a Job", 5000, 'info')
                return
            end
        elseif data.action == 'mechanic' then
            if onJob == false then
                onJob = true
                startJob8()
                SetNuiFocus(false, false)
                TriggerEvent("faizu:offPaleto", true)
            else
                 exports['okokNotify']:Alert("ZORGO Logistics", "You Already on a Job", 5000, 'info')
                
                return
            end
        elseif data.action == 'stop' then
            if onJob == true then
                onJob = false
                ClearAllBlipRoutes()
                RemoveBlip(mB)
                RemoveBlip(mB3)
                exports['okokNotify']:Alert("ZORGO Logistics", "Your Job Has Been Removed", 5000, 'info')
                SetNuiFocus(false, false)
                TriggerEvent("faizu:offPaleto", true)
            else
                
                exports['okokNotify']:Alert("ZORGO Logistics", "You Must Use /stoptruck", 5000, 'info')
                SetNuiFocus(false, false)
                TriggerEvent("faizu:offPaleto", true)
            end
        elseif data.action == 'lumber' then

            if onJob == false then
                onJob = true
                startJob10()
                SetNuiFocus(false, false)
                TriggerEvent("faizu:offPaleto", true)
            else
                SetNuiFocus(false, false)
                exports['okokNotify']:Alert("ZORGO Logistics", "You Already on a Job", 5000, 'info')
                return
            end
        elseif data.action == 'close' then
            SetNuiFocus(false, false)
            TriggerEvent("faizu:offPaleto", true)


        else
            SetNuiFocus(false, false)
            TriggerEvent("faizu:offPaleto", true)

        end

    end)
end

function OpenJobMenu1()

    TriggerEvent("faizu:onCity", true)
    RegisterNUICallback("action", function(data)
        if data.action == 'fuel' then
            if onJob == false then
                onJob = true
                startJob1()
                SetNuiFocus(false, false)
                TriggerEvent("faizu:offCity", true)
            else
                SetNuiFocus(false, false)
                TriggerEvent("faizu:offCity", true)
                exports['okokNotify']:Alert("ZORGO Logistics", "You Already on a Job", 5000, 'info')
            end
        elseif data.action == 'paleto' then

            if onJob == false then
                onJob = true
                startJob3()
                SetNuiFocus(false, false)
                TriggerEvent("faizu:offCity", true)
            else
                SetNuiFocus(false, false)
                TriggerEvent("faizu:offCity", true)
                exports['okokNotify']:Alert("ZORGO Logistics", "You Already on a Job", 5000, 'info')
                return
            end
        elseif data.action == 'stop' then
            if onJob == true then
                onJob = false
                ClearAllBlipRoutes()
                RemoveBlip(mB)
                RemoveBlip(mB3)
                exports['okokNotify']:Alert("ZORGO Logistics", "Your Job Has Been Removed", 5000, 'info')
                SetNuiFocus(false, false)
                TriggerEvent("faizu:offCity", true)
            else
                SetNuiFocus(false, false)
                TriggerEvent("faizu:offCity", true)
                exports['okokNotify']:Alert("ZORGO Logistics", "You Must Use /stoptruck", 5000, 'info')
            end
        elseif data.action == 'auto' then
            menu.close()
            if onJob == false then
                onJob = true
                startJob6()
                SetNuiFocus(false, false)
                TriggerEvent("faizu:offCity", true)
            else
                SetNuiFocus(false, false)
                TriggerEvent("faizu:offCity", true)
                exports['okokNotify']:Alert("ZORGO Logistics", "You Already on a Job", 5000, 'info')
                return
            end
        elseif data.action == 'harbour' then
            if onJob == false then
                onJob = true
                startJobre()
                SetNuiFocus(false, false)
                TriggerEvent("faizu:offCity", true)
            else
                SetNuiFocus(false, false)
                TriggerEvent("faizu:offCity", true)
                exports['okokNotify']:Alert("ZORGO Logistics", "You Already on a Job", 5000, 'info')
                return
            end
        elseif data.action == 'exit' then
            SetNuiFocus(false, false)
            TriggerEvent("faizu:offCity", true)
        elseif data.action == 'close' then
            SetNuiFocus(false, false)
            TriggerEvent("faizu:offCity", true)
        else
            SetNuiFocus(false, false)
            TriggerEvent("faizu:offCity", true)
        end
    
    end)
end

----ZORGO PED SPAWN CALLOUT START---
RegisterNetEvent('ZORGO:ped')
AddEventHandler('ZORGO:ped', function(pCoords, isP, pAnim, cBool, pedh)
    if cBool then
        hash = 's_m_y_armymech_01'
    else
        hash = 's_m_y_construct_02'
    end
    nCoords = pCoords
    Citizen.CreateThread(function()
        RequestModel(hash)
        while not HasModelLoaded(hash) do RequestModel(hash)
            Citizen.Wait(0)
        end
        if isP then
            local ped = ESX.Game.GetClosestPed(nCoords)
            if isP and pAnim then
                Citizen.Wait(1)
                TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
                Citizen.Wait(10000)
                SetEntityAsNoLongerNeeded(ped)
                DeletePed(ped)
                return
            end

        else
            bla = CreatePed(1, hash, nCoords, pedh, true, false)
            FreezeEntityPosition(bla, true)
            SetEntityInvincible(bla, true)
            SetBlockingOfNonTemporaryEvents(bla, true)
            TaskStartScenarioInPlace(bla, "WORLD_HUMAN_CLIPBOARD", true)
            Citizen.Wait(30000)
            DeletePed(bla)
            return
        end
        return
    end)
end)
----ZORGO PED SPAWN CALLOUT END---
---ZORGO Trailer Function START ---
function ZORGO(JobCoords, DisCoord, pedh)
    local jC2 = JobCoords
    local sC2 = DisCoords
    Zg = PlayerPedId()
    TriggerEvent('ZORGO:ped', jC2, false, false, false, pedh)
    j5 = true
    while j5 do
        Citizen.Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, jC2.x, jC2.y, jC2.z, false)
        if uDist < 20 then
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to sign the Contract", true, true, 5000)
                if IsControlJustPressed(0, 38) then
                    FreezeEntityPosition(Zg, true)
                    TaskStartScenarioInPlace(Zg, "WORLD_HUMAN_CLIPBOARD", 0, true)
                    exports['progressBars']:startUI(10000, 'Signing The Contract')
                    Wait(10000)
                    ClearPedTasksImmediately(Zg)
                    FreezeEntityPosition(Zg, false)
                    RemoveBlip(rb)
                    exports['okokNotify']:Alert("ZORGO Logistics", "Destination Has Been Marked", 5000, 'info')
                    return
                end
            end
        end
    end
end

---ZORGO Trailer Function END ---
----ZORGO Return Outside City Function END---
-------------------------- ======================================= JOBS ===============================================---------------------------------
-- ======================================= Fuel Delivery ===============================================

function startJob1()

    local p = PlayerPedId()
    local vC1 = vector3(-156.41, -2561.54, 6.02) -- truck
    local vC2 = vector3(-165.6, -2560.4, 5.82) -- trailer
    local h = 86.65 --Heading
    local n2 = false
    local sC = vector3(2580.767, 446.3712, 108.4497)
    exports['okokNotify']:Alert("ZORGO Logistics", "Deliver The Yacht to the Fuel Station", 5000, 'info')
    ESX.Game.SpawnVehicle("phantom", vC1, h, function(veh)
        Citizen.Wait(1000)
        SetVehicleLivery(veh, 4)
        SetPedIntoVehicle(p, veh, -1)
        mB = AddBlipForCoord(sC)
        SetBlipRoute(mB, true)
        SetBlipRouteColour(mB, 57)
        SetBlipColour(mB, 57)
        ESX.Game.SpawnVehicle("tanker", vC2, h, function(veh2)
            AttachVehicleToTrailer(veh, veh2, 1.1)
            Citizen.CreateThread(function()
                local wait = 100
                while not n2 do
                    Citizen.Wait(wait)
                    local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC, false)
                    local tr = GetEntityCoords(veh2)
                    local trDist = GetDistanceBetweenCoords(tr, sC, false)
                    if tDist < 60 and trDist > 6 then
                        wait = 5
                        r = 250;
                        g = 0;
                        b = 0;
                        a = 200;
                        DynaMarker(1, sC.x, sC.y, sC.z - 1.0, 250, 0, 0, 200, false)
                    end
                    if trDist < 6 then
                        wait = 5
                        DynaMarker(1, sC.x, sC.y, sC.z - 1.0, 0, 600, 0, 100, false)
                        if trDist < 2 then
                            SetBlipRoute(mB, false)
                            RemoveBlip(mB)
                            Job1()
                            n2 = true
                            yachtre()
                            ESX.Game.DeleteVehicle(veh2)
                            return
                        end
                    end
                end
            end)
        end)
    end)
end

function Job1()
    local jC = vector3(2590.736, 442.5128, 107.4557)
    Zg = PlayerPedId()
    TriggerEvent('ZORGO:ped', jC, false, false, false, 69.79126)
    j5 = true
    while j5 do
        Citizen.Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, jC.x, jC.y, jC.z, false)
        if uDist < 20 then
            ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the Contractor", true, true, 5000)
                if IsControlJustPressed(0, 38) then
                    FreezeEntityPosition(Zg, true)
                    TaskStartScenarioInPlace(Zg, "WORLD_HUMAN_CLIPBOARD", 0, true)
                    exports['progressBars']:startUI(10000, 'Signing off the Work')
                    Wait(10000)
                    ClearPedTasksImmediately(Zg)
                    FreezeEntityPosition(Zg, false)
                    j5 = false
                    return
                end
            end
        end
    end
end

function yachtre()
    local sC3 = vector3(157.9912, -2640.752, 5.993408)
    local n1 = false
    local mB3 = AddBlipForCoord(sC3)
    SetBlipRoute(mB3, true)
    SetBlipRouteColour(mB3, 57)
    SetBlipColour(mB3, 57)
    Citizen.CreateThread(function()
        local wait = 100
        exports['okokNotify']:Alert("ZORGO Logistics", "Return the vehicle to the Nearest Logistics Hub", 5000, 'info')
        while not n1 do
            Citizen.Wait(wait)
            local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC3, false)
            if tDist < 40 and tDist > 10 then
                wait = 5
                local p = PlayerPedId()
                local v = GetVehiclePedIsIn(p)
                DynaMarker(1, sC3.x, sC3.y, sC3.z - 1.0, 250, 0, 0, 200, false)
            end
            if tDist <= 10 then
                onJob = false
                wait = 5
                DynaMarker(1, sC3.x, sC3.y, sC3.z - 1.0, 0, 600, 0, 200, false)
                local p = PlayerPedId()
                local v = GetVehiclePedIsIn(p)
                Citizen.Wait(1000)
                SetBlipRoute(mB3, false)
                RemoveBlip(mB3)
                Citizen.Wait(3000)
                ESX.Game.DeleteVehicle(v)
                TriggerServerEvent('ZORGO:med')

                Citizen.Wait(1000)
                n1 = true
                return
            end
        end
    end)
end

-- ======================================= Harbour Delivery ===============================================

function startJobre()
    local p = PlayerPedId()
    local vC1 = vector3(-156.41, -2561.54, 6.02) -- truck
    local vC2 = vector3(-165.6, -2560.4, 5.82) -- trailer
    local h = 86.65 --Heading
    local n2 = false
    local sC = vector3(-403.159, -2264.242, 7.698339)
    exports['okokNotify']:Alert("ZORGO Logistics", "Deliver The Yacht to the Harbour Station", 5000, 'info')
    ESX.Game.SpawnVehicle("phantom", vC1, h, function(veh)
        Citizen.Wait(1000)
        SetVehicleLivery(veh, 4)
        SetPedIntoVehicle(p, veh, -1)
        mB = AddBlipForCoord(sC)
        SetBlipRoute(mB, true)
        SetBlipRouteColour(mB, 57)
        SetBlipColour(mB, 57)
        ESX.Game.SpawnVehicle("trailers3", vC2, h, function(veh2)
            AttachVehicleToTrailer(veh, veh2, 1.1)
            Citizen.CreateThread(function()
                local wait = 100
                while not n2 do
                    Citizen.Wait(wait)
                    local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC, false)
                    local tr = GetEntityCoords(veh2)
                    local trDist = GetDistanceBetweenCoords(tr, sC, false)
                    if tDist < 60 and trDist > 6 then
                        wait = 5
                        r = 250;
                        g = 0;
                        b = 0;
                        a = 200;
                        DynaMarker(1, sC.x, sC.y, sC.z - 1.0, 250, 0, 0, 200, false)
                    end
                    if trDist < 6 then
                        wait = 5
                        DynaMarker(1, sC.x, sC.y, sC.z - 1.0, 0, 600, 0, 100, false)
                        if trDist < 2 then
                            SetBlipRoute(mB, false)
                            RemoveBlip(mB)
                            Jobre()
                            n2 = true
                            harre()
                            ESX.Game.DeleteVehicle(veh2)
                            return
                        end
                    end
                end
            end)
        end)
    end)
end

function Jobre()
    local jC = vector3(-410.1637, -2286.191, 6.612696)
    Zg = PlayerPedId()
    TriggerEvent('ZORGO:ped', jC, false, false, false, 286.0704)
    j5 = true
    while j5 do
        Citizen.Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, jC.x, jC.y, jC.z, false)
        if uDist < 20 then
            ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the Contractor", true, true, 5000)
                if IsControlJustPressed(0, 38) then
                    FreezeEntityPosition(Zg, true)
                    TaskStartScenarioInPlace(Zg, "WORLD_HUMAN_CLIPBOARD", 0, true)
                    exports['progressBars']:startUI(10000, 'Signing off the Work')
                    Wait(10000)
                    ClearPedTasksImmediately(Zg)
                    FreezeEntityPosition(Zg, false)
                    j5 = false
                    return
                end
            end
        end
    end
end

function harre()
    local sC3 = vector3(157.9912, -2640.752, 5.993408)
    local n1 = false
    local mB3 = AddBlipForCoord(sC3)
    SetBlipRoute(mB3, true)
    SetBlipRouteColour(mB3, 57)
    SetBlipColour(mB3, 57)
    Citizen.CreateThread(function()
        local wait = 100
        exports['okokNotify']:Alert("ZORGO Logistics", "Return the vehicle to the Nearest Logistics Hub", 5000, 'info')
        while not n1 do
            Citizen.Wait(wait)
            local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC3, false)
            if tDist < 40 and tDist > 10 then
                wait = 5
                local p = PlayerPedId()
                local v = GetVehiclePedIsIn(p)
                DynaMarker(1, sC3.x, sC3.y, sC3.z - 1.0, 250, 0, 0, 200, false)
            end
            if tDist <= 10 then
                onJob = false
                wait = 5
                DynaMarker(1, sC3.x, sC3.y, sC3.z - 1.0, 0, 600, 0, 200, false)
                local p = PlayerPedId()
                local v = GetVehiclePedIsIn(p)
                Citizen.Wait(1000)
                SetBlipRoute(mB3, false)
                RemoveBlip(mB3)
                Citizen.Wait(3000)
                ESX.Game.DeleteVehicle(v)
                TriggerServerEvent('ZORGO:small')
                Citizen.Wait(1000)
                n1 = true
                return
            end
        end
    end)
end

-- ======================================= Paleto Sea Port ===============================================
function startJob3()
    local p = PlayerPedId()
    local vC1 = vector3(-156.41, -2561.54, 6.02) -- truck
    local vC2 = vector3(-165.6, -2560.4, 5.82) -- trailer
    local h = 86.65
    local sC2 = vector3(1598.38, 6557.343, 13.76209)
    local n2 = false
    ESX.Game.SpawnVehicle("phantom", vC1, h, function(veh)
        Citizen.Wait(1000)
        SetVehicleLivery(veh, 4)
        SetPedIntoVehicle(p, veh, -1)
        mB = AddBlipForCoord(sC2)
        SetBlipRoute(mB, true)
        SetBlipRouteColour(mB, 57)
        SetBlipColour(mB, 57)
        ESX.Game.SpawnVehicle("trailers4", vC2, h, function(veh2)
            AttachVehicleToTrailer(veh, veh2, 1.1)
            Citizen.CreateThread(function()
                local wait = 100
                while not n2 do
                    Citizen.Wait(wait)
                    local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC2, false)
                    local tr = GetEntityCoords(veh2)
                    local trDist = GetDistanceBetweenCoords(tr, sC2, false)
                    if tDist < 60 and trDist > 5 then
                        wait = 5
                        r = 250;
                        g = 0;
                        b = 0;
                        a = 200;
                        DynaMarker(1, sC2.x, sC2.y, sC2.z - 1.0, 250, 0, 0, 200, false)
                    end
                    if trDist < 5 then
                        wait = 5
                        DynaMarker(1, sC2.x, sC2.y, sC2.z - 1.0, 0, 600, 0, 100, false)
                        if trDist < 2 then
                            SetBlipRoute(mB, false)
                            RemoveBlip(mB)
                            Job3()
                            ESX.Game.DeleteVehicle(veh2)
                            cityoutre()
                            return
                        end
                    end
                end
            end)
        end)
    end)
end

function Job3()
    local jC2 = vector3(1600.461, 6579.731, 13.46135)
    Zg = PlayerPedId()
    TriggerEvent('ZORGO:ped', jC2, false, false, false, 157.3002)
    j5 = true
    while j5 do
        Citizen.Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, jC2.x, jC2.y, jC2.z, false)
        if uDist < 20 then
            ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the Contractor", true, true, 5000)
                if IsControlJustPressed(0, 38) then
                    FreezeEntityPosition(Zg, true)
                    TaskStartScenarioInPlace(Zg, "WORLD_HUMAN_CLIPBOARD", 0, true)
                    exports['progressBars']:startUI(10000, 'Signing off the Work')
                    Wait(10000)
                    ClearPedTasksImmediately(Zg)
                    FreezeEntityPosition(Zg, false)
                    j5 = false
                    return
                end
            end
        end
    end
end

function cityoutre()
    local sC3 = vector3(162.7121, 6447.468, 31.30188)
    local n1 = false
    local mB3 = AddBlipForCoord(sC3)
    SetBlipRoute(mB3, true)
    SetBlipRouteColour(mB3, 57)
    SetBlipColour(mB3, 57)
    Citizen.CreateThread(function()
        local wait = 100
        exports['okokNotify']:Alert("ZORGO Logistics", "Return the vehicle to the Nearest Logistics Hub", 5000, 'info')
        while not n1 do
            Citizen.Wait(wait)
            local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC3, false)
            if tDist < 40 and tDist > 10 then
                wait = 5
                local p = PlayerPedId()
                local v = GetVehiclePedIsIn(p)
                DynaMarker(1, sC3.x, sC3.y, sC3.z - 1.0, 250, 0, 0, 200, false)
            end
            if tDist <= 10 then
                onJob = false
                wait = 5
                DynaMarker(1, sC3.x, sC3.y, sC3.z - 1.0, 0, 600, 0, 200, false)
                local p = PlayerPedId()
                local v = GetVehiclePedIsIn(p)
                Citizen.Wait(1000)
                SetBlipRoute(mB3, false)
                RemoveBlip(mB3)
                Citizen.Wait(3000)
                ESX.Game.DeleteVehicle(v)
                TriggerServerEvent('ZORGO:big')
                Citizen.Wait(1000)
                n1 = true
                return
            end
        end
    end)
end

-- ===================================================== Cross-County Delivery Outside City =============================================
function startJob5()
    local p = PlayerPedId()
    local vC1 = vector3(80.96703, 6319.279, 31.31873) -- truck
    local vC2 = vector3(66.1055, 6403.925, 30.79639) -- trailer
    local uTr = GetDistanceBetweenCoords(66.1055, 6403.925, 30.79639, vC2.x - 5, vC2.y - 9, vC2.z, false)
    local h = 128.13
    local sC2 = vector3(-159.6132, -2495.393, 5.993408)
    local n2 = false
    exports['okokNotify']:Alert("ZORGO Logistics", "Deliver the Good to City Warehouse", 5000, 'info')
    ESX.Game.SpawnVehicle("phantom", vC1, 25.51181, function(veh)
        Citizen.Wait(1000)
        SetVehicleLivery(veh, 4)
        SetPedIntoVehicle(p, veh, -1)
        rb = AddBlipForCoord(vC2)
        SetBlipRoute(rb, true)
        SetBlipRouteColour(rb, 57)
        SetBlipColour(rb, 57)
        exports['okokNotify']:Alert("ZORGO Logistics", "Speak with the Contractor", 5000, 'info')
        ESX.Game.SpawnVehicle("trailers4", vC2, 215.4331, function(veh2)
            ZORGO(vector3(73.45055, 6410.4, 30.43665), vector3(-159.6132, -2495.393, 5.993408), 133.2283)
            mB = AddBlipForCoord(sC2)
            SetBlipRoute(mB, true)
            SetBlipRouteColour(mB, 57)
            SetBlipColour(mB, 57)
            Citizen.CreateThread(function()
                local wait = 100
                while not n2 do
                    Citizen.Wait(wait)
                    local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC2, false)
                    local tr = GetEntityCoords(veh2)
                    local trDist = GetDistanceBetweenCoords(tr, sC2, false)
                    if tDist < 60 and trDist > 5 then
                        wait = 5
                        DynaMarker(1, sC2.x, sC2.y, sC2.z - 1.0, 250, 0, 0, 200, false)
                    end
                    if trDist < 5 then
                        wait = 5
                        DynaMarker(1, sC2.x, sC2.y, sC2.z - 1.0, 0, 600, 0, 100, false)
                        if trDist < 2 then
                            SetBlipRoute(mB, false)
                            RemoveBlip(mB)
                            Job5()
                            ESX.Game.DeleteVehicle(veh2)
                            cityinre()
                            return
                        end
                    end
                end
            end)
        end)
    end)
end

function Job5()
    local jC2 = vector3(-148.022, -2515.873, 4.993408)
    Zg = PlayerPedId()
    TriggerEvent('ZORGO:ped', jC2, false, false, false)
    j5 = true
    while j5 do
        Citizen.Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, jC2.x, jC2.y, jC2.z, false)
        if uDist < 20 then
            ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the Contractor", true, true, 5000)
                if IsControlJustPressed(0, 38) then
                    FreezeEntityPosition(Zg, true)
                    TaskStartScenarioInPlace(Zg, "WORLD_HUMAN_CLIPBOARD", 0, true)
                    exports['progressBars']:startUI(10000, 'Signing off the Work')
                    Wait(10000)
                    ClearPedTasksImmediately(Zg)
                    FreezeEntityPosition(Zg, false)
                    j5 = false
                    return
                end
            end
        end
    end
end

function cityinre()
    local sC3 = vector3(157.9912, -2640.752, 5.993408)
    local n1 = false
    local mB3 = AddBlipForCoord(sC3)
    SetBlipRoute(mB3, true)
    SetBlipRouteColour(mB3, 57)
    SetBlipColour(mB3, 57)
    Citizen.CreateThread(function()
        local wait = 100
        exports['okokNotify']:Alert("ZORGO Logistics", "Return the vehicle to the Nearest Logistics Hub", 5000, 'info')
        while not n1 do
            Citizen.Wait(wait)
            local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC3, false)
            if tDist < 40 and tDist > 10 then
                wait = 5
                local p = PlayerPedId()
                local v = GetVehiclePedIsIn(p)
                DynaMarker(1, sC3.x, sC3.y, sC3.z - 1.0, 250, 0, 0, 200, false)
            end
            if tDist <= 10 then
                onJob = false
                wait = 5
                DynaMarker(1, sC3.x, sC3.y, sC3.z - 1.0, 0, 600, 0, 200, false)
                local p = PlayerPedId()
                local v = GetVehiclePedIsIn(p)
                Citizen.Wait(1000)
                SetBlipRoute(mB3, false)
                RemoveBlip(mB3)
                Citizen.Wait(3000)
                ESX.Game.DeleteVehicle(v)
                TriggerServerEvent('ZORGO:big')
                Citizen.Wait(1000)
                n1 = true
                return
            end
        end
    end)
end

-- ===================================================== luxury auto delivery =================================
function startJob6()
    local p = PlayerPedId()
    local vC1 = vector3(-156.41, -2561.54, 6.02) -- truck
    local vC2 = vector3(-165.6, -2560.4, 5.82) -- trailer
    local h = 86.65
    local sC = vector3(-336.752, -1379.64, 32.81903)
    local n2 = false
    exports['okokNotify']:Alert("ZORGO Logistics", "Deliver The Cars to Factory", 5000, 'info')
    ESX.Game.SpawnVehicle("phantom", vC1, h, function(veh)
        Citizen.Wait(1000)
        SetVehicleLivery(veh, 4)
        SetPedIntoVehicle(p, veh, -1)
        mB = AddBlipForCoord(sC)
        SetBlipRoute(mB, true)
        SetBlipRouteColour(mB, 57)
        SetBlipColour(mB, 57)
        ESX.Game.SpawnVehicle("tr4", vC2, h, function(veh2)
            AttachVehicleToTrailer(veh, veh2, 1.1)
            Citizen.CreateThread(function()
                local wait = 100
                while not n2 do
                    Citizen.Wait(wait)
                    local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC, false)
                    local tr = GetEntityCoords(veh2)
                    local trDist = GetDistanceBetweenCoords(tr, sC, false)
                    if tDist < 60 and trDist > 6 then
                        wait = 5
                        r = 250;
                        g = 0;
                        b = 0;
                        a = 200;
                        DynaMarker(1, sC.x, sC.y, sC.z - 1.0, 250, 0, 0, 200, false)
                    end
                    if trDist < 6 then
                        wait = 5
                        DynaMarker(1, sC.x, sC.y, sC.z - 1.0, 0, 600, 0, 100, false)
                        if trDist < 2 then
                            SetBlipRoute(mB, false)
                            RemoveBlip(mB)
                            Job6()
                            n2 = true
                            luxre()
                            ESX.Game.DeleteVehicle(veh2)
                            return
                        end
                    end
                end
            end)
        end)
    end)
end

function Job6()
    local jC = vector3(-343.3872, -1368.895, 30.35583)
    Zg = PlayerPedId()
    TriggerEvent('ZORGO:ped', jC, false, false, false, 192.4827)
    j8 = true
    while j8 do
        Citizen.Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, jC.x, jC.y, jC.z, false)
        if uDist < 20 then
            ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the Contractor", true, true, 5000)
                if IsControlJustPressed(0, 38) then
                    FreezeEntityPosition(Zg, true)
                    TaskStartScenarioInPlace(Zg, "WORLD_HUMAN_CLIPBOARD", 0, true)
                    exports['progressBars']:startUI(10000, 'Signing off the Work')
                    Wait(10000)
                    ClearPedTasksImmediately(Zg)
                    FreezeEntityPosition(Zg, false)
                    j8 = false
                    return
                end
            end
        end
    end
end

function luxre()
    local sC3 = vector3(157.9912, -2640.752, 5.993408)
    local n1 = false
    local mB3 = AddBlipForCoord(sC3)
    SetBlipRoute(mB3, true)
    SetBlipRouteColour(mB3, 57)
    SetBlipColour(mB3, 57)
    Citizen.CreateThread(function()
        local wait = 100
        exports['okokNotify']:Alert("ZORGO Logistics", "Return the vehicle to the Nearest Logistics Hub", 5000, 'info')
        while not n1 do
            Citizen.Wait(wait)
            local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC3, false)
            if tDist < 40 and tDist > 10 then
                wait = 5
                local p = PlayerPedId()
                local v = GetVehiclePedIsIn(p)
                DynaMarker(1, sC3.x, sC3.y, sC3.z - 1.0, 250, 0, 0, 200, false)
            end
            if tDist <= 10 then
                onJob = false
                wait = 5
                DynaMarker(1, sC3.x, sC3.y, sC3.z - 1.0, 0, 600, 0, 200, false)
                local p = PlayerPedId()
                local v = GetVehiclePedIsIn(p)
                Citizen.Wait(1000)
                SetBlipRoute(mB3, false)
                RemoveBlip(mB3)
                Citizen.Wait(3000)
                ESX.Game.DeleteVehicle(v)
                TriggerServerEvent('ZORGO:small')
                Citizen.Wait(1000)
                n1 = true
                return
            end
        end
    end)
end

-- =================================================== MECHANIC ===============================================
function startJob8()
    local p = PlayerPedId()
    local vC1 = vector3(137.222, 6360.646, 31.33557)
    h1 = 28.34646
    local vC2 = vector3(137.222, 6360.646, 31.33557) -- trailer
    local h = 219.82
    local sC = vector3(645.7978, 2790.198, 41.93408)
    local n2 = false
    exports['okokNotify']:Alert("ZORGO Logistics", "Supply the Mechanic Part to Outlet", 5000, 'info')
    ESX.Game.SpawnVehicle("phantom", vC1, h1, function(veh)
        Citizen.Wait(1000)
        SetVehicleLivery(veh, 4)
        SetPedIntoVehicle(p, veh, -1)
        mB = AddBlipForCoord(sC)
        SetBlipRoute(mB, true)
        SetBlipRouteColour(mB, 57)
        SetBlipColour(mB, 57)
        ESX.Game.SpawnVehicle("trailers3", vC2, h, function(veh2)
            AttachVehicleToTrailer(veh, veh2, 1.1)
            Citizen.CreateThread(function()
                local wait = 100
                while not n2 do
                    Citizen.Wait(wait)
                    local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC, false)
                    if tDist < 50 then
                        local tr = GetEntityCoords(veh2)
                        local trDist = GetDistanceBetweenCoords(tr, sC, false)
                        wait = 5
                        r = 250;
                        g = 0;
                        b = 0;
                        a = 200;
                        DrawMarker(1, sC.x, sC.y, sC.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 5.0, r, g, b, a, false
                            , true, 2, false, false, false, false)
                        if trDist < 15 then
                            r = 0;
                            g = 120;
                            b = 0;
                            a = 0;
                            if trDist < 5 then
                                Citizen.Wait(1000)
                                SetBlipRoute(mB, false)
                                RemoveBlip(mB)
                                Job8()
                                n2 = true
                                mechre()
                            end
                        end
                    end
                end
            end)
        end)
    end)
end

function Job8()
    local jC = vector3(640.0615, 2815.583, 40.98462)
    Zg = PlayerPedId()
    TriggerEvent('ZORGO:ped', jC, false, false, false, 198.4252)
    j8 = true
    while j8 do
        Citizen.Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, jC.x, jC.y, jC.z, false)
        if uDist < 20 then
            ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the Contractor", true, true, 5000)
                if IsControlJustPressed(0, 38) then
                    FreezeEntityPosition(Zg, true)
                    TaskStartScenarioInPlace(Zg, "WORLD_HUMAN_CLIPBOARD", 0, true)
                    exports['progressBars']:startUI(10000, 'Signing off the Work')
                    Wait(10000)
                    ClearPedTasksImmediately(Zg)
                    FreezeEntityPosition(Zg, false)
                    j5 = false
                    return
                end
            end
        end
    end
end

function mechre()
    local sC3 = vector3(162.7121, 6447.468, 31.30188)
    local n1 = false
    local mB3 = AddBlipForCoord(sC3)
    SetBlipRoute(mB3, true)
    SetBlipRouteColour(mB3, 57)
    SetBlipColour(mB3, 57)
    Citizen.CreateThread(function()
        local wait = 100
        exports['okokNotify']:Alert("ZORGO Logistics", "Return the vehicle to the Nearest Logistics Hub", 5000, 'info')
        while not n1 do
            Citizen.Wait(wait)
            local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC3, false)
            if tDist < 40 and tDist > 10 then
                wait = 5
                local p = PlayerPedId()
                local v = GetVehiclePedIsIn(p)
                DynaMarker(1, sC3.x, sC3.y, sC3.z - 1.0, 250, 0, 0, 200, false)
            end
            if tDist <= 10 then
                onJob = false
                wait = 5
                DynaMarker(1, sC3.x, sC3.y, sC3.z - 1.0, 0, 600, 0, 200, false)
                local p = PlayerPedId()
                local v = GetVehiclePedIsIn(p)
                Citizen.Wait(1000)
                SetBlipRoute(mB3, false)
                RemoveBlip(mB3)
                Citizen.Wait(3000)
                ESX.Game.DeleteVehicle(v)
                TriggerServerEvent("ZORGO:med")
                Citizen.Wait(1000)
                n1 = true
                return
            end
        end
    end)
end

-- ========================================= Lum ======================================
function startJob10()
    local p = PlayerPedId()
    local vC1 = vector3(-18.22417, 6276.079, 31.26819)
    local vC2 = vector3(-18.22417, 6176.079, 31.26819)
    local h = 128.13
    local h1 = 31.1811
    local sC2 = vector3(1351.068, 4371.771, 44.36047)
    local n2 = false
    ESX.Game.SpawnVehicle("phantom", vC1, h1, function(veh)
        exports['okokNotify']:Alert("ZORGO Logistics", "Go to the Sandy Port Hub", 5000, 'info')
        Citizen.Wait(1000)
        SetVehicleLivery(veh, 4)
        SetPedIntoVehicle(p, veh, -1)
        mB = AddBlipForCoord(sC2)
        SetBlipRoute(mB, true)
        SetBlipRouteColour(mB, 57)
        SetBlipColour(mB, 57)
        ESX.Game.SpawnVehicle("trailers3", vC2, h, function(veh2)
            AttachVehicleToTrailer(veh, veh2, 1.1)
            Citizen.CreateThread(function()
                local wait = 100
                while not n2 do
                    Citizen.Wait(wait)
                    local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC2, false)
                    local tr = GetEntityCoords(veh2)
                    local trDist = GetDistanceBetweenCoords(tr, sC2, false)
                    if tDist < 60 and trDist > 5 then
                        wait = 5
                        r = 250;
                        g = 0;
                        b = 0;
                        a = 200;
                        DynaMarker(1, sC2.x, sC2.y, sC2.z - 1.0, 250, 0, 0, 200, false)
                    end
                    if trDist < 5 then
                        local trH = GetEntityHeading(veh2)
                        wait = 5
                        DynaMarker(1, sC2.x, sC2.y, sC2.z - 1.0, 0, 600, 0, 100, false)
                        if trDist < 2 then
                            SetBlipRoute(mB, false)
                            RemoveBlip(mB)
                            Job10()
                            ESX.Game.DeleteVehicle(veh2)
                            ESX.Game.SpawnVehicle("trflat", tr, trH, function(veh3)
                                AttachVehicleToTrailer(veh, veh3, 1.1)
                            end)
                            return
                        end
                    end
                end
            end)
        end)
    end)
end

function Job10()
    j10 = true
    local jC2 = vector3(1337.248, 4381.108, 43.34363)
    TriggerEvent('ZORGO:ped', jC2, false, false, false, 206.9291)
    while j10 do
        Citizen.Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, jC2.x, jC2.y, jC2.z, false)
        if uDist < 20 then
            ESX.ShowHelpNotification("Sign off on the order !", true, true, 5000)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to speak with the Contractor", true, true, 5000)
                if IsControlJustPressed(0, 38) then
                    lumre()
                    return
                end
            end
        end
    end
end

function lumre()
    local sC3 = vector3(162.7121, 6447.468, 31.30188)
    local n1 = false
    local mB3 = AddBlipForCoord(sC3)
    SetBlipRoute(mB3, true)
    SetBlipRouteColour(mB3, 57)
    SetBlipColour(mB3, 57)
    Citizen.CreateThread(function()
        local wait = 100
        exports['okokNotify']:Alert("ZORGO Logistics", "Return the vehicle to the Nearest Logistics Hub", 5000, 'info')
        while not n1 do
            Citizen.Wait(wait)
            local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC3, false)
            if tDist < 40 and tDist > 10 then
                wait = 5
                local p = PlayerPedId()
                local v = GetVehiclePedIsIn(p)
                DynaMarker(1, sC3.x, sC3.y, sC3.z - 1.0, 250, 0, 0, 200, false)
            end
            if tDist <= 10 then
                onJob = false
                wait = 5
                DynaMarker(1, sC3.x, sC3.y, sC3.z - 1.0, 0, 600, 0, 200, false)
                local p = PlayerPedId()
                local v = GetVehiclePedIsIn(p)
                Citizen.Wait(1000)
                SetBlipRoute(mB3, false)
                RemoveBlip(mB3)
                Citizen.Wait(3000)
                ESX.Game.DeleteVehicle(v)
                TriggerServerEvent("ZORGO:med")
                Citizen.Wait(1000)
                n1 = true
                return
            end
        end
    end)
end

--STOP TRCUKING--
function Jobst()
    local p = PlayerPedId()
    local v = GetVehiclePedIsIn(p)
    ESX.Game.DeleteVehicle(v)
    ClearAllBlipRoutes()
    RemoveBlip(mB)
    RemoveBlip(mB3)
    jobMenu = nil;
end

RegisterNetEvent('ZORGO:stoptruck')
AddEventHandler('ZORGO:stoptruck', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        if onJob then
            Jobst()
        end
    else
        exports['okokNotify']:Alert("ZORGO Logistics", "You Are Not Inside in an Vehicle", 5000, 'info')
    end
    TriggerEvent("chat:addSuggestion", "/stoptruck", "To Stop Logistics Job --If Needed Only")
end)
