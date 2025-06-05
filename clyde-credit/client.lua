-- client.lua

local showCreditScore = false
local creditScore = 0
local targetPlayerId = nil

RegisterNetEvent('credit:showScore')
AddEventHandler('credit:showScore', function(score, playerId)
    creditScore = score
    targetPlayerId = playerId
    showCreditScore = true

    Citizen.CreateThread(function()
        Citizen.Wait(5000) -- Show the text for 5 seconds
        showCreditScore = false
        targetPlayerId = nil
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if showCreditScore and targetPlayerId then
            local targetPed = GetPlayerPed(GetPlayerFromServerId(targetPlayerId))
            local playerPos = GetEntityCoords(targetPed)

            -- Draw the credit score 1 meter above the player's head
            DrawText3D(playerPos.x, playerPos.y, playerPos.z + 1.0, string.format("Credit Score: %d", creditScore))
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
