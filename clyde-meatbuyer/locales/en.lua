local Translations = {
    error = {
        negative = 'Trying to sell a negative amount?',
        no_items = 'Not enough items',
    },
    success = {
        sold = 'You have sold %{value} x %{value2} for $%{value3}',
        profit_received = 'You received $%{value} as your profit share',
    },
    info = {
        title = 'Meat Buyer',
        open_meat_shop = 'Press [E] to sell meat',
        sell_items = 'Selling Price $%{value}',
        back = '? Go Back',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
