Config = {}

Config.CokeBrickProcessing = {
    Ingredients = {coke_brick = 1}, -- Amount of Coke Brick Needed per unit
    Reward = {cokebaggy = 24}, -- Amount of Cocaine Received per unit
    ProcessingTime = 30 * 1000 -- Processing time in milliseconds (15 seconds)
}

Config.SmallCokeBrickProcessing = {
    Ingredients = {coke_small_brick = 1}, -- Amount of Small Coke Brick Needed per unit
    Reward = {cokebaggy = 12}, -- Amount of Cocaine Received per unit
    ProcessingTime = 30 * 1000 -- Processing time in milliseconds (15 seconds)
}

Config.CartelBrickProcessing = {
    Ingredients = {cartelbrick = 1}, -- Amount of Cartel Brick Needed per unit
    Reward = {coke = 16}, -- Amount of Cocaine Received per unit
    ProcessingTime = 30 * 1000 -- Processing time in milliseconds (15 seconds)
}

Config.MethProcessing = {
    Ingredients = {methtray = 1}, -- Amount of Meth Tray Needed per unit
    Reward = {meth = 4}, -- Amount of Meth Received per unit
    ProcessingTime = 30 * 1000 -- Processing time in milliseconds (15 seconds)
}

Config.WeedBrickProcessing = {
    Ingredients = {weed_brick = 1}, -- Amount of Weed Brick Needed per unit
    Reward = {weed_ak47 = 24}, -- Amount of Weed AK47 Received per unit
    ProcessingTime = 30 * 1000 -- Processing time in milliseconds (15 seconds)
}

-- Update the location here
Config.ProcessingLabLocation = {
    pos = vector3(2526.80, 4114.65, 38.63), -- New Coordinates for the processing table
    radius = 0.5,
    polyOptions = {minZ = 39.69, maxZ = 41.69} -- Adjust Z values as needed
}
