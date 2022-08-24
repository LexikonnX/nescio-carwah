local price = 100
local seconds = 1 --How long will the washing process take?
-- Texts
local Text = {
    ["carwash"] = "Car Wash",
    ["pay"] = "Pay ~g~$"..price.."~w~ for the wash",
    ["finish"] = "~g~Complete",
    ["noMoney"] = "You have not ~y~money"
}
local blipcolor = 0 -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
local blipsprite = 100 -- https://docs.fivem.net/docs/game-references/blips/#blips
local carwwash = { --You can add more
    {enter = vector3(48.2556, -1392.25451, 29.41617), exit = vector3(-4.096771, -1391.981079, 28.88156)}
}





--------------------- DON'T EDIT THIS IF YOU DON'T KNOW WHAT YOU'RE DOING -------------------------
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(0)
    for i=1,#carwwash do
        blip = AddBlipForCoord(carwwash[i].enter.x, carwwash[i].enter.y, carwwash[i].enter.z)
        SetBlipSprite(blip, blipsprite)
        SetBlipScale(blip, 0.9)
        SetBlipColour(blip, blipcolor)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Text.carwash)
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    while true do
        coords = GetEntityCoords(PlayerPedId())
        onFoot = IsPedOnFoot(PlayerPedId())
        Citizen.Wait(0)
    end
end)

CreateThread(function()
    while true do   
        Citizen.Wait(0)
        for i=1,#carwwash do
            local distance = #(coords-carwwash[i].enter)
            if distance <= 20 then
                if distance <= 20 and distance > 3 then
                    DrawMarker(36, carwwash[i].enter.x, carwwash[i].enter.y, carwwash[i].enter.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 93, 182, 229, 100, false, true, 0, false)
                else
                    DrawText3Ds(carwwash[i].enter.x, carwwash[i].enter.y, carwwash[i].enter.z, Text.pay)
                end
                if distance <= 3 then
                    if not onFoot then
                        ESX.ShowHelpNotification("~INPUT_CONTEXT~ "..Text.pay)
                        if IsControlJustReleased(0, 38) then
                            ESX.TriggerServerCallback("nescio-carwash:pay", function(res)
                                if res == true then
                                    DoScreenFadeOut(500)
                                    Wait(seconds * 1000)
                                    SetPedCoordsKeepVehicle(PlayerPedId(), carwwash[i].exit.x, carwwash[i].exit.y, carwwash[i].exit.z)
                                    local vehicle = GetVehiclePedIsIn(PlayerPedId())
                                    SetVehicleDirtLevel(vehicle, 0)
                                    DoScreenFadeIn(500)
                                    ESX.ShowNotification(Text.finish)
                                else
                                    ESX.ShowNotification(Text.noMoney)
                                end
                            end, price)
                        end
                    end
                end
            end
        end
    end
end)

function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end