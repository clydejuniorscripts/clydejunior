Config = {}

Config.UseQBCore = true -- Use QBCore Framework

Config.UseCustomNotify = false -- Use a custom notification script, must complete event below.

-- Only complete this event if Config.UseCustomNotify is true; mythic_notification provided as an example
RegisterNetEvent('angelicxs-randombox:CustomNotify')
AddEventHandler('angelicxs-randombox:CustomNotify', function(message, type)
    --exports.mythic_notify:SendAlert(type, message, 4000)
end)

Config.Tier1Name = 'tier1giftbox' -- Renamed to Daily Gift
Config.Tier2Name = 'tier2giftbox' -- Name of T2 Gift Box
Config.Tier3Name = 'tier3giftbox' -- Name of T3 Gift Box

Config.CrateList = {
    { name = 'goldbar', amount = 4, chance = 100 },
    { name = 'diamond', amount = 4, chance = 20 },
    -- added items
    { name = 'cokebaggy', amount = 6, chance = 50 },
    { name = 'weapon_parts', amount = 2, chance = 50 },
    { name = 'steel', amount = 12, chance = 50 },
    { name = 'tosti', amount = 12, chance = 50 },
    { name = 'sapphire_earring_silver', amount = 6, chance = 50 },
    { name = 'sapphire_necklace_silver', amount = 6, chance = 50 },
    { name = 'sapphire_ring_silver', amount = 6, chance = 50 },
    { name = 'silver_ring', amount = 6, chance = 50 },
    { name = 'ruby_necklace_silver', amount = 1, chance = 50 },
    { name = 'weapon_switchblade', amount = 1, chance = 50 },
    { name = 'weapon_crowbar', amount = 1, chance = 50 },
    { name = 'pistol_ammo', amount = 1, chance = 50 },
    { name = 'pistol_extendedclip', amount = 1, chance = 50 },
    { name = 'iron', amount = 1, chance = 50 },
    { name = 'metalscrap', amount = 1, chance = 50 },
    { name = 'kurkakola', amount = 1, chance = 50 },
    { name = 'coffee', amount = 1, chance = 50 },
    { name = 'joint', amount = 1, chance = 50 },
    { name = 'cloth', amount = 6, chance = 50 },
    { name = 'bandage', amount = 4, chance = 50 },
    { name = 'repairkit', amount = 2, chance = 50 },
    { name = '10kgoldchain', amount = 1, chance = 50 },
    { name = 'diamond_ring', amount = 1, chance = 50 },
    { name = 'goldchain', amount = 1, chance = 50 },
    { name = 'smg_ammo', amount = 1, chance = 50 },
    { name = 'lockpick', amount = 1, chance = 50 },
    { name = 'kidnapbag', amount = 1, chance = 50 },
    { name = 'weapon_vintagepistol', amount = 1, chance = 50 },
    { name = 'electronickit', amount = 1, chance = 50 },
    { name = 'burnerphone', amount = 1, chance = 50 },
    { name = 'simcard', amount = 1, chance = 50 },
    { name = 'goldbar', amount = 1, chance = 50 },
    { name = 'crack_baggy', amount = 1, chance = 50 },
    { name = 'cocaine_bag', amount = 1, chance = 50 },
    { name = 'coke_small_brick', amount = 1, chance = 50 },
    { name = 'sim', amount = 1, chance = 50 },
    { name = 'coke_brick', amount = 1, chance = 50 },
    { name = 'weed_brick', amount = 1, chance = 50 },
    { name = 'printer', amount = 1, chance = 50 },
    { name = 'msr', amount = 1, chance = 50 },
    { name = 'laptop', amount = 1, chance = 50 },
    { name = 'cryptostick', amount = 1, chance = 50 },
    { name = 'lockedchest', amount = 1, chance = 50 },
    { name = 'mg_ammo', amount = 6, chance = 50 },
    { name = 'pistol_ammo', amount = 6, chance = 50 },
    { name = 'lockedcrate', amount = 1, chance = 50 },
    { name = 'cratekey', amount = 1, chance = 50 },
    { name = 'weapon_smg', amount = 1, chance = 50 },
    { name = 'weapon_revolver', amount = 1, chance = 50 },
    { name = 'weapon_tecpistol', amount = 1, chance = 50 },
    { name = 'weapon_pumpshotgun_mk2', amount = 1, chance = 50 },
    { name = 'bpgusenberg', amount = 1, chance = 1 },
    { name = 'weapon_heavypistol', amount = 1, chance = 50 },
    { name = 'bpcompactrifle', amount = 1, chance = 1 },
    { name = 'bpassaultrifle', amount = 1, chance = 1 },
    { name = 'p90_bp', amount = 1, chance = 1 },
    { name = 'draco_bp', amount = 1, chance = 1 },
    { name = 'mpx_bp', amount = 1, chance = 1},
    { name = 'mp5_bp', amount = 1, chance = 1 },
    { name = 'mac_10bp', amount = 1, chance = 1 },
    { name = 'uzi_bp', amount = 1, chance = 1 },
    { name = 'tech_9bp', amount = 1, chance = 1 },
    { name = 'thompson_bp', amount = 1, chance = 1},
    { name = 'm4_bp', amount = 1, chance = 1 },
    { name = 'ak_15bp', amount = 1, chance = 1},
    { name = 'ak_47bp', amount = 1, chance = 1 },
    { name = 'xtcbaggy', amount = 1, chance = 1 },
    { name = 'weed_brick', amount = 1, chance = 1 },
    { name = 'coke_brick', amount = 1, chance = 50 },
    { name = 'coke_small_brick', amount = 1, chance = 50 },
    { name = 'oxy', amount = 1, chance = 50 },
}

