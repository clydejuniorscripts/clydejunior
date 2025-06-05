local QBCore = exports['qb-core']:GetCoreObject()

local NPC
local openingAnim = false
local packageObject

RegisterNetEvent('angelicxs-randombox:Notify', function(message, type)
    if Config.UseCustomNotify then
        TriggerEvent('angelicxs-randombox:CustomNotify', message, type)
    else
        QBCore.Functions.Notify(message, type)
    end
end)

RegisterNetEvent('angelicxs-randombox:ShowItem', function(itemName, itemAmount)
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[itemName], "add")
end)

CreateThread(function()
    if Config.BoxBlip then
        local blip = AddBlipForCoord(Config.PurchaseBoxLocation[1], Config.PurchaseBoxLocation[2], Config.PurchaseBoxLocation[3])
        SetBlipSprite(blip, Config.BoxBlipIcon)
        SetBlipColour(blip, Config.BoxBlipColour)
        SetBlipScale(blip, 0.7)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(Config.BoxBlipText)
        EndTextCommandSetBlipName(blip)
    end
end)

-- Starting NPC Spawn
CreateThread(function()
    if Config.PurchaseBox then
        local PedSpawned = false
        while true do
            local Player = PlayerPedId()
            local Pos = GetEntityCoords(Player)
            local Dist = #(Pos - vector3(Config.PurchaseBoxLocation[1], Config.PurchaseBoxLocation[2], Config.PurchaseBoxLocation[3]))
            if Dist <= 50 and not PedSpawned then
                TriggerEvent('angelicxs-randombox:SpawnNPC', Config.PurchaseBoxLocation, Config.NPC, Config.NPCScenario)
                PedSpawned = true
            elseif DoesEntityExist(NPC) and PedSpawned then
                local Dist2 = #(Pos - GetEntityCoords(NPC))
                if Dist2 > 50 then
                    DeleteEntity(NPC)
                    PedSpawned = false
                end
            end
            Wait(2000)
        end
    end
end)

RegisterNetEvent('angelicxs-randombox:SpawnNPC', function(coords, model, scenario)
    local hash = HashGrabber(model)
    NPC = CreatePed(3, hash, coords[1], coords[2], (coords[3] - 1), coords[4], false, false)
    FreezeEntityPosition(NPC, true)
    SetEntityInvincible(NPC, true)
    SetBlockingOfNonTemporaryEvents(NPC, true)
    TaskStartScenarioInPlace(NPC, scenario, 0, false)
    SetModelAsNoLongerNeeded(model)
    if Config.UseThirdEye then
        if Config.ThirdEyeName == 'ox_target' then
            local ox_options = {
                {
                    icon = Config.ThirdEyeIcon,
                    label = 'Collect your Daily Gift',
                    canInteract = function(entity)
                        return true
                    end,
                    onSelect = function(entity)
                        TriggerServerEvent('angelicxs-randombox:server:GetDailyGift')
                    end,
                },
                {
                    icon = Config.ThirdEyeIcon,
                    label = Config.Lang['buy_a'] .. '2' .. Config.Lang['buy_b'] .. Config.Tier2Price,
                    canInteract = function(entity)
                        if not Config.AllowTier2 then return false end
                        return true
                    end,
                    onSelect = function(entity)
                        TriggerServerEvent('angelicxs-randombox:server:GetMoney', Config.Tier2Price)
                    end,
                },
                {
                    icon = Config.ThirdEyeIcon,
                    label = Config.Lang['buy_a'] .. '3' .. Config.Lang['buy_b'] .. Config.Tier3Price,
                    canInteract = function(entity)
                        if not Config.AllowTier3 then return false end
                        return true
                    end,
                    onSelect = function(entity)
                        TriggerServerEvent('angelicxs-randombox:server:GetMoney', Config.Tier3Price)
                    end,
                }
            }
            exports.ox_target:addLocalEntity(NPC, ox_options)
        else
            exports[Config.ThirdEyeName]:AddEntityZone('GiftNPC', NPC, {
                name = "GiftNPC",
                debugPoly = false,
                useZ = true
            }, {
                options = {
                    {
                        icon = Config.ThirdEyeIcon,
                        label = 'Collect your Daily Gift',
                        canInteract = function(entity)
                            return true
                        end,
                        action = function(entity)
                            TriggerServerEvent('angelicxs-randombox:server:GetDailyGift')
                        end,
                    },
                    {
                        icon = Config.ThirdEyeIcon,
                        label = Config.Lang['buy_a'] .. '2' .. Config.Lang['buy_b'] .. Config.Tier2Price,
                        canInteract = function(entity)
                            if not Config.AllowTier2 then return false end
                            return true
                        end,
                        action = function(entity)
                            TriggerServerEvent('angelicxs-randombox:server:GetMoney', Config.Tier2Price)
                        end,
                    },
                    {
                        icon = Config.ThirdEyeIcon,
                        label = Config.Lang['buy_a'] .. '3' .. Config.Lang['buy_b'] .. Config.Tier3Price,
                        canInteract = function(entity)
                            if not Config.AllowTier3 then return false end
                            return true
                        end,
                        action = function(entity)
                            TriggerServerEvent('angelicxs-randombox:server:GetMoney', Config.Tier3Price)
                        end,
                    }
                },
                distance = 2
            })
        end
    end
end)

function HashGrabber(model)
    local hash = GetHashKey(model)
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
        Wait(10)
    end
    return hash
end

function animationIntro()
    if IsPedInAnyVehicle(PlayerPedId(), false) then 
        QBCore.Functions.Notify("You can not do this right now.", 'error')
        return false
    end

    openingAnim = true
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    Wait(500)

    while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
        RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
        Wait(1)
    end

    local prop = GetHashKey("v_ret_box")
    while not HasModelLoaded(prop) do
        RequestModel(prop)
        Wait(10)
    end

    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    packageObject = CreateObject(prop, playerPos.x, playerPos.y, playerPos.z - 1.00001, true, false, false)
    AttachEntityToEntity(packageObject, playerPed, GetPedBoneIndex(playerPed, 26610), 0.0, 0.0, -0.15, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 0)
    SetModelAsNoLongerNeeded(prop)
    TaskPlayAnim(playerPed, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 2.0, -1, 1, 0, 0, 0, 0)
    return true
end

function animationOutro()
    local playerPed = PlayerPedId()
    StopAnimTask(playerPed, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
    DetachEntity(packageObject, 1, 1)
    DeleteEntity(packageObject)
    RemoveAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
    openingAnim = false
end

RegisterNetEvent('angelicxs-randombox:client:OpenBox', function(tier)
    if openingAnim then
        QBCore.Functions.Notify("You can not do this right now.", 'error')
        return
    end

    if animationIntro() then
        Wait(4000)  -- Wait for the animation to complete
        TriggerServerEvent('angelicxs-randombox:server:OpenBox', tier)
        animationOutro()
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() == resource then
        if DoesEntityExist(NPC) then
            DeleteEntity(NPC)
        end
    end
end)
