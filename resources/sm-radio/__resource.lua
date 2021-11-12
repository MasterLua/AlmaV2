---@diagnostic disable: undefined-global
fx_version "adamant"
game "gta5"

name "sm-radio"
description "A radio for mumble-voip"
author "VacEx"
version "1.2"

client_script {
  'config.lua',
  'client.lua'
}

server_script {
  'config.lua',
  'server.lua'
}

ui_page('html/index.html')

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/assets/radio_on.png',
    'html/assets/radio_off.png',
    'html/assets/click.mp3'
}
