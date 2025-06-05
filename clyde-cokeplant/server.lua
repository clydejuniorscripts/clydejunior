-- server.lua
local QBCore = exports['qb-core']:GetCoreObject()

-- Event to give coca leaves
RegisterNetEvent('qb-cokeplant:server:GiveCocaLeaves', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        Player.Functions.AddItem(Config.RewardItems.CocaLeaves, 1)
        TriggerClientEvent('QBCore:Notify', src, "You harvested some coca leaves.", "success")
    end
end)

-- Event to give poppy resin
RegisterNetEvent('qb-cokeplant:server:GivePoppyResin', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        Player.Functions.AddItem(Config.RewardItems.PoppyResin, 1)
        TriggerClientEvent('QBCore:Notify', src, "You harvested some poppy resin.", "success")
    end
end)

-- Event to process coca leaves
RegisterNetEvent('qb-cokeplant:server:ProcessCocaLeaves', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        local cocaLeaves = Player.Functions.GetItemByName(Config.RewardItems.CocaLeaves)

        if cocaLeaves and cocaLeaves.amount >= 6 then
            local processAmount = math.floor(cocaLeaves.amount / 6) * 3
            Player.Functions.RemoveItem(Config.RewardItems.CocaLeaves, processAmount * 2)
            TriggerClientEvent('QBCore:Notify', src, "Processing Coca Leaves...", "success")
            SetTimeout(60000, function()
                Player.Functions.AddItem(Config.RewardItems.CocaPaste, processAmount)
                TriggerClientEvent('QBCore:Notify', src, "You processed coca leaves into coca paste.", "success")
            end)
        else
            TriggerClientEvent('QBCore:Notify', src, "You need at least 6 coca leaves to process.", "error")
        end
    end
end)

-- Event to give coca paste
RegisterNetEvent('qb-cokeplant:server:GiveCocaPaste', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        Player.Functions.RemoveItem(Config.RewardItems.CocaLeaves, 1)
        Player.Functions.AddItem(Config.RewardItems.CocaPaste, 1)
        TriggerClientEvent('QBCore:Notify', src, "You processed the coca leaves into paste.", "success")
    end
end)

-- Event to give cocaine brick
RegisterNetEvent('qb-cokeplant:server:GiveCocaBrick', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        Player.Functions.RemoveItem(Config.RewardItems.CocaPaste, 1)
        Player.Functions.AddItem(Config.RewardItems.CocaBrick, 1)
        TriggerClientEvent('QBCore:Notify', src, "You processed the paste into a cocaine brick.", "success")
    end
end)