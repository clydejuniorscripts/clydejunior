
local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-mining:server:GiveReward', function(source, cb, mineral)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        Player.Functions.AddItem(mineral, 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[mineral], 'add')
    end
end)
        