fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'www.dragonhive.co.uk/fivem/'
description 'Scene Menu 2.0 is the new and more importantly, improved, iteration of Scene Menu. This resource allows you to control the flow of traffic with ease!'
version '2.0.0'

data_file 'DLC_ITYP_REQUEST' 'stream/tape/policetape.ytyp'

escrow_ignore {
    'config.lua', 
}

client_scripts {
    -- RageUI
    'src/RageUI.lua',
    'src/Menu.lua',
    'src/MenuController.lua',
    'src/components/*.lua',
    'src/elements/*.lua',
    'src/items/*.lua',
    -- Mod files
    'config.lua',
    'Client/nodeEdit.lua',
    'Client/trafficZone.lua',
    'Client/pedControl.lua',
    'Client/propSpawn.lua',
    'main_menu.lua'
    
}

server_script 'server.lua'