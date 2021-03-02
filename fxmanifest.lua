fx_version 'cerulean'

game 'gta5'

lua54 'yes'

<<<<<<< HEAD
description 'Personal menu by Project Entity (integrated with carry by Rob)'
=======
description 'Personal menu by Project Entity'
>>>>>>> 2c627faf634bf0d5ca2c1e037abc8395d99c03f2

version '0.2.0'

shared_script {
    'config.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/es.lua',
    'locales/en.lua',
    'client/menu_cl.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/es.lua',
    'locales/en.lua',
    'server/menu_sv.lua'
}

dependencies {
<<<<<<< HEAD
    'jsfour-idcard'
}
=======
    'jsfour-license'
}
>>>>>>> 2c627faf634bf0d5ca2c1e037abc8395d99c03f2