Config.ChestList = {
    { name = 'silver_ring', amount = 1, chance = 100 },
    { name = 'goldchain', amount = 1, chance = 50 },
    { name = 'diamond_ring', amount = 1, chance = 50 },
    { name = 'rolex', amount = 1, chance = 50 },
    { name = '10kgoldchain', amount = 1, chance = 50 },
    { name = 'uncut_emerald', amount = 1, chance = 50 },
    { name = 'uncut_ruby', amount = 1, chance = 50 },
    { name = 'uncut_diamond', amount = 1, chance = 50 },
    { name = 'uncut_sapphire', amount = 1, chance = 50 },
    { name = 'emerald', amount = 1, chance = 50 },
    { name = 'ruby', amount = 1, chance = 50 },
    { name = 'diamond', amount = 1, chance = 50 },
    { name = 'sapphire', amount = 1, chance = 50 },
    { name = 'gold_ring', amount = 1, chance = 50 },
    { name = 'ruby_ring', amount = 1, chance = 50 },
    { name = 'sapphire_ring', amount = 1, chance = 50 },
    { name = 'emerald_ring', amount = 1, chance = 50 },
    { name = 'silver_ring', amount = 1, chance = 50 },
    { name = 'diamond_ring_silver', amount = 1, chance = 50 },
    { name = 'ruby_ring_silver', amount = 1, chance = 50 },
    { name = 'sapphire_ring_silver', amount = 1, chance = 50 },
    { name = 'emerald_ring_silver', amount = 1, chance = 50 },
    { name = 'diamond_necklace', amount = 1, chance = 50 },
    { name = 'ruby_necklace', amount = 1, chance = 50 },
    { name = 'sapphire_necklace', amount = 1, chance = 50 },
    { name = 'emerald_necklace', amount = 1, chance = 50 },
    { name = 'silverchain', amount = 1, chance = 50 },
    { name = 'diamond_necklace_silver', amount = 1, chance = 50 },
    { name = 'ruby_necklace_silver', amount = 1, chance = 50 },
    { name = 'sapphire_necklace_silver', amount = 1, chance = 50 },
    { name = 'emerald_necklace_silver', amount = 1, chance = 50 },
    { name = 'goldearring', amount = 1, chance = 50 },
    { name = 'diamond_earring', amount = 1, chance = 50 },
    { name = 'ruby_earring', amount = 1, chance = 50 },
    { name = 'sapphire_earring', amount = 1, chance = 50 },
    { name = 'emerald_earring', amount = 1, chance = 50 },
    { name = 'silverearring', amount = 1, chance = 50 },
    { name = 'diamond_earring_silver', amount = 1, chance = 50 },
    { name = 'ruby_earring_silver', amount = 1, chance = 50 },
    { name = 'sapphire_earring_silver', amount = 1, chance = 50 },
    { name = 'emerald_earring_silver', amount = 1, chance = 50 },
    { name = 'diamond_necklace_silver', amount = 1, chance = 50 },
    { name = 'emerald_ring', amount = 1, chance = 50 },
    { name = 'diamond_necklace', amount = 1, chance = 50 },
    { name = 'ruby_necklace', amount = 1, chance = 50 },
    { name = 'sapphire_necklace', amount = 1, chance = 50 },
    { name = 'emerald_necklace', amount = 1, chance = 50 },
    { name = 'silverchain', amount = 1, chance = 50 },
    { name = 'diamond_necklace_silver', amount = 1, chance = 50 },
    { name = 'ruby_necklace_silver', amount = 1, chance = 50 },
    { name = 'sapphire_necklace_silver', amount = 1, chance = 50 },
    { name = 'emerald_necklace_silver', amount = 1, chance = 50 },
    { name = 'goldearring', amount = 1, chance = 50 },
    { name = 'diamond_earring', amount = 1, chance = 50 },
    { name = 'ruby_earring', amount = 1, chance = 50 },
    { name = 'sapphire_earring', amount = 1, chance = 50 },
    { name = 'emerald_earring', amount = 1, chance = 50 },
    { name = 'silverearring', amount = 1, chance = 50 },
    { name = 'diamond_earring_silver', amount = 1, chance = 50 },
    { name = 'ruby_earring_silver', amount = 1, chance = 50 },
    { name = 'sapphire_earring_silver', amount = 1, chance = 50 },
    { name = 'emerald_earring_silver', amount = 1, chance = 50 },
    { name = 'diamond_necklace_silver', amount = 1, chance = 50 },
}


