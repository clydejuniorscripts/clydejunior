-- client.lua
local QBCore = exports['qb-core']:GetCoreObject()

local currentPlants = {}

-- Function to spawn plants within a specified area
function SpawnPlants()
    local startCoords = vector4(5284.81, -5249.41, 30.74, 317.66)
    local endCoords = vector4(5363.91, -5153.70, 27.39, 130.70)

    local plantCount = math.random(15, 25) -- Random number of plants between 15 and 25
    for i = 1, plantCount do
        local x = math.random(math.floor(math.min(startCoords.x, endCoords.x)), math.ceil(math.max(startCoords.x, endCoords.x)))
        local y = math.random(math.floor(math.min(startCoords.y, endCoords.y)), math.ceil(math.max(startCoords.y, endCoords.y)))
        local z = startCoords.z -- Use a fixed Z value to avoid random floating issues

        local plantType = math.random(1, 2)
        local obj

        if plantType == 1 then
            obj = CreateObject(GetHashKey('prop_plant_fern_02a'), x + 0.5, y + 0.5, z, false, false, false)
            PlaceObjectOnGroundProperly(obj)
            table.insert(currentPlants, {object = obj, pos = vector3(x + 0.5, y + 0.5, z), plantType = 'coca'})
        else
            obj = CreateObject(GetHashKey('prop_plant_fern_01b'), x + 0.5, y + 0.5, z, false, false, false)
            PlaceObjectOnGroundProperly(obj)
            table.insert(currentPlants, {object = obj, pos = vector3(x + 0.5, y + 0.5, z), plantType = 'poppy'})
        end

        -- Monitor distance to allow pressing E to harvest
        CreateThread(function()
            while DoesEntityExist(obj) do
                local playerPed = PlayerPedId()
                local playerPos = GetEntityCoords(playerPed)
                local dist = #(playerPos - vector3(x + 0.5, y + 0.5, z))

                if dist < 2.0 then
                    DrawText3D(x + 0.5, y + 0.5, z + 1.0, "Press [E] to Harvest Plant", 255, 0, 0)

                    if IsControlJustReleased(0, 38) then -- E key
                        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
                        QBCore.Functions.Progressbar("harvest_plant", "Harvesting Plant...", Config.PickTime, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function()
                            ClearPedTasks(playerPed)
                            TriggerEvent('qb-cokeplant:client:PickPlant', {plantType = plantType == 1 and 'coca' or 'poppy', entity = obj})
                        end)
                        break
                    end
                end

                Wait(0)
            end
        end)
    end
end

-- Event to pick plant
RegisterNetEvent('qb-cokeplant:client:PickPlant', function(data)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("harvest_plant", "Harvesting Plant...", Config.PickTime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        if data.plantType == 'coca' then
            TriggerServerEvent('qb-cokeplant:server:GiveCocaLeaves')
        elseif data.plantType == 'poppy' then
            TriggerServerEvent('qb-cokeplant:server:GivePoppyResin')
        else
            print('[DEBUG] Unknown plant type: ' .. tostring(data.plantType))
        end
        DeleteObject(data.entity)
    end)
end)

-- Processing station interaction
local processingLocation = vector3(5329.55, -5270.93, 33.19)

-- Blip on the map for the processing location
CreateThread(function()
    local blip = AddBlipForCoord(processingLocation)
    SetBlipSprite(blip, 514)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Coca Processing")
    EndTextCommandSetBlipName(blip)
end)

-- Marker for the processing location
CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed)
        local dist = #(playerPos - processingLocation)

        if dist < 20.0 then
            DrawMarker(2, processingLocation.x, processingLocation.y, processingLocation.z - 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, false, 2, true, nil, nil, false)
        end

        if dist < 2.0 then
            DrawText3D(processingLocation.x, processingLocation.y, processingLocation.z + 1.0, "DO NOT COME HERE AND PUSH E IT WIL EAT ALL YOUR COCALEAFS", 255, 0, 0)

            if IsControlJustReleased(0, 38) then -- E key
                TriggerServerEvent('qb-cokeplant:server:ProcessCocaLeaves')
            end
        end

        Wait(0)
    end
end)

-- Spawn the plants when the resource starts
CreateThread(function()
    SpawnPlants()
end)

-- Function to draw 3D text
function DrawText3D(x, y, z, text, r, g, b)
    SetDrawOrigin(x, y, z, 0)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(r, g, b, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end