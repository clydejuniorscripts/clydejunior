-- server.lua
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('bms:jobs:meth:removeIngredients')
AddEventHandler('bms:jobs:meth:removeIngredients', function(drug)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ingredients = Config[drug .. "Processing"].Ingredients

    for item, amount in pairs(ingredients) do
        if Player.Functions.RemoveItem(item, amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove', amount)
        else
            print("Failed to remove item: " .. item .. " for player: " .. src)
        end
    end
end)

RegisterServerEvent('bms:jobs:meth:addReward')
AddEventHandler('bms:jobs:meth:addReward', function(drug)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local reward = Config[drug .. "Processing"].Reward

    for item, amount in pairs(reward) do
        if Player.Functions.AddItem(item, amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
        else
            print("Failed to add item: " .. item .. " for player: " .. src)
        end
    end
end)

RegisterServerEvent('bms:jobs:meth:triggerExplosion')
AddEventHandler('bms:jobs:meth:triggerExplosion', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        print("[EXPLOSION] Player " .. src .. " caused an explosion at the lab.")

        if Config.PoliceAlert then
            local coords = GetEntityCoords(GetPlayerPed(src))
            TriggerClientEvent('police:client:ExplosionAlert', -1, coords)
        end

        TriggerClientEvent('bms:jobs:meth:explosionEffect', src)
    end
end)