fx_version "cerulean"

game "gta5"

description "ESX_Legacy"

version "legacy"

server_script 'Modules/MySQL/mysql-async.js'
client_script 'Modules/MySQL/mysql-async-client.lua'

ui_page "Modules/speedometer/angular/dist/index.html"

loadscreen 'Modules/loadingscreen/index.html'

files {
	'Modules/loadingscreen/index.html',
    'Modules/loadingscreen/style.css',
    'Modules/loadingscreen/bg/*.png',
    'Modules/loadingscreen/index.html',
    'Modules/loadingscreen/music/load.ogg',
	"Modules/speedometer/angular/dist/index.html",
	"Modules/speedometer/angular/dist/assets/svg/*.svg",
	"Modules/speedometer/angular/dist/assets/fonts/*.ttf",
	"Modules/speedometer/angular/dist/*.js",
	"Modules/speedometer/angular/dist/*.css",
	"Modules/speedometer/angular/dist/*.ttf",
	"Modules/speedometer/angular/dist/*.woff",
	"Modules/speedometer/angular/dist/*.woff2",
	-- 'data/**/carcols.meta',
	-- 'data/**/carvariations.meta',
	-- 'data/**/contentunlocks.meta',
	-- 'data/**/handling.meta',
	-- 'data/**/vehiclelayouts.meta',
	-- 'data/**/vehicles.meta'
}

shared_scripts {
	"Modules/Legacy/locale.lua",
	"Modules/Legacy/locales/fr.lua",
	"Modules/Legacy/locales/en.lua",
	"Modules/Legacy/config.lua",
	"Modules/Legacy/config.weapons.lua",
	"Alma/Shared/*.lua"
}

server_scripts {
	"Modules/Legacy/common/async.lua",
	"Modules/MySQL/lib/MySQL.lua",

	"Modules/Legacy/server/common.lua",
	"Modules/Legacy/server/classes/player.lua",
	"Modules/Legacy/server/functions.lua",
	"Modules/Legacy/server/paycheck.lua",
	"Modules/Legacy/server/main.lua",
	"Modules/Legacy/server/commands.lua",

	"Modules/Legacy/common/modules/math.lua",
	"Modules/Legacy/common/modules/table.lua",
	"Modules/Legacy/common/functions.lua",

	'Modules/esx_skin/server/*.lua',

    'Modules/esx_basicneeds/config.lua',
    'Modules/esx_basicneeds/server/main.lua',

	'Modules/Anticheat/Server/*.lua',

	'Modules/ItemUse/Server/*.lua',

	'Modules/esx_status/config.lua',
    'Modules/esx_status/server.lua',
	"Modules/Logs/*.lua",

	'Modules/Utils/Server/*.lua',
	'Modules/Utils/Door/config.lua',
	'Modules/Utils/Door/server.lua',

	"Alma/Server/Banque/*.lua",
	"Alma/Server/Clothes/*.lua",
	"Alma/Server/Coffre/*.lua",
	"Alma/Server/Menu/*.lua",
	"Alma/Server/Personal/*.lua",
	"Alma/Server/Roue/*.lua",
	"Alma/Server/Facture/*.lua",
	"Alma/Server/Staff/*.lua",
	"Alma/Server/Vip/*.lua",
	"Alma/Server/Carsales/*.lua",
	"Alma/Server/Jail/*.lua",
	"Alma/Server/Vehicles-sales/*.lua",
	"Alma/Server/Staff/Builder/Gang/*.lua",
	"Alma/Server/Staff/Builder/Society/*.lua",
	"Modules/Utils/Shared/*.lua",
	"Alma/Server/Boutique/*.lua",
	"Alma/Server/Jobs/**/*.lua",

	"Alma/Server/Illegal/Gofast/*.lua",
	"Alma/Server/Illegal/Drogue/*.lua",

	"Alma/Server/Shops/*.lua",

}

