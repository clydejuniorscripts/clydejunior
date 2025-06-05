local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('bms:drugs:removeIngredients')
AddEventHandler('bms:drugs:removeIngredients', function(drug, quantity)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ingredients = Config[drug .. "Processing"].Ingredients

    for item, amount in pairs(ingredients) do
        if Player.Functions.RemoveItem(item, amount * quantity) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove', amount * quantity)
        else
            print("Failed to remove item: " .. item .. " for player: " .. src)
        end
    end
end)

RegisterServerEvent('bms:drugs:addReward')
AddEventHandler('bms:drugs:addReward', function(drug, quantity)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local reward = Config[drug .. "Processing"].Reward

    for item, amount in pairs(reward) do
        if Player.Functions.AddItem(item, amount * quantity) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount * quantity)
        else
            print("Failed to add item: " .. item .. " for player: " .. src)
        end
    end
end)
