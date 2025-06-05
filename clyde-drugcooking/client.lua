-- client.lua
local QBCore = exports['qb-core']:GetCoreObject()
local playerInfo = {}
local cooking = false
local canCook = true

local function draw3DText(x, y, z, text, sc)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local camPos = GetGameplayCamCoords()
    local dist = #(camPos - vector3(x, y, z))
    local scale = (1 / dist) * (1 / GetGameplayCamFov()) * 100

    if onScreen then
        SetTextScale(0.0, sc or 0.55 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

local function checkIngredients(drug)
    local ingredients = Config[drug .. "Processing"].Ingredients
    local missingIngredients = {}
    for item, amount in pairs(ingredients) do
        if not QBCore.Functions.HasItem(item, amount) then
            table.insert(missingIngredients, item)
        end
    end
    return #missingIngredients == 0, missingIngredients
end

local function startTimer(duration, action)
    SendNUIMessage({
        action = action,
        duration = duration
    })
end

local function stopTimer(action)
    SendNUIMessage({
        action = action
    })
end

local function cancelCooking()
    cooking = false
    canCook = true
    stopTimer('stopCooking')
    QBCore.Functions.Notify("Cooking cancelled due to death or leaving the area.", "error")
end

local function cookDrug(drug)
    local hasIngredients, missingIngredients = checkIngredients(drug)
    if not hasIngredients then
        QBCore.Functions.Notify("You are missing ingredients: " .. table.concat(missingIngredients, ", "), "error")
        canCook = true
        return
    end

    cooking = true
    local duration = Config[drug .. "Processing"].CookingTime

    QBCore.Functions.Notify("Cooking started. Please step away from the lab.", "success")
    TriggerServerEvent('bms:jobs:meth:removeIngredients', drug)
    startTimer(duration, "startCooking")

    Citizen.CreateThread(function()
        while cooking do
            Citizen.Wait(1000)
            duration = duration - 1000

            if IsEntityDead(PlayerPedId()) then
                cancelCooking()
                break
            end

            if math.random(1, 100) <= Config[drug .. "Processing"].ExplosionChance then
                cooking = false
                canCook = true
                TriggerServerEvent('bms:jobs:meth:triggerExplosion')
                break
            end

            if duration <= 0 then
                cooking = false
                canCook = true
                TriggerServerEvent('bms:jobs:meth:addReward', drug)
                TriggerEvent('inventory:client:BlockInventory', false)
                stopTimer('stopCooking')
            end
        end
    end)
end

local function showCookMenu()
    local elements = {
        {header = "Select A Drug to Cook", isMenuHeader = true},
        {header = "Cook 1 Ounce of Meth", params = {event = "cook:drug", args = "Meth"}},
        {header = "Cook 12 Crack Cocaine Baggy", params = {event = "cook:drug", args = "Crack"}},
        {header = "Cook 1 Cocaine Brick", params = {event = "cook:drug", args = "Coke"}},
        {header = "Cook 12 Heroin Baggy ", params = {event = "cook:drug", args = "Heroin"}}
    }
    exports['qb-menu']:openMenu(elements)
end

RegisterNetEvent('cook:drug', function(drug)
    if cooking then
        QBCore.Functions.Notify("You are already cooking. Please wait until your current cook is done.", "error")
    else
        cookDrug(drug)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local playerPos = GetEntityCoords(PlayerPedId())
        local distCook = #(playerPos - Config.CookingLabLocation.pos)

        if distCook < 10 then
            DrawMarker(27, Config.CookingLabLocation.pos.x, Config.CookingLabLocation.pos.y, Config.CookingLabLocation.pos.z - 0.9, 0, 0, 0, 0, 0, 0, 1.1, 1.1, 0.9, 240, 70, 70, 150, 0, 0, 0, true, 0, 0, 0)
            if distCook < 5 and not playerInfo.isDead then
                draw3DText(Config.CookingLabLocation.pos.x, Config.CookingLabLocation.pos.y, Config.CookingLabLocation.pos.z + 0.25, "Press [~b~E~w~] to cook drugs.", 0.29)
                if IsControlJustReleased(1, 38) then
                    showCookMenu()
                end
            end
        end

        if cooking then
            local dist = #(playerPos - Config.CookingLabLocation.pos)
            if dist > 25 then
                cancelCooking()
            end
        end
    end
end)

RegisterNetEvent('bms:jobs:meth:explosionEffect')
AddEventHandler('bms:jobs:meth:explosionEffect', function()
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)

    AddExplosion(playerPos.x, playerPos.y, playerPos.z, 2, 100.0, true, false, 1.0)
    SetEntityHealth(playerPed, GetEntityHealth(playerPed) - 50)
    QBCore.Functions.Notify("The lab exploded! You took damage.", "error")
end)

RegisterNetEvent('police:client:ExplosionAlert')
AddEventHandler('police:client:ExplosionAlert', function(coords)
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local distance = #(playerPos - coords)

    if distance < 1000.0 then
        QBCore.Functions.Notify("Explosion detected near your location!", "error")
    end
end)
