--[[ FX Information ]] --
fx_version 'cerulean'
lua54 'yes'
game 'gta5'

--[[ Resource Information ]] --
name 'pg_imbot'
author 'Cata_a <3478600437@qq.com>'
version '1.0.0'

--[[ Manifest ]] --
shared_scripts {
    '@ox_lib/init.lua',
    '@pg_lib/shared.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'source/server.lua',
    'source/api.lua',
    'source/event/QQ.lua',
    'source/event/KOOK.lua',
    'source/classes/txAdmin.lua',
}

files {
    'cards/*.json'
}