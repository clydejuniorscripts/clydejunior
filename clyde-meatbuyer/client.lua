local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for _, value in pairs(Config.MeatLocation) do
        if value.showblip then
            local blip = AddBlipForCoord(value.coords.x, value.coords.y, value.coords.z)
            SetBlipSprite(blip, 431)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.7)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, 5)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName('Meat Buyer')
            EndTextCommandSetBlipName(blip)
        end
    end
end)

CreateThread(function()
    for key, value in pairs(Config.MeatLocation) do
        local model = 'a_m_m_hillbilly_01'
        RequestModel(GetHashKey(model))
        while not HasModelLoaded(GetHashKey(model)) do Wait(1) end

        RequestAnimDict("mini@strip_club@idles@bouncer@base")
        while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
            Wait(1)
        end
        local ped = CreatePed(4, model, value.coords.x, value.coords.y, value.coords.z - 1.0, value.heading, false, true)
        SetEntityHeading(ped, value.heading)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskPlayAnim(ped, "mini@strip_club@idles@bouncer@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)

        CreateThread(function()
            while true do
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local sleep = 1000
                local distance = #(playerCoords - value.coords)
                if distance < 2.0 then
                    sleep = 5
                    DrawText3D(value.coords.x, value.coords.y, value.coords.z + 1.0, 'Press [E] to sell meat')
                    if IsControlJustReleased(0, 38) then
                        TriggerEvent('meatbuyer:client:enterMeatShop', value)
                    end
                end
                Wait(sleep)
            end
        end)
    end
end)

function DrawText3D(x, y, z, text)
    SetDrawOrigin(x, y, z, 0)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

RegisterNetEvent('meatbuyer:client:enterMeatShop', function(data)
    local shopitems = data.items
    local meatShop = {
        {
            header = 'Meat Buyer',
            isMenuHeader = true,
        },
    }

    for _, v in pairs(shopitems) do
        local hasitem = QBCore.Functions.HasItem(v.item)
        if hasitem then
            meatShop[#meatShop + 1] = {
                header = QBCore.Shared.Items[v.item].label,
                txt = 'Selling Price $' .. v.price,
                params = {
                    event = 'meatbuyer:client:sellmeatitems',
                    args = {
                        label = QBCore.Shared.Items[v.item].label,
                        price = v.price,
                        name = v.item,
                    }
                }
            }
        end
    end

    meatShop[#meatShop + 1] = {
        header = '? Go Back',
        params = {
            event = 'meatbuyer:client:closeMenu'
        }
    }
    exports['qb-menu']:openMenu(meatShop)
end)

RegisterNetEvent('meatbuyer:client:closeMenu', function()
    exports['qb-menu']:closeMenu()
end)

RegisterNetEvent('meatbuyer:client:sellmeatitems', function(data)
    QBCore.Functions.TriggerCallback('meatbuyer:server:ItemAmount', function(amount)
        local sellingItem = exports['qb-input']:ShowInput({
            header = "<center><p><img src=nui://"..Config.img..QBCore.Shared.Items[data.name].image.." width=100px></p>"..QBCore.Shared.Items[data.name].label,
            submitText = 'Sell',
            inputs = {
                {
                    type = 'number',
                    isRequired = true,
                    name = 'amount',
                    text = 'Max Amount ' .. amount
                }
            }
        })
        if sellingItem then
            if not sellingItem.amount then
                return
            end

            if tonumber(sellingItem.amount) > 0 then
                TriggerServerEvent('meatbuyer:server:sellMeatItems', data.name, sellingItem.amount, data.price)
            else
                QBCore.Functions.Notify('Trying to sell a negative amount?', 'error')
            end
        end
    end, data.name)
end)
