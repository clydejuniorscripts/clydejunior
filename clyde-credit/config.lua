-- config.lua

Config = {}

-- Define credit score ranges based on total money
Config.CreditScoreRanges = {
    {min = 0, max = 999999, scoreMin = 300, scoreMax = 579}, -- Bad Credit
    {min = 1000000, max = 199999999, scoreMin = 580, scoreMax = 739}, -- Fair to Good Credit
    {min = 200000000, max = math.huge, scoreMin = 740, scoreMax = 850} -- Very Good to Excellent Credit
}
