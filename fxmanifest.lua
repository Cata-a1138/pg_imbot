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
    '@pg_lib/shared.lua',
}

server_scripts {
    'config.lua',
    'source/server.lua'
    'source/kookHandler.lua.'
    'source/qqHandler.lua'
}

files {
    'cards/*.json'
}