fx_version 'cerulean'

game 'gta5'

lua54 'yes'

description 'Personal menu by Project Entity'

version '0.2.0'

shared_script {
    'config.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/es.lua',
    'locales/en.lua',
    'client/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/es.lua',
    'locales/en.lua',
    'server/*.lua'
}

dependencies {
    'jsfour-license'
}
