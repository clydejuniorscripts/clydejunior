-- server.lua

QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('credit', function(source, args, rawCommand)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bankBalance = Player.PlayerData.money['bank']
    local cashBalance = Player.PlayerData.money['cash']
    
    local totalMoney = bankBalance + cashBalance
    
    local creditScore = 300 -- default starting score

    -- Adjust credit score based on refined ranges of totalMoney (bank + cash balance)
    if totalMoney < 2000000 then
        creditScore = math.random(300, 579) -- Bad Credit
    elseif totalMoney >= 2000000 and totalMoney < 5000000 then
        creditScore = math.random(580, 659) -- Fair Credit
    elseif totalMoney >= 5000000 and totalMoney < 10000000 then
        creditScore = math.random(660, 699) -- Good Credit
    elseif totalMoney >= 10000000 and totalMoney < 50000000 then
        creditScore = math.random(700, 749) -- Very Good Credit
    elseif totalMoney >= 50000000 and totalMoney < 200000000 then
        creditScore = math.random(750, 799) -- Excellent Credit
    elseif totalMoney >= 200000000 then
        creditScore = math.random(800, 850) -- Exceptional Credit
    end

    -- Ensure credit score doesn't exceed 850
    if creditScore > 850 then
        creditScore = 850
    end

    -- Send the credit score to the player and nearby players
    TriggerClientEvent('credit:showScore', src, creditScore, src)

    -- Send credit score to nearby players within a radius of 10 meters
    local players = QBCore.Functions.GetPlayers()
    for _, playerId in ipairs(players) do
        if playerId ~= src then
            local targetPlayer = QBCore.Functions.GetPlayer(playerId)
            if targetPlayer then
                local targetPed = GetPlayerPed(playerId)
                local srcPed = GetPlayerPed(src)
                local distance = #(GetEntityCoords(targetPed) - GetEntityCoords(srcPed))
                if distance <= 10.0 then
                    TriggerClientEvent('credit:showScore', playerId, creditScore, src)
                end
            end
        end
    end
end, false)
