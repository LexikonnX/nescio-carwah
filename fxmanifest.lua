fx_version 'cerulean'
games 'gta5'

description "Garages by Lexikonn"

client_scripts {
    'client.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}