Config.CrateAmount = 1
Config.ChestAmount = 1

-- Model info: https://docs.fivem.net/docs/game-references/ped-models/
-- Blip info: https://docs.fivem.net/docs/game-references/blips/
-- In Game Preference
Config.PurchaseBox = true -- Allow players to buy gift boxes in game
Config.PurchaseBoxLocation = {159.89, -565.74, 43.89, 77.08} -- Location where players can buy boxes if Config.PurchaseBox = true
Config.InstantOpen = false -- If true will not give box item and instead immediately reward player.
Config.NPC = 's_f_m_shop_high' -- Model of NPC
Config.NPCScenario = 'WORLD_HUMAN_GUARD_STAND' -- Scenario NPC is doing

-- Blip Config
Config.BoxBlip = true -- Enable Blip for location
Config.BoxBlipIcon = 304 -- Starting blip icon (if Config.BoxBlip = true)
Config.BoxBlipColour = 61 -- Colour of blip icon (if Config.BoxBlip = true)
Config.BoxBlipText = 'Mystery Box Seller' -- Blip text on map (if Config.BoxBlip = true)

-- Pricing
Config.AllowTier1 = true -- Allow purchase of a Tier 1 box
Config.Tier1Price = 0 -- Tier 1 gift is free
Config.AllowTier2 = true -- Allow purchase of a Tier 2 box
Config.Tier2Price = 50000 -- How much for a Tier 2 box
Config.AllowTier3 = true -- Allow purchase of a Tier 3 box
Config.Tier3Price = 100000 -- How much for a Tier 3 box

-- General loot per box
Config.AllowGeneralLoot = true -- Allow boxes to pull from Config.GeneralLoot to provide more items per box
Config.Tier1Amount = 1 -- if Config.AllowGeneralLoot = true how many items from Config.GeneralLoot are added to a Tier 1 box
Config.Tier2Amount = 2 -- if Config.AllowGeneralLoot = true how many items from Config.GeneralLoot are added to a Tier 2 box
Config.Tier3Amount = 2 -- if Config.AllowGeneralLoot = true how many items from Config.GeneralLoot are added to a Tier 3 box

-- Visual Preference
Config.UseThirdEye = true -- Enables using a third eye [REQUIRED]
Config.ThirdEyeName = 'qb-target' -- Name of third eye application
Config.ThirdEyeIcon = 'fas fa-clipboard-list' -- Icon beside options (fas awesome)

