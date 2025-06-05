-- Config.lua
Config = {}

Config.MethProcessing = {
    Ingredients = {
        hydrochloric_acid = 3,
        sodium_hydroxide = 3,
        sulfuric_acid = 3
    },
    Reward = {methtray = 1},
    CookingTime = 1 * 60 * 1000,
    ExplosionChance = 50
}

Config.HeroinProcessing = {
    Ingredients = {poppyresin = 24},
    Reward = {heroin = 12},
    CookingTime = 2 * 60 * 1000,
    ExplosionChance = 100
}

Config.CrackProcessing = {
    Ingredients = {coke_small_brick = 1, bakingsoda = 6, water_bottle = 3},
    Reward = {crack_baggy = 12},
    CookingTime = 3 * 60 * 1000,
    ExplosionChance = 50
}

Config.CokeProcessing = {
    Ingredients = {
        coca_leaf = 24,
        coca_paste = 12
    },
    Reward = {coke_brick = 1},
    CookingTime = 3 * 60 * 1000,
    ExplosionChance = 50
}

Config.CookingLabLocation = {
    pos = vector3(1389.86, 3608.74, 38.94),
    radius = 2.0,
    polyOptions = {minZ = 39.69, maxZ = 41.69}
}

Config.PoliceAlert = true