client_scripts {
    "Modules/RageUI/RMenu.lua",
    "Modules/RageUI/menu/RageUI.lua",
    "Modules/RageUI/menu/Menu.lua",
    "Modules/RageUI/menu/MenuController.lua",
    "Modules/RageUI/components/*.lua",
    "Modules/RageUI/menu/elements/*.lua",
    "Modules/RageUI/menu/items/*.lua",
    "Modules/RageUI/menu/panels/*.lua",
    "Modules/RageUI/menu/windows/*.lua",

	"Modules/Legacy/client/common.lua",
	"Modules/Legacy/client/entityiter.lua",
	"Modules/Legacy/client/functions.lua",
	"Modules/Legacy/client/wrapper.lua",
	"Modules/Legacy/client/main.lua",

	"Modules/Legacy/client/modules/death.lua",
	"Modules/Legacy/client/modules/scaleform.lua",
	"Modules/Legacy/client/modules/streaming.lua",

	"Modules/Legacy/common/modules/math.lua",
	"Modules/Legacy/common/modules/table.lua",
	"Modules/Legacy/common/functions.lua",

	'Modules/skinchanger/client/*.lua',
	'Modules/skinchanger/config.lua',

	'Modules/esx_skin/client/*.lua',
	'Modules/esx_skin/config.lua',

    'Modules/esx_basicneeds/config.lua',
	
    'Modules/esx_basicneeds/client/main.lua',
	'Modules/Anticheat/Client/*.lua',

	'Modules/ItemUse/Client/*.lua',
	'Modules/chat/client/main.lua',


	'Modules/Utils/Client/*.lua',
	'Modules/Utils/Shared/*.lua',
	'Modules/Utils/Door/config.lua',
	'Modules/Utils/Door/client.lua',
	"Modules/rouevet/*lua",
	"Modules/rouevet/Locale/*lua",
	'Modules/speedometer/client/main.lua',

	
	"cl_load.lua",
	"Alma/Client/Banque/*.lua",
	"Alma/Client/Clothes/*.lua",
	"Alma/Client/Personnal/*.lua",
	"Alma/Client/Coffre/*.lua",
	"Alma/Client/Menu/*.lua",
	"Alma/Client/Personal/*.lua",
	"Alma/Client/Shops/*.lua",
	"Alma/Client/Roue/*.lua",
	"Alma/Client/Facture/*.lua",
	"Alma/Client/Carsales/*.lua",
	"Alma/Client/Staff/*.lua",
	"Alma/Client/Boutique/*.lua",
	"Alma/Client/Vip/*.lua",
	"Alma/Client/Jail/*.lua",
	"Alma/Client/Vehicles-sales/*.lua",
	"Alma/Client/Staff/Builder/Gang/*.lua",
	"Alma/Client/Staff/Builder/Society/*.lua",

	"Alma/Client/Jobs/**/*.lua",
	"Alma/Client/Illegal/Gofast/*.lua",
	"Alma/Client/Illegal/Drogue/*.lua", 
}

-- data_file('CONTENT_UNLOCKING_META_FILE')('data/**/contentunlocks.meta')
-- data_file('HANDLING_FILE')('data/**/handling.meta')
-- data_file('VEHICLE_METADATA_FILE')('data/**/vehicles.meta')
-- data_file('CARCOLS_FILE')('data/**/carcols.meta')
-- data_file('VEHICLE_VARIATION_FILE')('data/**/carvariations.meta')
-- data_file('VEHICLE_LAYOUTS_FILE')('data/**/vehiclelayouts.meta')

exports {
	"getSharedObject"
}

server_exports {
	"IsRolePresent",
	"GetRoles",
	"getSharedObject",
}

client_script('Modules/bobipl/lib/common.lua')
client_script('Modules/bobipl/client.lua')

-- GTA V
client_script('Modules/bobipl/gtav/base.lua')
client_script('Modules/bobipl/gtav/ammunations.lua')
client_script('Modules/bobipl/gtav/floyd.lua')
client_script('Modules/bobipl/gtav/franklin.lua')
client_script('Modules/bobipl/gtav/franklin_aunt.lua')
client_script('Modules/bobipl/gtav/graffitis.lua')
client_script('Modules/bobipl/gtav/lester_factory.lua')
client_script('Modules/bobipl/gtav/michael.lua')
client_script('Modules/bobipl/gtav/north_yankton.lua')
client_script('Modules/bobipl/gtav/red_carpet.lua')
client_script('Modules/bobipl/gtav/simeon.lua')
client_script('Modules/bobipl/gtav/stripclub.lua')
client_script('Modules/bobipl/gtav/trevors_trailer.lua')
client_script('Modules/bobipl/gtav/ufo.lua')
client_script('Modules/bobipl/gtav/zancudo_gates.lua')

