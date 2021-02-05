fx_version 'cerulean'

game 'gta5'

lua54 'yes'

description 'Personal menu by Project Entity'

version '1.0.3'

client_scripts {
    '@es_extended/locale.lua',
    'locales/es.lua',
    'locales/en.lua',
    'config.lua',
    'client/carry_cl.lua',
    'client/menu_cl.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/es.lua',
    'locales/en.lua',
    'config.lua',
    'server/carry_sv.lua',
    'server/menu_sv.lua'
}
