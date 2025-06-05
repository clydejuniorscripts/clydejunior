local QBCore = exports['qb-core']:GetCoreObject()

-- Function to initialize or reset daily purchase count
local function initializePurchaseCount(source)
    if not source or source <= 0 then
        print('[initializePurchaseCount] Invalid source provided.')
        return
    end

    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        print('[initializePurchaseCount] Player not found for source:', source)
        return
    end

    local identifier = Player.PlayerData.citizenid

    MySQL.Async.execute(
        'INSERT INTO player_purchases (citizenid, count, last_reset) VALUES (@citizenid, 0, NOW()) ' ..
        'ON DUPLICATE KEY UPDATE count = IF(DATEDIFF(NOW(), last_reset) > 0, 0, count), last_reset = IF(DATEDIFF(NOW(), last_reset) > 0, NOW(), last_reset)', {
        ['@citizenid'] = identifier
    }, function(rowsChanged)
        print('[initializePurchaseCount] Rows updated/inserted:', rowsChanged)
    end)
end

-- Event to handle player loading
AddEventHandler('QBCore:Server:PlayerLoaded', function(player)
    if player then
        initializePurchaseCount(player.source)
    else
        print('[PlayerLoaded] Player object is nil.')
    end
end)

-- Function to get the current purchase count
local function getPurchaseCount(source, callback)
    if not source or source <= 0 then
        print('[getPurchaseCount] Invalid source provided.')
        callback(0)
        return
    end

    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        print('[getPurchaseCount] Player not found for source:', source)
        callback(0)
        return
    end

    local identifier = Player.PlayerData.citizenid

    MySQL.Async.fetchScalar(
        'SELECT count FROM player_purchases WHERE citizenid = @citizenid', {
        ['@citizenid'] = identifier
    }, function(count)
        callback(count or 0)
    end)
end

-- Function to increment the purchase count
local function incrementPurchaseCount(source, amount)
    if not source or source <= 0 then
        print('[incrementPurchaseCount] Invalid source provided.')
        return
    end

    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        print('[incrementPurchaseCount] Player not found for source:', source)
        return
    end

    local identifier = Player.PlayerData.citizenid

    MySQL.Async.execute(
        'UPDATE player_purchases SET count = count + @amount WHERE citizenid = @citizenid', {
        ['@amount'] = amount,
        ['@citizenid'] = identifier
    }, function(rowsChanged)
        print('[incrementPurchaseCount] Rows updated:', rowsChanged)
    end)
end

-- Server event to handle purchases
RegisterServerEvent('clydewholesale:PurchaseItem')
AddEventHandler('clydewholesale:PurchaseItem', function(item, amount)
    local source = source
    if not source or source <= 0 then
        print('[PurchaseItem] Invalid source provided.')
        return
    end

    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        print('[PurchaseItem] Player not found for source:', source)
        return
    end

    getPurchaseCount(source, function(count)
        if count + amount <= 1000 then
            -- Check if the player has enough money
            if Player.Functions.RemoveMoney('cash', item.price * amount) then
                Player.Functions.AddItem(item.name, amount)
                TriggerClientEvent('QBCore:Notify', source, 'Purchase successful!', 'success')

                -- Increment the purchase count
                incrementPurchaseCount(source, amount)
            else
                TriggerClientEvent('QBCore:Notify', source, 'Not enough money.', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'You have reached your daily purchase limit of 1000 items.', 'error')
        end
    end)
end)

-- Debugging for server startup
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print('[clydewholesale] Resource started successfully.')
    end
end)