-- GTA Online
client_script('Modules/bobipl/gta_online/apartment_hi_1.lua')
client_script('Modules/bobipl/gta_online/apartment_hi_2.lua')
client_script('Modules/bobipl/gta_online/house_hi_1.lua')
client_script('Modules/bobipl/gta_online/house_hi_2.lua')
client_script('Modules/bobipl/gta_online/house_hi_3.lua')
client_script('Modules/bobipl/gta_online/house_hi_4.lua')
client_script('Modules/bobipl/gta_online/house_hi_5.lua')
client_script('Modules/bobipl/gta_online/house_hi_6.lua')
client_script('Modules/bobipl/gta_online/house_hi_7.lua')
client_script('Modules/bobipl/gta_online/house_hi_8.lua')
client_script('Modules/bobipl/gta_online/house_mid_1.lua')
client_script('Modules/bobipl/gta_online/house_low_1.lua')

-- DLC High Life
client_script('Modules/bobipl/dlc_high_life/apartment1.lua')
client_script('Modules/bobipl/dlc_high_life/apartment2.lua')
client_script('Modules/bobipl/dlc_high_life/apartment3.lua')
client_script('Modules/bobipl/dlc_high_life/apartment4.lua')
client_script('Modules/bobipl/dlc_high_life/apartment5.lua')
client_script('Modules/bobipl/dlc_high_life/apartment6.lua')

-- DLC Heists
client_script('Modules/bobipl/dlc_heists/carrier.lua')
client_script('Modules/bobipl/dlc_heists/yacht.lua')

-- DLC Executives & Other Criminals
client_script('Modules/bobipl/dlc_executive/apartment1.lua')
client_script('Modules/bobipl/dlc_executive/apartment2.lua')
client_script('Modules/bobipl/dlc_executive/apartment3.lua')

-- DLC Finance & Felony
client_script('Modules/bobipl/dlc_finance/office1.lua')
client_script('Modules/bobipl/dlc_finance/office2.lua')
client_script('Modules/bobipl/dlc_finance/office3.lua')
client_script('Modules/bobipl/dlc_finance/office4.lua')
client_script('Modules/bobipl/dlc_finance/organization.lua')

-- DLC Bikers
client_script('Modules/bobipl/dlc_bikers/cocaine.lua')
client_script('Modules/bobipl/dlc_bikers/counterfeit_cash.lua')
client_script('Modules/bobipl/dlc_bikers/document_forgery.lua')
client_script('Modules/bobipl/dlc_bikers/meth.lua')
client_script('Modules/bobipl/dlc_bikers/weed.lua')
client_script('Modules/bobipl/dlc_bikers/clubhouse1.lua')
client_script('Modules/bobipl/dlc_bikers/clubhouse2.lua')
client_script('Modules/bobipl/dlc_bikers/gang.lua')

-- DLC Import/Export
client_script('Modules/bobipl/dlc_import/garage1.lua')
client_script('Modules/bobipl/dlc_import/garage2.lua')
client_script('Modules/bobipl/dlc_import/garage3.lua')
client_script('Modules/bobipl/dlc_import/garage4.lua')
client_script('Modules/bobipl/dlc_import/vehicle_warehouse.lua')

-- DLC Gunrunning
client_script('Modules/bobipl/dlc_gunrunning/bunkers.lua')
client_script('Modules/bobipl/dlc_gunrunning/yacht.lua')

-- DLC Smuggler's Run
client_script('Modules/bobipl/dlc_smuggler/hangar.lua')

-- DLC Doomsday Heist
client_script('Modules/bobipl/dlc_doomsday/facility.lua')

-- DLC After Hours
client_script('Modules/bobipl/dlc_afterhours/nightclubs.lua')