-- Rewards Configuration (must have at least 1 item in each tier 100% chance)
Config.Tier1List = {
    { name = 'cokebaggy', amount = 2, chance = 15},
    { name = 'weapon_parts', amount = 1, chance = 15},
    { name = 'steel', amount = 4, chance = 25},
    { name = 'tosti', amount = 4, chance = 25},
    { name = 'sapphire_earring_silver', amount = 1, chance = 30},
    { name = 'sapphire_necklace_silver', amount = 1, chance = 25},
    { name = 'sapphire_ring_silver', amount = 1, chance = 35},
    { name = 'silver_ring', amount = 1, chance = 50},
    { name = 'ruby_necklace_silver', amount = 1, chance = 25},
    { name = 'weapon_switchblade', amount = 1, chance = 5},
    { name = 'weapon_crowbar', amount = 1, chance = 25},
    { name = 'pistol_ammo', amount = 2, chance = 25},
    { name = 'iron', amount = 4, chance = 25},
    { name = 'metalscrap', amount = 4, chance = 35},
    { name = 'coffee', amount = 1, chance = 35},
    { name = 'joint', amount = 1, chance = 35},
    { name = 'supligen', amount = 2, chance = 35},
    { name = 'bandage', amount = 2, chance = 35},
    { name = 'repairkit', amount = 1, chance = 50},
    { name = '10kgoldchain', amount = 1, chance = 35},
    { name = 'diamond_ring', amount = 1, chance = 35},
    { name = 'goldchain', amount = 1, chance = 35},
    { name = 'xtcbaggy', amount = 1, chance = 1},
    { name = 'oxy', amount = 1, chance = 1},
}

Config.Tier2List = {
    {name = 'smg_ammo', amount = 4, chance = 35},
    {name = 'lockpick', amount = 6, chance = 60},
    {name = 'weapon_vintagepistol', amount = 1, chance = 5},
    {name = 'electronickit', amount = 1, chance = 35},
    {name = 'iron', amount = 12, chance = 35},
    {name = 'goldbar', amount = 12, chance = 20},
    {name = 'crack_baggy', amount = 6, chance = 50},
    {name = 'coke', amount = 6, chance = 2},
    {name = 'xtcbaggy', amount = 1, chance = 1},
    {name = 'oxy', amount = 1, chance = 5},
}

Config.Tier3List = {
    {name = 'bandage', amount = 1, chance = 35},
    {name = 'weed_brick', amount = 1, chance = 35},
    {name = 'mg_ammo', amount = 12, chance = 10},
    {name = 'smg_ammo', amount = 12, chance = 10},
    {name = 'pistol_ammo', amount = 24, chance = 10},
    {name = 'steel', amount = 12, chance = 10},
    {name = 'meth', amount = 12, chance = 10},
    {name = 'cryptostick', amount = 1, chance = 5},
    {name = 'weapon_smg', amount = 1, chance = 1},
    {name = 'weapon_revolver', amount = 1, chance = 1},
    {name = 'weapon_tecpistol', amount = 1, chance = 1},
    {name = 'weapon_pumpshotgun_mk2', amount = 1, chance = 1},
    {name = 'weapon_microsmg', amount = 1, chance = 1},
    {name = 'weapon_heavypistol', amount = 1, chance = 1},
    {name = 'p90_bp', amount = 1, chance = 1},
    {name = 'draco_bp', amount = 1, chance = 1},
    {name = 'mpx_bp', amount = 1, chance = 1},
    {name = 'mp5_bp', amount = 1, chance = 1},
    {name = 'mac_10bp', amount = 1, chance = 1},
    {name = 'uzi_bp', amount = 1, chance = 1},
    {name = 'tech_9bp', amount = 1, chance = 1},
    {name = 'thompson_bp', amount = 1, chance = 1},
    {name = 'm4_bp', amount = 1, chance = 1},
    {name = 'ak_15bp', amount = 1, chance = 1},
    {name = 'ak_47bp', amount = 1, chance = 1},
    {name = 'xtcbaggy', amount = 1, chance = 1},
    {name = 'weed_brick', amount = 1, chance = 1},
    {name = 'coke_brick', amount = 1, chance = 1},
    {name = 'coke_small_brick', amount = 1, chance = 1},
    {name = 'oxy', amount = 1, chance = 5},
}


