-- config.lua
Config = {}

Config.CocaPlantSpots = {
    {5284.81, -5249.41, 30.74},
    {5363.91, -5153.70, 27.39}
}

Config.RandomRadius = 10 -- Random spawn radius around each plant spot
Config.PickTime = 5000
Config.ProcessTime = 20000

Config.RequiredItems = {
    PickTool = "knife"
}

Config.RewardItems = {
    CocaLeaves = "coca_leaf",
    PoppyResin = "poppyresin",
    CocaPaste = "coca_paste",
    CocaBrick = "cocaine_brick"
}