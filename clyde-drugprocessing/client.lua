local QBCore = exports['qb-core']:GetCoreObject()
local playerInfo = {}
local processing = false
local canProcess = true

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

local function checkIngredients(drug, quantity)
    local ingredients = Config[drug .. "Processing"].Ingredients
    local missingIngredients = {}
    for item, amount in pairs(ingredients) do
        if not QBCore.Functions.HasItem(item, amount * quantity) then
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

local function processDrug(drug, quantity)
    local hasIngredients, missingIngredients = checkIngredients(drug, quantity)
    if not hasIngredients then
        QBCore.Functions.Notify("You are missing ingredients: " .. table.concat(missingIngredients, ", "), "error")
        canProcess = true
        return
    end

    processing = true -- Ensure this is set to true when processing starts
    local duration = Config[drug .. "Processing"].ProcessingTime * quantity

    QBCore.Functions.Notify("Breakdown started. Please stay close to the marker or you will loose your drugs.", "success")
    TriggerServerEvent('bms:drugs:removeIngredients', drug, quantity) -- Remove ingredients when processing starts
    startTimer(duration, "startProcessing")

    Citizen.CreateThread(function()
        while processing do
            Citizen.Wait(1000)
            duration = duration - 1000
            if duration <= 0 then
                processing = false
                canProcess = true
                TriggerServerEvent('bms:drugs:addReward', drug, quantity)
                TriggerEvent('inventory:client:BlockInventory', false)
                stopTimer('stopProcessing')
            end
        end
    end)
end

local function showQuantityMenu(drug)
    local input = exports['qb-input']:ShowInput({
        header = "Select Quantity",
        submitText = "Confirm",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'quantity',
                text = 'Enter quantity'
            }
        }
    })
    
    if input then
        local quantity = tonumber(input.quantity)
        if quantity and quantity > 0 then
            processDrug(drug, quantity)
        else
            QBCore.Functions.Notify("Invalid quantity.", "error")
        end
    end
end

local function showProcessMenu()
    local elements = {
        {header = "Select Drug to Breakdown", isMenuHeader = true},
        {header = "Breakdown Coke Brick", params = {event = "process:drug", args = "CokeBrick"}},
        {header = "Breakdown Small Coke Brick", params = {event = "process:drug", args = "SmallCokeBrick"}},
        {header = "Breakdown Cartel Brick", params = {event = "process:drug", args = "CartelBrick"}},
        {header = "Breakdown Meth Tray", params = {event = "process:drug", args = "Meth"}},
        {header = "Breakdown Weed Brick", params = {event = "process:drug", args = "WeedBrick"}}
    }
    exports['qb-menu']:openMenu(elements)
end

RegisterNetEvent('process:drug', function(drug)
    if processing then
        QBCore.Functions.Notify("You are already processing. Please wait until your current process is done.", "error")
    else
        showQuantityMenu(drug)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local playerPos = GetEntityCoords(PlayerPedId())

        -- Processing interaction
        local distProcess = #(playerPos - Config.ProcessingLabLocation.pos)
        if distProcess < 10 then -- Reduced from 50 to 10
            DrawMarker(27, Config.ProcessingLabLocation.pos.x, Config.ProcessingLabLocation.pos.y, Config.ProcessingLabLocation.pos.z - 0.9, 0, 0, 0, 0, 0, 0, 1.1, 1.1, 0.9, 240, 70, 70, 150, 0, 0, 0, true, 0, 0, 0)
            if distProcess < 5 and not playerInfo.isDead then -- Reduced from 20 to 5
                draw3DText(Config.ProcessingLabLocation.pos.x, Config.ProcessingLabLocation.pos.y, Config.ProcessingLabLocation.pos.z + 0.25, "Press [~b~E~w~] to breakdown drugs.", 0.29)
                if IsControlJustReleased(1, 38) then
                    showProcessMenu()
                end
            end
        end

        if processing then
            local dist = #(playerPos - Config.ProcessingLabLocation.pos)
            if dist > 25 then
                QBCore.Functions.Notify("You have moved too far away from the lab and the materials were ruined.", "error")
                processing = false
                canProcess = true
                stopTimer('stopProcessing')
            end
        end
    end
end)
