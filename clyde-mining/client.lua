
local QBCore = exports['qb-core']:GetCoreObject()
local mining = false
local smelting = false
local minerals = {
    {name = "iron", label = "Iron Ore", chance = 60},
    {name = "gold", label = "Gold Ore", chance = 30},
    {name = "diamond", label = "Diamond", chance = 10},
    {name = "coal", label = "Coal Ore", chance = 40}
}
local miningSpots = Config.MiningSpots
local smeltingSpot = Config.SmeltingSpot
local sellingSpots = Config.SellingSpots

Citizen.CreateThread(function()
    for _, spot in pairs(miningSpots) do
        local blip = AddBlipForCoord(spot.coords)
        SetBlipSprite(blip, 618)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.75)
        SetBlipColour(blip, 5)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Mining Area")
        EndTextCommandSetBlipName(blip)
    end

    local smeltingBlip = AddBlipForCoord(smeltingSpot.coords)
    SetBlipSprite(smeltingBlip, 436)
    SetBlipDisplay(smeltingBlip, 4)
    SetBlipScale(smeltingBlip, 0.75)
    SetBlipColour(smeltingBlip, 17)
    SetBlipAsShortRange(smeltingBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Smelting Spot")
    EndTextCommandSetBlipName(smeltingBlip)

    for _, spot in pairs(sellingSpots) do
        local blip = AddBlipForCoord(spot.coords)
        SetBlipSprite(blip, 500)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.75)
        SetBlipColour(blip, 2)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(spot.label)
        EndTextCommandSetBlipName(blip)
    end
end)

-- Mining function
local function StartMining()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local nearestSpot = nil

    for _, spot in pairs(miningSpots) do
        local distance = #(coords - spot.coords)
        if distance < 2.0 then
            nearestSpot = spot
            break
        end
    end

    if nearestSpot then
        mining = true
        QBCore.Functions.Progressbar("mining", "Mining...", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            local foundMineral = math.random(100)
            local reward = nil

            for _, mineral in pairs(minerals) do
                if foundMineral <= mineral.chance then
                    reward = mineral
                    break
                end
            end

            if reward then
                TriggerServerEvent('qb-mining:server:GiveReward', reward.name)
                QBCore.Functions.Notify("You found some " .. reward.label .. "!", "success")
            else
                QBCore.Functions.Notify("You found nothing.", "error")
            end

            mining = false
        end, function()
            QBCore.Functions.Notify("Mining cancelled.", "error")
            mining = false
        end)
    else
        QBCore.Functions.Notify("You are not near a mining spot.", "error")
    end
end

RegisterCommand("mine", function()
    if not mining then
        StartMining()
    else
        QBCore.Functions.Notify("You are already mining.", "error")
    end
end)
        