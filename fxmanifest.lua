fx_version 'cerulean'
games { 'rdr3', 'gta5' }
author 'ZORGO'
lua54 'on' 
description ' Truck Job'

ui_page 'client/html/ui.html'

files {
    'client/html/*.*',

}

client_scripts {
    'client/Zorgo_Utils.lua',
    'client/Zorgo_Client.lua'
   
}


server_script {
    "server/Zorgo_payout.lua",
    -- "server/Zorgo_Log_System.lua",
}

shared_script '@es_extended/imports.lua'



