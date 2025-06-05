
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('drugdeal:completeDeal', function(item, ped, amount)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local itemData = Config.Items[item]

    if itemData then
        if xPlayer.Functions.RemoveItem(item, amount) then
            local profit = math.random(itemData.basePrice, itemData.maxPrice) * amount
            xPlayer.Functions.AddMoney('cash', profit, 'drug-dealing')
            TriggerClientEvent('QBCore:Notify', src, "You sold " .. amount .. "x " .. item .. " for $" .. profit, 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough of that item!", 'error')
        end
    else
        print("Invalid item: " .. item)
    end
end)
