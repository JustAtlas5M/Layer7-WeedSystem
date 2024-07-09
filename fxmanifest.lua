fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'Droghe'

author 'Layer7'

discord '0xx01' --Entra nel discord lo apprezzo veramente

shared_script "@es_extended/imports.lua"
shared_script '@ox_lib/init.lua'

server_scripts {
    'Config.lua',
    'Server/**.lua',
}

client_scripts {
    'Config.lua',
    'Client/**.lua',
}