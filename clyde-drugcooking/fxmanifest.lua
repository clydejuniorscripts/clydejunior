fx_version 'cerulean'
game 'gta5'

author 'clydejunior'
description 'Drug Cooking Script'
version '1.0.0'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

client_scripts {
    'config.lua',
    'client.lua'
}

server_scripts {
    'config.lua',
    'server.lua'
}

dependencies {
    'qb-core',
    'qb-menu',
    'qb-inventory',
    'qb-target'
}
