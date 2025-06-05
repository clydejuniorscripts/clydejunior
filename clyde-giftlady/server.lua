local QBCore = exports['qb-core']:GetCoreObject()

local dailyGiftCooldown = {}

QBCore.Functions.CreateUseableItem('tier1giftbox', function(source, item)
    TriggerEvent('angelicxs-randombox:server:UseBox', source, Config.Tier1List, Config.Tier1Amount, 'tier1giftbox')
end)

QBCore.Functions.CreateUseableItem('tier2giftbox', function(source, item)
    TriggerEvent('angelicxs-randombox:server:UseBox', source, Config.Tier2List, Config.Tier2Amount, 'tier2giftbox')
end)

QBCore.Functions.CreateUseableItem('tier3giftbox', function(source, item)
    TriggerEvent('angelicxs-randombox:server:UseBox', source, Config.Tier3List, Config.Tier3Amount, 'tier3giftbox')
end)

QBCore.Functions.CreateUseableItem('lockedcrate', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName('cratekey') then
        Player.Functions.RemoveItem('cratekey', 1)
        TriggerEvent('angelicxs-randombox:server:UseBox', source, Config.CrateList, Config.CrateAmount, 'lockedcrate')
    else
        TriggerClientEvent('angelicxs-randombox:Notify', source, Config.Lang['no_cratekey'], Config.LangType['error'])
    end
end)

QBCore.Functions.CreateUseableItem('lockedchest', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName('lockpick') then
        TriggerEvent('angelicxs-randombox:server:UseBox', source, Config.ChestList, Config.ChestAmount, 'lockedchest')
    else
        TriggerClientEvent('angelicxs-randombox:Notify', source, Config.Lang['no_lockpick'], Config.LangType['error'])
    end
end)

QBCore.Functions.CreateUseableItem('importvoucher', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Config.ImportVoucherUsed then
        Config.ImportVoucherUsed = true
        TriggerClientEvent('angelicxs-randombox:Notify', source, Config.Lang['voucher_used'], Config.LangType['success'])
    else
        TriggerClientEvent('angelicxs-randombox:Notify', source, Config.Lang['voucher_already_used'], Config.LangType['error'])
    end
end)

RegisterServerEvent('angelicxs-randombox:server:OpenBox')
AddEventHandler('angelicxs-randombox:server:OpenBox', function(tier)
    local src = source
    print("angelicxs-randombox:server:OpenBox triggered") -- Debug
    math.randomseed(os.time())
    local items = randomizer(tier, 4)  -- Get up to 4 random items from the tier list

    if items then
        local Player = QBCore.Functions.GetPlayer(src)
        for _, item in pairs(items) do
            Player.Functions.AddItem(item.name, item.amount)
            TriggerClientEvent('angelicxs-randombox:Notify', src, Config.Lang['receive'] .. item.amount .. ' ' .. item.name, Config.LangType['success'])
            TriggerClientEvent('angelicxs-randombox:ShowItem', src, item.name, item.amount)
        end
    else
        print("Failed to get items from randomizer.") -- Debug
        TriggerClientEvent('angelicxs-randombox:Notify', src, "Failed to open box, try again later.", Config.LangType['error'])
    end
end)

RegisterServerEvent('angelicxs-randombox:server:UseBox')
AddEventHandler('angelicxs-randombox:server:UseBox', function(source, tier, amount, boxName)
    local Player = QBCore.Functions.GetPlayer(source)
    print("Box used: "..boxName) -- Debug
    Player.Functions.RemoveItem(boxName, 1)
    TriggerClientEvent('angelicxs-randombox:client:OpenBox', source, tier)
end)

function randomizer(tier, maxItems)
    local List = tier
    local items = {}
    local totalItems = math.random(1, maxItems)  -- Get a random number of items between 1 and maxItems

    for i = 1, totalItems do
        local itemIndex = math.random(1, #List)
        table.insert(items, List[itemIndex])
    end

    return items
end

function generalloot(src)
    local List = Config.GeneralLoot
    local totalWeight = 0
    for _, item in pairs(List) do
        totalWeight = totalWeight + item.chance
    end

    local randomWeight = math.random(0, totalWeight)
    local currentWeight = 0

    for _, item in pairs(List) do
        currentWeight = currentWeight + item.chance
        if randomWeight <= currentWeight then
            local Player = QBCore.Functions.GetPlayer(src)
            Player.Functions.AddItem(item.name, item.amount)
            TriggerClientEvent('angelicxs-randombox:Notify', src, Config.Lang['receive'] .. item.amount .. ' ' .. item.name, Config.LangType['success'])
            TriggerClientEvent('angelicxs-randombox:ShowItem', src, item.name, item.amount)
            return
        end
    end
end

RegisterServerEvent('angelicxs-randombox:server:GetMoney')
AddEventHandler('angelicxs-randombox:server:GetMoney', function(tier)
    local level = {}
    local box = ''
    local amount = 0
    local src = source
    if tier == Config.Tier1Price then
        level = Config.Tier1List
        box = Config.Tier1Name
        amount = Config.Tier1Amount
    elseif tier == Config.Tier2Price then
        level = Config.Tier2List
        box = Config.Tier2Name
        amount = Config.Tier2Amount
    elseif tier == Config.Tier3Price then
        level = Config.Tier3List
        box = Config.Tier3Name
        amount = Config.Tier3Amount
    end
    local player = QBCore.Functions.GetPlayer(src)
    local cash = player.PlayerData.money['cash']
    if cash >= tier then
        player.Functions.RemoveMoney('cash', tier, "Gift-Box-Purchase")
        if Config.InstantOpen then
            TriggerEvent('angelicxs-randombox:server:OpenBox', src, level, amount)
        else
            player.Functions.AddItem(box, 1)
        end
        TriggerClientEvent('angelicxs-randombox:Notify', src, Config.Lang['purchase'], Config.LangType['success'])
    else
        TriggerClientEvent('angelicxs-randombox:Notify', src, Config.Lang['nofunds'], Config.LangType['error'])
    end
end)

RegisterServerEvent('angelicxs-randombox:server:GetDailyGift')
AddEventHandler('angelicxs-randombox:server:GetDailyGift', function()
    local src = source
    local PlayerId = GetPlayerIdentifier(src)
    local currentTime = os.time()

    if dailyGiftCooldown[PlayerId] and currentTime - dailyGiftCooldown[PlayerId] < Config.DailyGiftCooldown * 3600 then
        local timeRemaining = Config.DailyGiftCooldown * 3600 - (currentTime - dailyGiftCooldown[PlayerId])
        TriggerClientEvent('angelicxs-randombox:Notify', src, Config.Lang['daily_gift_collected'] .. math.ceil(timeRemaining / 3600) .. Config.Lang['time_remaining'], Config.LangType['error'])
    else
        dailyGiftCooldown[PlayerId] = currentTime
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddItem(Config.Tier1Name, 1)
        TriggerClientEvent('angelicxs-randombox:Notify', src, Config.Lang['receive'] .. "1 " .. Config.Tier1Name, Config.LangType['success'])
        TriggerClientEvent('angelicxs-randombox:ShowItem', src, Config.Tier1Name, 1)
    end
end)
