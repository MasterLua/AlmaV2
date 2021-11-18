resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/index.html'

client_scripts {
    'client/main.lua',
}

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/reset.css',
    'html/img/*.png'
}

export 'openLockpick'
export 'startWelcomeLogos'
export 'startnewLogo'
export 'removeAllWelcomeLogos'

this_is_a_map 'yes'