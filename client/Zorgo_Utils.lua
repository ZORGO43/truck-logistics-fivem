

Blips = {}


Citizen.CreateThread(function()
    Blips = {			
        [1] = {
            blip = nil, 
            name = "ZORGO Logistics",
            coords = vector3(110.6374,-2577.02,6.684204), 
        },
        [2] = {
            blip = nil, 
            name = "ZORGO Logistics", 
             coords = vector3(114.1451, 6372.62, 31.36926), 
        },
    }
    for k, _ in pairs(Blips) do
        local b = AddBlipForCoord(_.coords)
        SetBlipSprite(b,85)
        SetBlipColour(b, 57)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(_.name)
        EndTextCommandSetBlipName(b)
        SetBlipAsShortRange(b,true)
        SetBlipAsMissionCreatorBlip(b,true)
         _.b = b
    end
end)


--NEEDED FUNCTIONS--
function DynaMarker(type,posX,posY,posZ,r,g,b,a,multi)
    if multi == true then
        DrawMarker(type, posX,posY,posZ, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, r, g, b, a, false, true, 2, false, false, false, false)
    else
        DrawMarker(type, posX, posY,posZ, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 5.0, r, g, b, a, false, true, 2, false, false, false, false)
    end
end
function DrawMissionText(text)
    SetTextScale(0.5, 0.5)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextOutline()
    AddTextComponentString(text)
    DrawText(0.5,0.955)
end
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

