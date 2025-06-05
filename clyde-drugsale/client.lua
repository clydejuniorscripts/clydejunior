
local QBCore = exports['qb-core']:GetCoreObject()
local isSelling = false
local currentDrug = nil
local buyerBlip = nil
local activeBuyers = {}
local soldPeds = {}

RegisterCommand('selldrugs', function()
    if isSelling then
        QBCore.Functions.Notify("You are already selling drugs!", "error")
        return
    end

    local inventory = QBCore.Functions.GetPlayerData().items
    local sellableItems = {}

    for _, item in pairs(inventory) do
        if Config.Items[item.name] then
            table.insert(sellableItems, { label = string.format("%s (%d)", item.label, item.amount), itemName = item.name })
        end
    end

    if #sellableItems > 0 then
        local menuOptions = {}

        for _, item in pairs(sellableItems) do
            table.insert(menuOptions, {
                header = item.label,
                txt = "Sell this drug",
                params = {
                    event = "drugdeal:startSelling",
                    args = { itemName = item.itemName }
                }
            })
        end

        exports['qb-menu']:openMenu(menuOptions)
    else
        QBCore.Functions.Notify("You have no drugs to sell!", "error")
    end
end)

RegisterNetEvent('drugdeal:startSelling', function(data)
    if not QBCore.Functions.HasItem(data.itemName) then
        QBCore.Functions.Notify("You no longer have the selected drug.", "error")
        return
    end

    currentDrug = data.itemName
    isSelling = true

    QBCore.Functions.Notify("You are now selling " .. currentDrug .. ". Press BACKSPACE to stop.", "success")
    StartSellingLoop()
    ShowSellingNotification()

    CreateThread(function()
        while isSelling do
            Wait(0)
            if IsControlJustReleased(0, 177) then -- BACKSPACE key
                StopSelling()
            end
        end
    end)
end)

function StartSellingLoop()
    CreateThread(function()
        while isSelling do
            if #activeBuyers < Config.MaxBuyersAtOnce then
                local newBuyer = FindNearbyPed()
                if newBuyer and not soldPeds[newBuyer] then
                    soldPeds[newBuyer] = true
                    table.insert(activeBuyers, newBuyer)
                    HandleTransaction(newBuyer)
                end
            end

            if not QBCore.Functions.HasItem(currentDrug) then
                QBCore.Functions.Notify("You ran out of " .. currentDrug .. ". Stopping selling.", "error")
                StopSelling()
                return
            end

            Wait(5000)
        end
    end)
end

function StopSelling()
    isSelling = false
    currentDrug = nil
    activeBuyers = {}
    RemoveBuyerBlip()
    QBCore.Functions.Notify("You have stopped selling drugs.", "error")
    ClearSellingNotification()
end

function FindNearbyPed()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local closestPed, closestDist = nil, Config.SellRadius

    for ped in EnumeratePeds() do
        if not IsPedAPlayer(ped) and IsPedHuman(ped) and not IsPedInAnyVehicle(ped) and not soldPeds[ped] then
            local pedCoords = GetEntityCoords(ped)
            local dist = #(playerCoords - pedCoords)

            if dist < closestDist then
                closestPed = ped
                closestDist = dist
            end
        end
    end

    return closestPed
end

function HandleTransaction(ped)
    TaskGoToEntity(ped, PlayerPedId(), -1, 1.0, 1.0, 0, 0)
    CreateBuyerBlip(ped)

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    CreateThread(function()
        while #(GetEntityCoords(ped) - playerCoords) > 1.5 do
            Wait(100)
        end

        if #(GetEntityCoords(ped) - playerCoords) <= 1.5 then
            FreezeEntityPosition(ped, true)
            local amountToSell = math.random(1, 3)
            PlayDealAnimation(ped)
            TriggerServerEvent('drugdeal:completeDeal', currentDrug, ped, amountToSell)
            Wait(3000)
            FreezeEntityPosition(ped, false)
            RemoveBuyerBlip()
            TaskWanderStandard(ped, 10.0, 10)
        end
    end)
end

function PlayDealAnimation(ped)
    local playerPed = PlayerPedId()
    RequestAnimDict("mp_common")
    while not HasAnimDictLoaded("mp_common") do
        Wait(10)
    end

    TaskPlayAnim(playerPed, "mp_common", "givetake1_b", 8.0, -8.0, -1, 49, 0, false, false, false)
    TaskPlayAnim(ped, "mp_common", "givetake1_a", 8.0, -8.0, -1, 49, 0, false, false, false)

    Wait(3000)
    ClearPedTasks(playerPed)
    ClearPedTasks(ped)
end

function CreateBuyerBlip(ped)
    if DoesBlipExist(buyerBlip) then
        RemoveBlip(buyerBlip)
    end

    buyerBlip = AddBlipForEntity(ped)
    SetBlipSprite(buyerBlip, 1)
    SetBlipColour(buyerBlip, 2)
    SetBlipScale(buyerBlip, 0.8)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Buyer")
    EndTextCommandSetBlipName(buyerBlip)
end

function RemoveBuyerBlip()
    if DoesBlipExist(buyerBlip) then
        RemoveBlip(buyerBlip)
    end
    buyerBlip = nil
end

function ShowSellingNotification()
    QBCore.Functions.Notify("You are currently selling " .. currentDrug .. ". Press BACKSPACE to stop.", "primary", 0)
end

function ClearSellingNotification()
    QBCore.Functions.Notify("Selling stopped.", "error", 0)
end

function EnumeratePeds()
    return coroutine.wrap(function()
        local handle, ped = FindFirstPed()
        if not handle or handle == -1 then
            return
        end

        local success
        repeat
            coroutine.yield(ped)
            success, ped = FindNextPed(handle)
        until not success

        EndFindPed(handle)
    end)
end
