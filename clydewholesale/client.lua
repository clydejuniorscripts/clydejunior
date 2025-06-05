local QBCore = exports['qb-core']:GetCoreObject() -- Ensure QBCore is initialized

local TRClassicBlackMarketPed
local itemCheck = Config.ItemCheck

-- Function to check if the player has the required item
local function hasRequiredItem()
    local PlayerData = QBCore.Functions.GetPlayerData()
    print("Checking player items for required licenses...")
    for _, item in pairs(PlayerData.items) do
        print("Player has item:", item.name)
        for _, requiredItem in pairs(Config.RequiredItems) do
            print("Checking against required item:", requiredItem)
            if item.name == requiredItem then
                print("Player has required item:", requiredItem)
                return true
            end
        end
    end
    print("Player does not have required items.")
    return false
end

local function RemoveTRPed()
    if DoesEntityExist(TRClassicBlackMarketPed) then
        DeletePed(TRClassicBlackMarketPed)
        print("Ped removed.")
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        RemoveTRPed()
    end
end)

CreateThread(function()
    if Config.UseBlip then
        local BlackMarketBlip = AddBlipForCoord(Config.Location.Coords)
        SetBlipSprite(BlackMarketBlip, Config.Location.SetBlipSprite)
        SetBlipDisplay(BlackMarketBlip, Config.Location.SetBlipDisplay)
        SetBlipScale(BlackMarketBlip, Config.Location.SetBlipScale)
        SetBlipAsShortRange(BlackMarketBlip, true)
        SetBlipColour(BlackMarketBlip, Config.Location.SetBlipColour)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Location.BlipName)
        EndTextCommandSetBlipName(BlackMarketBlip)
        print("Blip created.")
    end

    local Coords = Config.Location.Coords
    local PedHash = Config.Location.ModelHash
    local PedModel = Config.Location.ModelName

    if not DoesEntityExist(TRClassicBlackMarketPed) then
        RequestModel(GetHashKey(PedModel))
        while not HasModelLoaded(GetHashKey(PedModel)) do
            Wait(1)
        end

        TRClassicBlackMarketPed = CreatePed(1, PedHash, Coords, false, true)
        FreezeEntityPosition(TRClassicBlackMarketPed, true)
        SetEntityInvincible(TRClassicBlackMarketPed, true)
        SetBlockingOfNonTemporaryEvents(TRClassicBlackMarketPed, true)
        print("NPC created at: ", Coords)
    else
        print("NPC already exists.")
    end

    local function canInteract(entity)
        local canInteract = not IsPedDeadOrDying(entity, true) and not IsPedAPlayer(entity) and not IsPedInAnyVehicle(PlayerPedId(), false) and hasRequiredItem()
        print("Can interact check:", canInteract)
        return canInteract
    end

    exports['qb-target']:AddTargetEntity(TRClassicBlackMarketPed, {
        options = {
            {
                num = 1,
                type = "client",
                event = "clydewholesale:OpenShop",
                label = Config.Text["TargetLabel"],
                icon = Config.Icons["EyeIcon"],
                canInteract = canInteract,
            }
        },
        distance = 1.5
    })
    print("Target entity added.")
end)

RegisterNetEvent('clydewholesale:OpenShop', function()
    if hasRequiredItem() then
        local BlackMarket = {
            { header = Config.Text['PedHeader'], isMenuHeader = true, icon = Config.Icons["Header"] },
            { header = Config.Text['EatItems'], icon = Config.Icons['EatItems'], params = { event = "clydewholesale:EatShop" } },
            { header = Config.Text['DrinkItems'], icon = Config.Icons['DrinkItems'], params = { event = "clydewholesale:DrinkShop" } },
            { header = Config.Text['Alcohol'], icon = Config.Icons['Alcohol'], params = { event = "clydewholesale:AlcoholShop" } },
            { header = Config.Text['TacoFood'], icon = Config.Icons['TacoFood'], params = { event = "clydewholesale:TacoFoodShop" } },
            { header = Config.Text['TacoDrinks'], icon = Config.Icons['TacoDrinks'], params = { event = "clydewholesale:TacoDrinksShop" } },
            { header = Config.Text['Ingredients'], icon = Config.Icons['Ingredients'], params = { event = "clydewholesale:IngredientsShop" } },
            { header = Config.Text['BurgerShot'], icon = Config.Icons['BurgerShot'], params = { event = "clydewholesale:BurgerShotShop" } },
            { header = Config.Text['BBQ'], icon = Config.Icons['BBQ'], params = { event = "clydewholesale:BBQShop" } },
            { header = Config.Text['JamaicanDrinks'], icon = Config.Icons['JamaicanDrinks'], params = { event = "clydewholesale:JamaicanDrinksShop" } },
            { header = Config.Text['JamaicanFood'], icon = Config.Icons['JamaicanFood'], params = { event = "clydewholesale:JamaicanFoodShop" } },
            { header = Config.Text['McDonalds'], icon = Config.Icons['McDonalds'], params = { event = "clydewholesale:McDonaldsShop" } }
        }
        exports['qb-menu']:openMenu(BlackMarket)
    else
        QBCore.Functions.Notify("You do not have the required license.", "error")
    end
end)

-- BlackMarket Shop Events
RegisterNetEvent("clydewholesale:EatShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "market", Config.EatShop)
end)

RegisterNetEvent("clydewholesale:DrinkShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "market", Config.DrinkShop)
end)

RegisterNetEvent("clydewholesale:AlcoholShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "market", Config.AlcoholShop)
end)

RegisterNetEvent("clydewholesale:TacoFoodShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "market", Config.TacoFoodShop)
end)

RegisterNetEvent("clydewholesale:TacoDrinksShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "market", Config.TacoDrinksShop)
end)

RegisterNetEvent("clydewholesale:IngredientsShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "market", Config.IngredientsShop)
end)

RegisterNetEvent("clydewholesale:BurgerShotShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "market", Config.BurgerShotShop)
end)

RegisterNetEvent("clydewholesale:BBQShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "market", Config.BBQShop)
end)

RegisterNetEvent("clydewholesale:JamaicanDrinksShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "market", Config.JamaicanDrinksShop)
end)

RegisterNetEvent("clydewholesale:JamaicanFoodShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "market", Config.JamaicanFoodShop)
end)

RegisterNetEvent("clydewholesale:McDonaldsShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "market", Config.McDonaldsShop)
end)
