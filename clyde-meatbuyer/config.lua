Config = {}

Config.img = "qb-inventory/html/images/" -- Images location in your inventory
Config.UseTarget = false
Config.BankMoney = false -- Set to true if you want the money to go into the player's bank
Config.MeatLocation = {
    [1] = {
        coords = vector3(323.08, -2111.73, 18.12),
        length = 1.0,
        width = 1.0,
        heading = -170.0,
        debugPoly = false,
        distance = 20.0,
        showblip = false,
        items = {
            [1] = {item = 'zombie_arm', price = math.random(1000, 2000)},
            [2] = {item = 'zombie_brain', price = math.random(1000, 5000)},
            [3] = {item = 'zombie_foot', price = math.random(1000, 2000)},
            [4] = {item = 'zombie_heart', price = math.random(1000, 2000)},
            [5] = {item = 'zombie_lungs', price = math.random(1000, 2000)},
        }
    }
}