Config.GeneralLoot = {
    {name = 'cokebaggy', amount = 1},
    {name = 'weapon_parts', amount = 1},
    {name = 'steel', amount = 1},
    {name = 'tosti', amount = 1},
    {name = 'sapphire_earring_silver', amount = 1},
    {name = 'sapphire_necklace_silver', amount = 1},
    {name = 'sapphire_ring_silver', amount = 1},
    {name = 'silver_ring', amount = 1},
    {name = 'ruby_necklace_silver', amount = 1},
    {name = 'weapon_switchblade', amount = 1},
    {name = 'weapon_crowbar', amount = 1},
    {name = 'pistol_ammo', amount = 1},
    {name = 'pistol_extendedclip', amount = 1},
    {name = 'iron', amount = 1},
    {name = 'metalscrap', amount = 1},
    {name = 'kurkakola', amount = 1},
    {name = 'coffee', amount = 1},
    {name = 'joint', amount = 1},
    {name = 'cloth', amount = 6},
    {name = 'bandage', amount = 4},
    {name = 'repairkit', amount = 2},
    {name = '10kgoldchain', amount = 1},
    {name = 'diamond_ring', amount = 1},
    {name = 'goldchain', amount = 1},
    {name = 'smg_ammo', amount = 1},
    {name = 'lockpick', amount = 1},
    {name = 'kidnapbag', amount = 1},
    {name = 'weapon_vintagepistol', amount = 1},
    {name = 'electronickit', amount = 1},
    {name = 'burnerphone', amount = 1},
    {name = 'simcard', amount = 1},
    {name = 'goldbar', amount = 1},
    {name = 'crack_baggy', amount = 1},
    {name = 'cocaine_bag', amount = 1},
    {name = 'coke_small_brick', amount = 1},
    {name = 'sim', amount = 1},
    {name = 'coke_brick', amount = 1},
    {name = 'weed_brick', amount = 1},
    {name = 'printer', amount = 1},
    {name = 'msr', amount = 1},
    {name = 'laptop', amount = 1},
    {name = 'cryptostick', amount = 1},
    {name = 'lockedchest', amount = 1},
    {name = 'mg_ammo', amount = 6},
    {name = 'pistol_ammo', amount = 6},
    {name = 'lockedcrate', amount = 1},
    {name = 'cratekey', amount = 1},
    {name = 'weapon_smg', amount = 1},
    {name = 'weapon_revolver', amount = 1},
    {name = 'weapon_tecpistol', amount = 1},
    {name = 'weapon_pumpshotgun_mk2', amount = 1},
    {name = 'weapon_heavypistol', amount = 1},
    {name = 'xtcbaggy', amount = 1},
    {name = 'weed_brick', amount = 1},
    {name = 'coke_brick', amount = 1},
    {name = 'coke_small_brick', amount = 1},
    {name = 'oxy', amount = 1},
}
   

-- Language Configuration
Config.LangType = {
    ['error'] = 'error',
    ['success'] = 'success',
    ['info'] = 'primary'
}

Config.Lang = {
    ['receive'] = 'You received ',
    ['nofunds'] = 'You do not have enough cash to purchase a box!',
    ['purchase'] = 'You have purchased a mystery box!',
    ['used'] = 'You are opening a mystery box!',
    ['buy_a'] = 'Purchase a Tier ',
    ['buy_b'] = ' mystery box for $',
    ['daily_gift_collected'] = 'You have already collected your daily gift. Please wait ',
    ['time_remaining'] = ' hours before collecting the next gift.',
    ['no_cratekey'] = 'You need a crate key to open this crate!',
    ['no_lockpick'] = 'You need a lockpick to open this chest!',
    ['voucher_used'] = 'You have used the import voucher to redeem a car!',
    ['voucher_already_used'] = 'You can only use one import voucher per month!'
}

Config.DailyGiftCooldown = 6 -- Cooldown period in hours (6 hours)
Config.ImportVoucherUsed = false -- Flag to track if the import voucher has been used in the current month
