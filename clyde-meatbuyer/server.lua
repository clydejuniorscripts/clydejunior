local QBCore = exports['qb-core']:GetCoreObject()

local function distributeProfits(totalPrice)
    local profitShare = totalPrice * (Config.ProfitSharePercentage / 100)
    local players = QBCore.Functions.GetPlayers()
    for _, playerId in ipairs(players) do
        local Player = QBCore.Functions.GetPlayer(playerId)
        if Player and Player.PlayerData.job.name == 'meatbuyer' and Player.PlayerData.job.onduty then
            Player.Functions.AddMoney('bank', profitShare)
            TriggerClientEvent('QBCore:Notify', playerId, 'You received $' .. profitShare .. ' as your profit share', 'success')
        end
    end
end

RegisterNetEvent('meatbuyer:server:sellMeatItems', function(itemName, itemAmount, itemPrice)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalPrice = (tonumber(itemAmount) * itemPrice)
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local dist
    for _, value in pairs(Config.MeatLocation) do
        dist = #(playerCoords - value.coords)
        if dist < 2 then
            break
        end
    end
    if dist > 5 then return end
    if Player.Functions.RemoveItem(itemName, tonumber(itemAmount)) then
        if Config.BankMoney then
            Player.Functions.AddMoney('bank', totalPrice)
        else
            Player.Functions.AddMoney('cash', totalPrice)
        end
        distributeProfits(totalPrice)
        TriggerClientEvent('QBCore:Notify', src, 'You have sold ' .. tonumber(itemAmount) .. ' x ' .. QBCore.Shared.Items[itemName].label .. ' for $' .. totalPrice, 'success')
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
    else
        TriggerClientEvent('QBCore:Notify', src, 'Not enough items', 'error')
    end
end)

QBCore.Functions.CreateCallback('meatbuyer:server:ItemAmount', function(source, cb, item)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items
    local amount = 0
    for _, v in pairs(inventory) do
        if item == v.name then
            amount = amount + v.amount
        end
    end
    cb(amount)
end)
