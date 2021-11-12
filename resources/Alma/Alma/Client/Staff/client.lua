IS_IN_STAFF = false;
IS_NOCLIP = false;
IS_GAMER_TAG = false;
IS_INTERFACE_ADMIN = true;
IN_DEVELOPPER_MODE = false;
IN_SPECTATE = false;
IN_MAIN = false;

CAMERA_NOCLIP = nil;
NOCLIP_SPEED = 1.0

STAFF_ONLINE = {};
STAFF_ONLINE_COUNT = 0;
STAFF_DISCRIMINATOR_INDEX = 1;
STAFF_DISCRIMINATOR_GROUP = nil;

FILTER_WORD = nil;
FILTER_INDEX = 1;
FILTER_ID = nil;

PLAYER_ONLINE = {};
PLAYER_ONLINE_COUNT = 0;

REPORTS_WAITING = {};
REPORTS_WAITING_COUNT = 0;

JAIL_PLAYER = {};
JAIL_PLAYER_COUNT = 0;

VEHICLE_INDEX = 1;

DISCRIMINATOR_INDEX = 1;
STAFF_DISCRIMINATOR_MENU = {
	{ Name = "Aucun", Value = nil },
    { Name = "Joueurs", Value = "user" },
	{ Name = "Ami(e)", Value = "friend" },
	{ Name = "Novice", Value = "novice" },
	{ Name = "Helper", Value = "helper" },
    { Name = "Animateur", Value = "animateur" },
	{ Name = "Moderateur", Value = "moderator" },
	{ Name = "Administrateur", Value = "admin" },
	{ Name = "Gérant Legal", Value = "gl" },
	{ Name = "Gérant Ilegal", Value = "gi" },
	{ Name = "Gérant staff", Value = "gf" },
    { Name = "Fondateur", Value = "fondateur" }
}

SPECTATE_PLAYER = function(_player)
    local targetPed = GetPlayerPed(_player)

    IN_SPECTATE = not IN_SPECTATE

    if IN_SPECTATE then
        local targetx, targety, targetz = table.unpack(GetEntityCoords(targetPed, false))
        RequestCollisionAtCoord(targetx, targety, targetz)
        NetworkSetInSpectatorMode(true, targetPed)
        WHILE_SPECTATE()
    else
        local targetx, targety, targetz = table.unpack(GetEntityCoords(targetPed, false))
        RequestCollisionAtCoord(targetx, targety, targetz)
        NetworkSetInSpectatorMode(false, targetPed)
        SetEntityVisible(PlayerPedId(), true, 0)
        FreezeEntityPosition(PlayerPedId(), false)
        SetEntityCoords(PlayerPedId(), oldCoords, false)
        SetEntityCollision(PlayerPedId(), true, true)
    end
end

WHILE_SPECTATE = function()
    Citizen.CreateThread(function()
        while IN_SPECTATE do
            local p = GetPlayerFromServerId(PLAYER_SELECT)
            local ped = GetPlayerPed(p)
            local coords = GetEntityCoords((ped), false)
            SetEntityVisible(PlayerPedId(), false, 0)
            FreezeEntityPosition(PlayerPedId(), false)
            SetEntityCoords(PlayerPedId(), coords + 0.5, false)
            FreezeEntityPosition(PlayerPedId(), true)
            SetEntityNoCollisionEntity(ped, GetPlayerPed(-1), true)
            Wait(10)
        end
    end)
end

Alma:AddEventHandler("Staff", "UpdateStaff", function(table)
    STAFF_ONLINE = table;
    STAFF_ONLINE_COUNT = ESX.Table.SizeOf(table)
    while not STAFF_ONLINE do
        Citizen.Wait(1)
    end
end)

Alma:AddEventHandler("Staff", "UpdatePlayer", function(table)
    PLAYER_ONLINE = table;
    PLAYER_ONLINE_COUNT = ESX.Table.SizeOf(table)
    while not PLAYER_ONLINE do
        Citizen.Wait(1)
    end
end)

Alma:AddEventHandler("Staff", "UpdateJail", function(table)
    JAIL_PLAYER = table;
    JAIL_PLAYER_COUNT = ESX.Table.SizeOf(table)
    while not JAIL_PLAYER do
        Citizen.Wait(1)
    end
end)

Alma:AddEventHandler("Staff", "UpdateReport", function(table)
	REPORTS_WAITING = table;
	REPORTS_WAITING_COUNT = ESX.Table.SizeOf(table)
    while not REPORTS_WAITING do
        Citizen.Wait(1)
    end
end)

Alma:AddEventHandler("Staff", "onJoin", function()
    if (PLAYER_ONLINE[GetPlayerServerId(PlayerId())].group ~= "user") then
        IS_IN_STAFF = true;
    end
end)

Alma:AddEventHandler("Staff", "onLeave", function()
    if (PLAYER_ONLINE[GetPlayerServerId(PlayerId())].group ~= "user") then
        IS_IN_STAFF = false;
    end
end)

Alma:AddEventHandler('Staff', "ToggleGamerTags", function(bool)
    if (PLAYER_ONLINE[GetPlayerServerId(PlayerId())].group ~= "user") then
        IS_GAMER_TAG = bool;
    end
end)

Alma:AddEventHandler("Staff", "ToggleNoclip", function(bool)
    if (PLAYER_ONLINE[GetPlayerServerId(PlayerId())].group ~= "user") then
        if (IS_IN_STAFF) then
	        Alma:SetNoclip(bool)
            IS_NOCLIP = bool;
        else
            ESX.ShowNotification("~HUD_COLOUR_DEGEN_RED~Vous devez être en service pour pouvoir vous mettre en caméra libre !")
        end
    end
end)

Alma:AddEventHandler("Staff", "FreezePlayer", function()
	FreezeEntityPosition(PlayerPedId(), true)
end)

Alma:AddEventHandler("Staff", "UnfreezePlayer", function()
	FreezeEntityPosition(PlayerPedId(), false)
end)

local TEXT_SIZE_INDEX = 13;

local WEAPONS_INDEX = 1;
local OPTION = nil;
local WEAPON_SETTINGS = {
    [1] = { name = "Arme boutique", stats = false },
    [2] = { name = "Arme de métier", stats = false },
    [3] = { name = "Arme de mini-jeux", stats = false },
}
local playerId = nil;
local playerDiscriminator = nil;
local playerName = nil;
local playerJob = nil;

OPEN_MENU = function()
    -- MAIN --
    local MAIN_MENU = RageUI.CreateMenu("Administration", "Administration", 1, 100)
    -- JOUEUR --
    local PLAYER_MENU = RageUI.CreateSubMenu(MAIN_MENU, "Joueurs en ligne ["..PLAYER_ONLINE_COUNT.."]", "Joueurs en ligne ["..PLAYER_ONLINE_COUNT.."]", 1, 100)
    local SELECT_PLAYER = RageUI.CreateSubMenu(PLAYER_MENU, "Informations du joueur", "Informations du joueur", 1, 100)
    local FUN_MENU = RageUI.CreateSubMenu(PLAYER_MENU, "Funny", "Que voulez-vous faire ?", 1, 100)
    -- STAFF --
    local STAFF_MENU = RageUI.CreateSubMenu(MAIN_MENU, "Staff en ligne ["..STAFF_ONLINE_COUNT.."]", "Staff en ligne ["..STAFF_ONLINE_COUNT.."]", 1, 100)
    local SELECT_STAFF = RageUI.CreateSubMenu(STAFF_MENU, "Informations du staff", "Informations du staff", 1, 100)
    -- JAIL --
    local JAIL_MENU = RageUI.CreateSubMenu(MAIN_MENU, "Joueurs en prison []", "Joueurs en prison", 1, 100)
    -- REPORT --
    local REPORT_MENU = RageUI.CreateSubMenu(MAIN_MENU, "Report(s)", "Report en attente(s)", 1, 100)
    local REPORT_PLAYER = RageUI.CreateSubMenu(REPORT_MENU, "Joueurs", "Joueurs", 1, 100)
    -- BOUTIQUE --
    local SELECT_HISTORY_TEBEX = RageUI.CreateSubMenu(MAIN_MENU, "Historique", "Transaction boutique (F1)", 1, 100)
    -- PARAMÈTRES --
    local SETTINGS_MENU = RageUI.CreateSubMenu(MAIN_MENU, "Paramètres", "Vos Paramètre(s)", 1, 100)
    local WEAPON_MENU = RageUI.CreateSubMenu(SETTINGS_MENU, "Donation", "Donner une armes", 1, 100)
    local PENALITIES_MENU = RageUI.CreateSubMenu(MAIN_MENU, "Sanctions", "SANCTIONS", 1, 100)
    local INDEX_LIST = {
        zone_revive = 1,
    }

    RageUI.Visible(MAIN_MENU, not RageUI.Visible(MAIN_MENU))

    while MAIN_MENU do
        IN_MAIN = true;
        Citizen.Wait(0)
        RageUI.IsVisible(MAIN_MENU, function()
            RageUI.Checkbox("Prendre son service", "Votre mode administratif, vous permet de gérer les joueurs et de les aidé(e)s !", IS_IN_STAFF, { }, {
                onChecked = function()
                    Alma:TriggerServerEvent("Staff", "onJoin")
                    Alma:TriggerServerEvent("Staff", "RequestStaff")
                    Alma:TriggerServerEvent("Staff", "RequestPlayer")
                    Alma:TriggerServerEvent("Staff", "RequestReport")
                    Alma:TriggerServerEvent("Staff", "RequestJail")
                    IS_IN_STAFF = true;
                    IS_BLIPS_ACTIVE = true;
                end,
                onUnChecked = function()
                    Alma:TriggerServerEvent("Staff", "onLeave")
                    IS_IN_STAFF = false;
                    IS_BLIPS_ACTIVE = false;
                end,
                onSelected = function(Index)
                end
            })
            if (IS_IN_STAFF) then
                RageUI.Button("Staff en lignes", nil, { RightLabel = STAFF_ONLINE_COUNT }, true, {
                    onSelected = function()
                        Alma:TriggerServerEvent("Staff", "RequestStaff")
                        STAFF_MENU:SetTitle("Staff en ligne ["..STAFF_ONLINE_COUNT.."]")
                        STAFF_MENU:SetSubtitle("Staff en ligne ["..STAFF_ONLINE_COUNT.."]")
                        FILTER_ID = nil;
                    end
                }, STAFF_MENU)
                RageUI.Button("Joueur en lignes", nil, { RightLabel = PLAYER_ONLINE_COUNT }, true, {
                    onSelected = function()
                        Alma:TriggerServerEvent("Staff", "RequestPlayer")
                        PLAYER_MENU:SetTitle("Joueurs en ligne ["..PLAYER_ONLINE_COUNT.."]")
                        PLAYER_MENU:SetSubtitle("Joueurs en ligne ["..PLAYER_ONLINE_COUNT.."]")
                    end
                }, PLAYER_MENU)
                if (IN_DEVELOPPER_MODE) then
                    RageUI.Button("Joueur en prison", (JAIL_PLAYER_COUNT <= 0 and "~r~Il n'y a personne en jail, pour rafraichir reprennais votre service !" or nil), { RightLabel = JAIL_PLAYER_COUNT }, (JAIL_PLAYER_COUNT > 0 and true or false), {
                        onSelected = function()
                            Alma:TriggerServerEvent("Staff", "RequestJail")
                            JAIL_MENU:SetTitle("Joueurs en prison ["..JAIL_PLAYER_COUNT.."]")
                            JAIL_MENU:SetSubtitle("Joueurs en prison ["..JAIL_PLAYER_COUNT.."]")
                        end
                    }, JAIL_MENU)
                end
                RageUI.Button("Report en attente", nil, { RightLabel = REPORTS_WAITING_COUNT }, true, {
                    onSelected = function()
                        Alma:TriggerServerEvent("Staff", "RequestReport")
                        REPORT_MENU:SetTitle("Report en attente ["..REPORTS_WAITING_COUNT.."]")
                        REPORT_MENU:SetSubtitle("Report en attente ["..REPORTS_WAITING_COUNT.."]")
                    end
                }, REPORT_MENU)
                if (GetVehiclePedIsIn(PlayerPedId(), false) ~= 0) then
                    RageUI.Button("Réparer le véhicule", nil, { }, true, {
                        onSelected = function()
                            Alma:TriggerServerEvent("Staff", "FixVehicle")
                        end
                    })
                end
                if (GetVehiclePedIsIn(PlayerPedId(), false) == 0) then
                    RageUI.List('Vehicles', {
                        { Name = "BMX", Value = 'bmx' },
                        { Name = "Clique", Value = 'clique' },
                        { Name = "Sanchez", Value = 'sanchez' },
                        { Name = "Personnel", Value = nil },
                    }, VEHICLE_INDEX, nil, {}, true, {
                        onListChange = function(Index, Item)
                            VEHICLE_INDEX = Index;
                        end,
                        onSelected = function(Index, Item)
                            if Item.Value ~= nil then
                                Alma:TriggerServerEvent("Staff", "CreateVehicles", Item.Value)
                            else
                                local input = Helper:KeyboardInput("Nom du véhicle souhaitez", "", 100, false)
                                if (input ~= nil) then
                                    Alma:TriggerServerEvent("Staff", "CreateVehicles", tostring(input))
                                end
                            end
                        end,
                    })
                end
                RageUI.Checkbox("Camera libre", nil, IS_NOCLIP, { }, {
                    onChecked = function()
                        Alma:TriggerServerEvent("Staff", "ToggleNoclip", true)
                    end,
                    onUnChecked = function()
                        Alma:TriggerServerEvent("Staff", "ToggleNoclip", false)
                    end,
                    onSelected = function()
                        
                    end
                })
                RageUI.Checkbox("GamerTags", "Vous permez de voir absolument tout les joueurs proche de vous sur la map.", IS_GAMER_TAG, { }, {
                    onChecked = function()
                        Alma:TriggerServerEvent('Staff', "ToggleGamerTags", true)
                    end,
                    onUnChecked = function()
                        Alma:TriggerServerEvent('Staff', "ToggleGamerTags", false)
                    end,
                    onSelected = function(Index)

                    end
                })
                RageUI.Button("Paramètres", nil, {}, true, {
                    onSelected = function()
                        
                    end
                }, SETTINGS_MENU)
            end
        end)
        RageUI.IsVisible(PLAYER_MENU, function()
            if tonumber(PLAYER_ONLINE_COUNT) == 0 then
                RageUI.Separator("");
                RageUI.Separator("Aucun joueurs connecté.");
                RageUI.Separator("");
            else
                for k,v in pairs(PLAYER_ONLINE) do
                    RageUI.Button("["..v.id.."]["..v.group.."] - "..v.name:gsub("~", ""), nil, {}, true, {
                        onSelected = function()
                            PLAYER_SELECT = v.id;
                            if (IN_DEVELOPPER_MODE) then
                                Alma:TriggerServerEvent("Staff", "RequestHistory", PLAYER_SELECT)
                            end
                        end
                    }, SELECT_PLAYER)
                end
            end
        end)
        RageUI.IsVisible(REPORT_MENU, function()
            if REPORTS_WAITING_COUNT == 0 then
                RageUI.Separator("");
                RageUI.Separator("Aucun report.")
                RageUI.Separator("");
            else
                for i, v in pairs(REPORTS_WAITING) do
                    if v.pris == 0 or v.prisname == GetPlayerName(PlayerId()) then 
                        RageUI.Button("[" .. v.id .. "] " .. v.name:gsub("~", ""), "ID : " .. v.id .. "\n" .. "Nom : " .. v.name:gsub("~", "") .. "\nRaison : " .. v.reason .. "\nTime : " .. v.time .. "\nDate : " .. v.date, { }, true, {
                            onSelected = function()
                                if v.prisname ~= GetPlayerName(PlayerId()) then
                                    Alma:TriggerServerEvent("Report", "Pris", v.id)
                                end
                                PLAYER_REPORT = v.id;
                                REPORT_PLAYER:SetTitle(v.name)
                                REPORT_PLAYER:SetSubtitle("Report de "..v.name)
                                RageUI.Visible(REPORT_PLAYER, true)
                            end
                        })
                    else
                        RageUI.Button("[" .. v.id .. "] " .. v.name:gsub("~", ""), "ID : " .. v.id .. "\n" .. "Nom : " .. v.name:gsub("~", "") .. "\nRaison : " .. v.reason .. "\nTime : " .. v.time .. "\nDate : " .. v.date, { }, false, {
                            onSelected = function()
                                PLAYER_REPORT = v.id;
                                Wait(200)
                                REPORT_PLAYER:SetTitle(v.name)
                                REPORT_PLAYER:SetSubtitle("Report de "..v.name:gsub("~", ""))
                                RageUI.Visible(REPORT_PLAYER, true)
                            end
                        })
                    end
                end
            end
        end)
        RageUI.IsVisible(JAIL_MENU, function()
            for k,v in pairs(JAIL_PLAYER) do
                RageUI.Button("["..v.id.."] - "..v.name, "Time en minute(s) : ~o~"..math.round(v.time*v.time/v.time).."~s~ min\n\nRaison du jail : "..v.raison.."\nAppuyer sur ENTRER pour unjail !", {}, true, {
                    onSelected = function()
                        local input = Helper:KeyboardInput("Veuillez confirmer (~g~Oui~s~/~r~Non~s~)", "non", 3, false)
                        if (type(input) == "string") and (input ~= nil) and (input:upper() == "OUI") then
                            ExecuteCommand("unjail "..v.id)
                        end
                    end
                })
            end
        end)
        RageUI.IsVisible(REPORT_PLAYER, function()
            RageUI.Separator("Report de "..PLAYER_ONLINE[PLAYER_REPORT].name:gsub("~", ""))
            RageUI.Button("Nom du joueur", REPORTS_WAITING[PLAYER_REPORT].name:gsub("~", ""), {RightLabel = REPORTS_WAITING[PLAYER_REPORT].name:gsub("~", "")}, true, {})
            RageUI.Button("Raison", REPORTS_WAITING[PLAYER_REPORT].reason:gsub("~", ""), {}, true, {})
            RageUI.Button("Effectué à", REPORTS_WAITING[PLAYER_REPORT].time:gsub("~", ""), {}, true, {})
            RageUI.Separator("Actions.")
            RageUI.Button("Ce téléporter à lui", nil, {}, true, {
                onSelected = function()
                    Alma:TriggerServerEvent("Staff", "TeleportTo", PLAYER_REPORT)
                end
            })
            RageUI.Button("Téléporter sur moi", nil, {}, true, {
                onSelected = function()
                    Alma:TriggerServerEvent("Staff", "TeleportMe", PLAYER_REPORT)
                end
            })
            RageUI.Separator("Complémentaire.")
            RageUI.Button("Job du joueur", nil, {RightLabel = PLAYER_ONLINE[PLAYER_REPORT].job}, true, {})
            RageUI.Button("Discriminateur", nil, {RightLabel = PLAYER_ONLINE[PLAYER_REPORT].group}, true, {})
            if (IN_DEVELOPPER_MODE) then
                RageUI.Button("Interior ID", nil, { RightLabel = GetInteriorFromEntity(GetPlayerPed(PLAYER_REPORT)) }, true, {
                    onSelected = function()

                    end
                })
            else
                RageUI.Button("Interior ID", nil, { }, false, {
                    onSelected = function()

                    end
                })
            end
            RageUI.Separator("Terminé.")
            RageUI.Button("Clore le report", nil, {}, true, {
                onSelected = function()
                    Alma:TriggerServerEvent("Report", "Close", PLAYER_REPORT)
                    if (PLAYER_ONLINE[PLAYER_REPORT]) then
                        Visual.Subtitle("Vous avez fermé le report de "..PLAYER_ONLINE[PLAYER_REPORT].name:gsub("~", ""), 1000)
                        RageUI.GoBack()
                    else
                        RageUI.GoBack()
                    end
                end
            })
        end)
        RageUI.IsVisible(SETTINGS_MENU, function()
            RageUI.Slider('Taille des pseudonyme', TEXT_SIZE_INDEX, 500, nil, true, {}, true, {
                onSliderChange = function(Index)
                    TEXT_SIZE_INDEX = Index
                end,
                onSelected = function(Index)
    
                end
            })
            RageUI.Slider('Réanimer en zones', INDEX_LIST.zone_revive, 100, "Zone défini à ~g~"..INDEX_LIST.zone_revive.."~s~ mètres\n\nValider avec ~g~ENTRÉE~s~", true, {}, true, {
                onSliderChange = function(Index)
                    INDEX_LIST.zone_revive = Index
                end,
                onSelected = function(Index)
                    ExecuteCommand("revive-radius "..Index)
                end
            })
            RageUI.Checkbox("Mode développeur", nil, IN_DEVELOPPER_MODE, { }, {
                onChecked = function()
                    Alma:TriggerServerEvent("Staff", "DevMode", true)
                    Alma:TriggerServerEvent("Staff", "RequestJail")
                end,
                onUnChecked = function()
                    Alma:TriggerServerEvent("Staff", "DevMode", false)
                end,
                onSelected = function()
                    
                end
            })
            RageUI.Checkbox("FloatingText", nil, IS_INTERFACE_ADMIN, { }, {
                onChecked = function()
                    IS_INTERFACE_ADMIN = true;
                end,
                onUnChecked = function()
                    IS_INTERFACE_ADMIN = false;
                end,
                onSelected = function()
                    
                end
            })
            if (IN_DEVELOPPER_MODE) then
                RageUI.Button("Print votre position", nil, {}, true, {
                    onSelected = function()
                        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
                        local heading = GetEntityHeading(PlayerPedId())
                        print("vector4(" .. x .. "," .. y .. "," .. z .. "," .. heading .. ")")
                        Alma:TriggerServerEvent("Discord", "Print", "vector4(" .. x .. "," .. y .. "," .. z .. "," .. heading .. ")")
                    end
                })
                RageUI.Button("Teléporté au markeur", nil, {RightBadge = RageUI.BadgeStyle.Location}, true, {
                    onSelected = function()
                        local waypointHandle = GetFirstBlipInfoId(8)
                        local plyPed = PlayerPedId()

                        if DoesBlipExist(waypointHandle) then
                            Citizen.CreateThread(function()
                                local waypointCoords = GetBlipInfoIdCoord(waypointHandle)
                                local foundGround, zCoords, zPos = false, -500.0, 0.0

                                while not foundGround do
                                    zCoords = zCoords + 10.0
                                    RequestCollisionAtCoord(waypointCoords.x, waypointCoords.y, zCoords)
                                    Citizen.Wait(0)
                                    foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y, zCoords)

                                    if not foundGround and zCoords >= 2000.0 then
                                        foundGround = true
                                    end
                                end
                                if (IS_NOCLIP) then
                                    SetCamCoord(CAMERA_NOCLIP, vector3(waypointCoords.x, waypointCoords.y, zPos))
                                else
                                    SetPedCoordsKeepVehicle(plyPed, waypointCoords.x, waypointCoords.y, zPos)
                                end
                                Visual.Prompt("Téléportation en cours..")
                                DoScreenFadeOut(1000)
                                Wait(1000)
                                DoScreenFadeIn(1000)
                                BusyspinnerOff();
                            end)
                        else
                            Visual.Subtitle("~r~Vous devez avoir mis un markeur sur la map", 1000)
                        end
                    end
                })
                RageUI.Button('Customiser au max', nil, {}, true, {
                    onSelected = function()
                        UPGRADE_VEH(GetVehiclePedIsIn(PlayerPedId(),false))
                    end
                })
            end
            RageUI.Button("Donner une arme.", nil, { RightBadge = RageUI.BadgeStyle.Tick  }, true, {
                onSelected = function()
                    -- for i = 1, #Weapon do
                    --     print(Weapon[i].name, Weapon[i].hashKey)
                    --     -- table.insert(WEAPONS_LISTS, { Name = Weapon[i].name, Value = Weapon[i].hashKey })
                    -- end
                end
            }, WEAPON_MENU)
            if (GetInteriorFromEntity(PlayerPedId()) ~= 0) then
                RageUI.Button("Interior ID", nil, { RightLabel = GetInteriorFromEntity(PlayerPedId()) }, true, {
                    onSelected = function()

                    end
                })
            else
                RageUI.Button("Interior ID", nil, {  }, false, {
                    onSelected = function()

                    end
                })
            end
        end)
        RageUI.IsVisible(WEAPON_MENU, function()
            if (ESX.Table.SizeOf(WEAPONS_LISTS) > 0) then
                RageUI.List("Arme", WEAPONS_LISTS, WEAPONS_INDEX, nil, {}, true, {
                    onListChange = function(Index, Item)
                        WEAPONS_INDEX = Index;
                        WEAPON_VALUE = Item.Value;
                    end,
                    onSelected = function(Index, Item)
                        
                    end,
                }) 
            end
    
            for i, v in pairs(WEAPON_SETTINGS) do
                RageUI.Checkbox(v.name, nil, v.stats, {}, {
                    onChecked = function()
                        v.stats = true;
                    end,
                    onUnChecked = function()
                        v.stats = false;
                    end,
                    onSelected = function(Index)
                        OPTION = v.name;
                    end
                })
            end
            RageUI.Button("Donner l'arme", nil, {}, true, {
                onSelected = function()
                    local input = Helper:KeyboardInput("ID Du joueur", 1, 100, true)
                    if (type(input) == "number") and (input > 0) then
                        Alma:TriggerServerEvent("Staff", "GiveWeapon", input, WEAPONS_LISTS[WEAPONS_INDEX].Value, WEAPON_SETTINGS)
                    end
                end
            })
        end)
        RageUI.IsVisible(SELECT_PLAYER, function()
            if not PLAYER_ONLINE[PLAYER_SELECT] then
                RageUI.Separator("");
                RageUI.Separator("Aucun informations.");
                RageUI.Separator("");
            else
                RageUI.Button("Nom", nil, {RightLabel = PLAYER_ONLINE[PLAYER_SELECT].name:gsub("~", "")}, true, {})
                RageUI.Separator("Informations utilitaire.")
                RageUI.Button("Nom du job", nil, {RightLabel = PLAYER_ONLINE[PLAYER_SELECT].job}, true, {})
                if (IN_SPECTATE) then
                    RageUI.Button("Spectate", nil, {RightLabel = "~o~Activé"}, true, {
                        onSelected = function()
                            if GetEntityCoords(GetPlayerFromServerId(PLAYER_SELECT)).x == 0 then
                                Wait(50)
                                SPECTATE_PLAYER(GetPlayerFromServerId(PLAYER_SELECT))
                            else
                                SPECTATE_PLAYER(GetPlayerFromServerId(PLAYER_SELECT))
                            end
                        end
                    })
                else
                    RageUI.Button("Spectate", nil, {RightLabel = "~r~Désactivé"}, true, {
                        onSelected = function()
                            if GetEntityCoords(GetPlayerFromServerId(PLAYER_SELECT)).x == 0 then
                                Wait(50)
                                oldCoords = GetEntityCoords(GetPlayerPed(-1))
                                SPECTATE_PLAYER(GetPlayerFromServerId(PLAYER_SELECT))
                            else
                                oldCoords = GetEntityCoords(GetPlayerPed(-1))
                                SPECTATE_PLAYER(GetPlayerFromServerId(PLAYER_SELECT))
                            end
                        end
                    })
                end
                RageUI.List("Discriminateur", STAFF_DISCRIMINATOR_MENU, DISCRIMINATOR_INDEX, "Le discriminateur, permet de donner un nom, au grade d'un staff.", { }, true, {
                    onListChange = function(Index, Item)
                        DISCRIMINATOR_INDEX = Index
                    end,
                    onSelected = function(Index, Item)
                        if (Item.Value ~= nil) then
                            Visual.Prompt("Changement des permissions.", 1)
                            Citizen.Wait(2000)
                            Alma:TriggerServerEvent("Permissions", "ChangeDiscriminator", PLAYER_SELECT, Item.Value)
                            BusyspinnerOff();
                        end
                    end,
                })
                if (IN_DEVELOPPER_MODE) then
                    RageUI.Button("Funny", nil, {}, true, {
                        onSelected = function()
                            realId = PLAYER_SELECT
                            ActiveColor = false;
                        end
                    }, FUN_MENU)
                end
                RageUI.Separator("Actions.");
                RageUI.Button("Réanimer", nil, {}, true, {
                    onSelected = function()
                        Alma:TriggerServerEvent("Staff", "Revive", PLAYER_SELECT)
                    end
                })
                RageUI.Button("Ce téléporter à lui", nil, {}, true, {
                    onSelected = function()
                        Alma:TriggerServerEvent("Staff", "TeleportTo", PLAYER_SELECT)
                    end
                })
                RageUI.Button("Téléporter sur moi", nil, {}, true, {
                    onSelected = function()
                        Alma:TriggerServerEvent("Staff", "TeleportMe", PLAYER_SELECT)
                    end
                })
                RageUI.Button("Penalities", nil, {}, true, {
                    onSelected = function()
                        playerId = PLAYER_SELECT;
                        playerDiscriminator = PLAYER_ONLINE[PLAYER_SELECT].group;
                        playerName = PLAYER_ONLINE[PLAYER_SELECT].name;
                        playerJob = PLAYER_ONLINE[PLAYER_SELECT].job;
                        RageUI.Visible(PENALITIES_MENU, true)
                    end
                })
                if (IN_DEVELOPPER_MODE) then
                    RageUI.Separator("Informations boutique.")
                    if (SELECTED_PLAYER_TEBEX_PULSION_COUNT) then
                        RageUI.Button("Pulsion", "Monaie de la boutique correspondant au donnés de "..PLAYER_ONLINE[PLAYER_SELECT].name:gsub("~", ""), {RightLabel = SELECTED_PLAYER_TEBEX_PULSION_COUNT}, true, {
                            onSelected = function()
                            end
                        })
                    else
                        RageUI.Button("Impossible de retrouvez l'utilisateur.", "Monaie de la boutique correspondant au donnés de "..PLAYER_ONLINE[PLAYER_SELECT].name:gsub("~", ""), {}, false, {})
                    end
                    if (SELECTED_PLAYER_TEBEX_HISTORY) then
                        RageUI.Button("Historique", "Historique des achats sur la boutique en jeux de "..PLAYER_ONLINE[PLAYER_SELECT].name:gsub("~", ""), {RightLabel = ESX.Table.SizeOf(SELECTED_PLAYER_TEBEX_HISTORY)}, true, {
                            onSelected = function()
                                Alma:TriggerServerEvent("Staff", "HistoryPlayer", PLAYER_SELECT)
                            end
                        }, SELECT_HISTORY_TEBEX)
                    else
                        RageUI.Button("Aucune informations boutique trouvé.", "Historique des achats sur la boutique en jeux de "..PLAYER_ONLINE[PLAYER_SELECT].name:gsub("~", ""), {}, false, {})
                    end
                else
                    RageUI.Separator("Informations boutique.")
                    RageUI.Button("Vous devez être en Mode Développeur", nil, {}, false, {})
                end
            end
        end)
        RageUI.IsVisible(SELECT_HISTORY_TEBEX, function()
            if (SELECTED_PLAYER_TEBEX_HISTORY ~= nil) then
                for i, v in pairs(SELECTED_PLAYER_TEBEX_HISTORY) do
                    local label;
                    if (tonumber(v.price) == 0) then
                        label = string.format("%s", v.points)
                    else
                        label = string.format("%s (%s%s)", v.points, v.price, v.currency);
                    end
                    RageUI.Button(v.transaction, nil, { RightLabel = label }, true, {
                        onSelected = function()
    
                        end,
                    });
                end
            end
        end)
        RageUI.IsVisible(FUN_MENU, function()
            RageUI.Button("Modifier la vitesse du véh", nil, {}, true, {
                onSelected = function()
                    local input = Helper:KeyboardInput("Nouvelle vitesse ?", "", 100, true)
                    if input ~= nil then
                        Alma:TriggerServerEvent("Funny", "Speed", realId, tonumber(input))
                    end
                end
            })
            RageUI.Checkbox("Modifier la couleur", nil, ActiveColor, { }, {
                onChecked = function()
                    ActiveColor = true;
                end,
                onUnChecked = function()
                    ActiveColor = false;
                end,
                onSelected = function(Index)
                    ActiveColor = Index;
                    COLORVEHR = 33
                    COLORVEHG = 33
                    COLORVEHB = 33
                end
            })
            if (ActiveColor) then
                RageUI.Slider('Rouge', COLORVEHR, 255, "Selectionner sur : "..COLORVEHR, true, {}, true, {
                    onSliderChange = function(Color)
                        COLORVEHR = Color
                    end,
                    onSelected = function(Index)
                        Alma:TriggerServerEvent("Funny", "Color", realId, COLORVEHR, COLORVEHG, COLORVEHB)
                    end
                })
                RageUI.Slider('Vert', COLORVEHG, 255, "Selectionner sur : "..COLORVEHG, true, {}, true, {
                    onSliderChange = function(Color)
                        COLORVEHG = Color
                    end,
                    onSelected = function(Index)
                        Alma:TriggerServerEvent("Funny", "Color", realId, COLORVEHR, COLORVEHG, COLORVEHB)
                    end
                })
                RageUI.Slider('Bleu', COLORVEHB, 255, "Selectionner sur : "..COLORVEHB, true, {}, true, {
                    onSliderChange = function(Color)
                        COLORVEHB = Color
                    end,
                    onSelected = function(Index)
                        Alma:TriggerServerEvent("Funny", "Color", realId, COLORVEHR, COLORVEHG, COLORVEHB)
                    end
                })
            end
            RageUI.Button("Faire sortir de la voiture", nil, {}, true, {
                onSelected = function()
                    Alma:TriggerServerEvent("Funny", "TaskLeave", realId)
                end
            })
            RageUI.Button("Crever un pneu aléatoire", nil, {}, true, {
                onSelected = function()
                    Alma:TriggerServerEvent("Funny", "Burst", realId)
                end
            })
            RageUI.Button("Réparer véhicule", nil, {}, true, {
                onSelected = function()
                    Alma:TriggerServerEvent("Funny", "FixVehicle", realId)
                end
            })
            RageUI.Button("Full custom", nil, {}, true, {
                onSelected = function()
                    Alma:TriggerServerEvent("Funny", "FullCustom", realId)
                end
            })
        end)
        RageUI.IsVisible(STAFF_MENU, function()
            if tonumber(STAFF_ONLINE_COUNT) == 0 then
                RageUI.Separator("");
                RageUI.Separator("Aucun joueurs connecté.");
                RageUI.Separator("");
            else

                RageUI.List("Discriminateur", STAFF_DISCRIMINATOR_MENU, STAFF_DISCRIMINATOR_INDEX, "Le discriminateur, permet de voir les staff qui ont se grade.", { }, true, {
                    onListChange = function(Index, Item)
                        STAFF_DISCRIMINATOR_INDEX = Index;
                        STAFF_DISCRIMINATOR_GROUP = Item.Value;
                    end,
                    onSelected = function(Index, Item)
        
                    end,
                })
                RageUI.List("En Service", {
                    { Name = "Tout", Value = nil },
                    { Name = "Oui", Value = true },
                    { Name = "Non", Value = false }
                }, FILTER_INDEX, "Filtre pour savoir ou non qui est en service.", { }, true, {
                    onListChange = function(Index, Item)
                        FILTER_INDEX = Index;
                        FILTER_WORD = Item.Value;
                    end,
                    onSelected = function(Index, Item)
        
                    end,
                })
                RageUI.Button("🔎 Filter par ID", "Fournissez un ID, et si l'ID est présent dans la liste des joueurs celui-ci sera affiché", { RightLabel = "Rechercher"}, true, {
                    onSelected = function()
                        local input = Helper:KeyboardInput("Que recherchez-vous ?", "", 50, true)
                        if input ~= nil then
                            FILTER_ID = input;
                        else
                            ESX.ShowNotification("~r~Recherche invalide/annulée !")
                        end
                    end
                })
                for k,v in pairs(STAFF_ONLINE) do
                    if v.group == STAFF_DISCRIMINATOR_GROUP or STAFF_DISCRIMINATOR_GROUP == nil then
                        if v.service == FILTER_WORD or FILTER_WORD == nil then
                            if v.id == FILTER_ID or FILTER_ID == nil then
                                RageUI.Button("["..v.id.."] - "..v.name:gsub("~", "").." ["..v.group.."] ["..(v.service and "~g~Actif~s~" or "~r~Inactif~s~").."]", nil, {}, true, {
                                    onSelected = function()
                                        PLAYER_SELECT = v.id;
                                        if (IN_DEVELOPPER_MODE) then
                                            Alma:TriggerServerEvent("Staff", "RequestHistory", v.id)
                                        end
                                    end
                                }, SELECT_STAFF)
                            end
                        end
                    end
                end
            end
        end)
        RageUI.IsVisible(SELECT_STAFF, function()
            if not STAFF_ONLINE[PLAYER_SELECT] then
                RageUI.Separator("");
                RageUI.Separator("Aucun informations.");
                RageUI.Separator("");
            else
                RageUI.Separator(STAFF_ONLINE[PLAYER_SELECT].service and "~g~En Service" or "~r~En rôleplay");
                RageUI.Button("Nom", nil, {RightLabel = STAFF_ONLINE[PLAYER_SELECT].name:gsub("~", "")}, true, {})
                RageUI.Separator("Informations utilitaire.")
                RageUI.Button("Nom du job", nil, {RightLabel = STAFF_ONLINE[PLAYER_SELECT].job}, true, {})
                RageUI.Button("Nom du groups", nil, {RightLabel = Alma:GetGroupLabel(STAFF_ONLINE[PLAYER_SELECT].group)..","..STAFF_ONLINE[PLAYER_SELECT].group }, true, {})
                RageUI.List("Discriminateur", STAFF_DISCRIMINATOR_MENU, DISCRIMINATOR_INDEX, "Le discriminateur, permet de donner un nom, au grade d'un staff.", { }, true, {
                    onListChange = function(Index, Item)
                        DISCRIMINATOR_INDEX = Index
                    end,
                    onSelected = function(Index, Item)
                        if (Item.Value ~= nil) then
                            Visual.Prompt("Changement des permissions.", 1)
                            Citizen.Wait(2000)
                            Alma:TriggerServerEvent("Permissions", "ChangeDiscriminator", PLAYER_SELECT, Item.Value)
                            BusyspinnerOff();
                        end
                    end,
                })
                if (IN_DEVELOPPER_MODE) then
                    RageUI.Button("Funny", nil, {}, true, {
                        onSelected = function()
                            realId = PLAYER_SELECT
                            ActiveColor = false;
                        end
                    }, FUN_MENU)
                end
                RageUI.Separator("Actions.");
                RageUI.Button("Réanimer", nil, {}, true, {
                    onSelected = function()
                        Alma:TriggerServerEvent("Staff", "Revive", PLAYER_SELECT)
                    end
                })
                RageUI.Button("Ce téléporter à lui", nil, {}, true, {
                    onSelected = function()
                        Alma:TriggerServerEvent("Staff", "TeleportTo", PLAYER_SELECT)
                    end
                })
                RageUI.Button("Téléporter sur moi", nil, {}, true, {
                    onSelected = function()
                        Alma:TriggerServerEvent("Staff", "TeleportMe", PLAYER_SELECT)
                    end
                })
                RageUI.Button("Penalities", "Toutes les type de punition telle que jail ou ban", {}, true, {
                    onSelected = function()
                        playerId = PLAYER_SELECT;
                        playerDiscriminator = STAFF_ONLINE[PLAYER_SELECT].group;
                        playerName = STAFF_ONLINE[PLAYER_SELECT].name;
                        playerJob = STAFF_ONLINE[PLAYER_SELECT].job;
                        RageUI.Visible(PENALITIES_MENU, true)
                    end
                })
                if (IN_DEVELOPPER_MODE) then
                    RageUI.Separator("Informations boutique.")
                    if (SELECTED_PLAYER_TEBEX_PULSION_COUNT) then
                        RageUI.Button("Pulsion", "Monaie de la boutique correspondant au donnés de "..STAFF_ONLINE[PLAYER_SELECT].name:gsub("~", ""), {RightLabel = SELECTED_PLAYER_TEBEX_PULSION_COUNT}, true, {
                            onSelected = function()
                            end
                        })
                    else
                        RageUI.Button("Impossible de retrouvez l'utilisateur.", "Monaie de la boutique correspondant au donnés de "..STAFF_ONLINE[PLAYER_SELECT].name:gsub("~", ""), {}, false, {})
                    end
                    if (SELECTED_PLAYER_TEBEX_HISTORY) then
                        RageUI.Button("Historique", "Historique des achats sur la boutique en jeux de "..STAFF_ONLINE[PLAYER_SELECT].name:gsub("~", ""), {RightLabel = ESX.Table.SizeOf(SELECTED_PLAYER_TEBEX_HISTORY)}, true, {
                            onSelected = function()
                            end
                        }, SELECT_HISTORY_TEBEX)
                    else
                        RageUI.Button("Aucune informations boutique trouvé.", "Historique des achats sur la boutique en jeux de "..STAFF_ONLINE[PLAYER_SELECT].name:gsub("~", ""), {}, false, {})
                    end
                else
                    RageUI.Separator("Informations boutique.")
                    RageUI.Button("Vous devez être en Mode Développeur", nil, {}, false, {})
                end
            end
        end)
        RageUI.IsVisible(PENALITIES_MENU, function()
            RageUI.Button("[" .. playerId .. "][" .. playerDiscriminator .. "]" .. playerName, nil, { RightLabel = playerJob }, true, {
            })
            RageUI.Separator("Sanctions")
            for i, v in pairs(PENALTIES) do
                RageUI.Button("[" .. PENALTIES_TYPE_NAME[v.type] .. "] - " .. v.name, v.description, { RightLabel = v.seconds .. "/s" }, true, {
                    onSelected = function()
                        local input = Helper:KeyboardInput("Valider la sanction ? (Oui ou Non)", "Non", 3);
                        if (input ~= nil) and (string.upper(input) == "OUI") then
                            Helper:Switch(v.type, {
                                [PENALTIES_TYPE.JAIL] = function()
                                    Alma:TriggerServerEvent("Penalties", "Jail", v.id, playerId)
                                end,
                                [PENALTIES_TYPE.BAN] = function()
                                    Alma:TriggerServerEvent("Penalties", "Ban", v.id, playerId)
                                end
                            })
                        end
                    end
                })
            end
        end)
        if not RageUI.Visible(MAIN_MENU) and not RageUI.Visible(SELECT_PLAYER) and not RageUI.Visible(SELECT_STAFF) and not RageUI.Visible(REPORT_MENU) and not RageUI.Visible(STAFF_MENU) and not RageUI.Visible(PLAYER_MENU) and not RageUI.Visible(SETTINGS_MENU) and not RageUI.Visible(SELECT_HISTORY_TEBEX) and not RageUI.Visible(WEAPON_MENU) and not RageUI.Visible(REPORT_PLAYER) and not RageUI.Visible(PENALITIES_MENU) and not RageUI.Visible(JAIL_MENU) and not RageUI.Visible(FUN_MENU) then
            -- MAIN --
            MAIN_MENU = RMenu:DeleteType("MAIN_MENU", true)
            -- PLAYER --
            SELECT_PLAYER = RMenu:DeleteType("SELECT_PLAYER", true)
            PLAYER_MENU = RMenu:DeleteType("PLAYER_MENU", true)
            FUN_MENU = RMenu:DeleteType("FUN_MENU", true)
            -- STAFF --
            SELECT_STAFF = RMenu:DeleteType("SELECT_STAFF", true)
            STAFF_MENU = RMenu:DeleteType("STAFF_MENU", true)
            PENALITIES_MENU = RMenu:DeleteType("PENALITIES_MENU", true)
            -- REPORT --
            REPORT_MENU = RMenu:DeleteType("REPORT_MENU", true)
            REPORT_PLAYER = RMenu:DeleteType("REPORT_PLAYER", true)
            -- PARAMÈTRES --
            SETTINGS_MENU = RMenu:DeleteType("SETTINGS_MENU", true)
            WEAPON_MENU = RMenu:DeleteType("WEAPON_MENU", true)
            -- BOUTIQUE --
            SELECT_HISTORY_TEBEX = RMenu:DeleteType("SELECT_HISTORY_TEBEX", true)
            IN_MAIN = false;
        end
    end
end

local SetEntityRagdoll, IS_IN_SELECTING = nil, false

AddEventHandler('esx:onPlayerDeath', function()
    SetEntityRagdoll = true
end)

AddEventHandler("Alma:OnPlayerInitialised:Init", function()
    IS_IN_SELECTING = not IS_IN_SELECTING;
end)

Alma.netRegisterAndHandle('EMS:ReviveClientPlayer', function()
	SetEntityRagdoll = false
	Alma.toServer('EMS:UpdateTableIsDead', false)
end)

Alma:AddEventHandler("Staff", "Burst", function(realId, random)
    local pPed = GetPlayerPed(GetPlayerFromServerId(realId))
    local pVeh = GetVehiclePedIsUsing(pPed)
    SetVehicleTyreBurst(pVeh, tonumber(random), true, 1000.0)
end)

Alma:AddEventHandler("Staff", "FixVehicle", function(realId)
    local pPed = GetPlayerPed(GetPlayerFromServerId(realId))
    local pVeh = GetVehiclePedIsUsing(pPed)
    SetVehicleEngineHealth(pVeh, 100)
    SetVehicleEngineOn(pVeh, true, true)
    SetVehicleFixed(pVeh)
end)

Alma:AddEventHandler("Staff", "ColorVeh", function(realId, r, g, b)
    local pPed = GetPlayerPed(GetPlayerFromServerId(realId))
    local pVeh = GetVehiclePedIsUsing(pPed)
    SetVehicleCustomPrimaryColour(pVeh, r, g, b)
    SetVehicleCustomSecondaryColour(pVeh, r, g, b)
end)

Alma:AddEventHandler("Staff", "FullCustom", function(realId)
    local pPed = GetPlayerPed(GetPlayerFromServerId(realId))
    local pVeh = GetVehiclePedIsUsing(pPed)
    UPGRADE_VEH(pVeh)
end)

Alma:AddEventHandler("Staff", "TaskLeave", function(realId)
    local pPed = GetPlayerPed(GetPlayerFromServerId(realId))
    local pVeh = GetVehiclePedIsUsing(pPed)
    TaskLeaveVehicle(pPed, pVeh, 16)
end)

Alma:AddEventHandler("Staff", "ModifySpeed", function(realId, modify)
    local pPed = GetPlayerPed(GetPlayerFromServerId(realId))
    local pVeh = GetVehiclePedIsUsing(pPed)
    print(pPed, pVeh)
    SetVehicleHandlingFloat(pVeh, 'CHandlingData', 'fMass', 0.0)
    SetVehicleHandlingFloat(pVeh, 'CHandlingData', 'fInitialDragCoeff', 120.0)
    SetVehicleHandlingFloat(pVeh, 'CHandlingData', 'fInitialDriveForce', modify + 1.0)
    SetVehicleHandlingFloat(pVeh, 'CHandlingData', 'fDriveBiasFront', 0.5)
    SetVehicleHandlingFloat(pVeh, 'CHandlingData', 'fDriveInertia', modify + 1.0)
    SetVehicleHandlingFloat(pVeh, 'CHandlingData', 'fBrakeForce', 2.0)
    SetVehicleHandlingFloat(pVeh, 'CHandlingData', 'fTractionCurveLateral', 10.0)
    SetVehicleHandlingFloat(pVeh, 'CHandlingData', 'fClutchChangeRateScaleUpShift', modify + 1.0)
    SetVehicleAlarm(pVeh, true)
    SetTimeout(3000, function()
        SetVehicleAlarm(pVeh, false)
    end)
end)

Alma:AddEventHandler("Staff", "Teleport", function(vector3)
	if (IS_NOCLIP) then
		SetCamCoord(CAMERA_NOCLIP, vector3)
		SetEntityCoords(PlayerPedId(), vector3)
	else
		SetEntityCoords(PlayerPedId(), vector3)
	end
end)

Alma:AddEventHandler("Jail", "Send", function(id, seconds, desc)
    Alma:TriggerServerEvent("Jail", "Put", id, seconds, desc)
end)

Alma:AddEventHandler("Staff", "FixVehicle", function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	SetVehicleFixed(vehicle)
	SetEntityHealth(vehicle, GetEntityMaxHealth(vehicle))
	SetVehicleDirtLevel(vehicle, 0.0)
end)

Alma:AddEventHandler("Staff", "History", function(result)
    SELECTED_PLAYER_TEBEX_HISTORY = result;
end)

Alma:AddEventHandler("Staff", "Pulsion", function(result)
    SELECTED_PLAYER_TEBEX_PULSION_COUNT = result;
end)

Alma:AddEventHandler("Staff", "DevMode", function(toogle)
    IN_DEVELOPPER_MODE = toogle;
end)

Alma:AddEventHandler("Staff", "DisableAction", function(result)
    RageUI.CloseAll()
    ESX.ShowNotification("Vous n'avez pas les permissions nécessaire !")
end)

RegisterKeyMapping('admin-open', 'Menu staff', 'keyboard', 'F10')

RegisterCommand("admin-open", function(source, args, rawCommand)
    if (PLAYER_ONLINE[GetPlayerServerId(PlayerId())].group ~= "user") then
        if not (SetEntityRagdoll) and not (IS_IN_SELECTING) and not (Alma.IsInJail) then
            OPEN_MENU()
        else
            ESX.ShowNotification("Vous ne pouvez pas effectuer une telle action en ce moment !")
        end
    else
        ESX.ShowNotification("Vous n'avez pas les permissions suffisante !")
    end
end, false)

RegisterKeyMapping('noclip-admin', 'Raccourci caméra libre', 'keyboard', 'F3')

RegisterCommand("noclip-admin", function(source, args, rawCommand)
    if (PLAYER_ONLINE[GetPlayerServerId(PlayerId())].group ~= "user") and not (SetEntityRagdoll) and not (IS_IN_SELECTING) then
        Alma:TriggerServerEvent("Staff", "ToggleNoclip", not IS_NOCLIP)
    else
        ESX.ShowNotification("Vous n'avez pas les permissions suffisante !")
    end
end, false)

function UPGRADE_VEH(veh)
	SetVehicleModKit(veh, 0)
	SetVehicleColours(veh, 12, 12)
	SetVehicleModColor_1(veh, 3, false)
	SetVehicleExtraColours(veh, 3, false)
	ToggleVehicleMod(veh, 18, true)
	ToggleVehicleMod(veh, 22, true)
	SetVehicleMod(veh, 16, 5, false)
	SetVehicleMod(veh, 12, 2, false)
	SetVehicleMod(veh, 11, 3, false)
	SetVehicleMod(veh, 14, 14, false)
	SetVehicleMod(veh, 15, 3, false)
	SetVehicleMod(veh, 13, 2, false)
	SetVehicleWindowTint(veh, 5)
	SetVehicleMod(veh, 23, 21, true)
	SetVehicleMod(veh, 0, 1, false)
	SetVehicleMod(veh, 1, 1, false)
	SetVehicleMod(veh, 2, 1, false)
	SetVehicleMod(veh, 3, 1, false)
	SetVehicleMod(veh, 4, 1, false)
	SetVehicleMod(veh, 5, 1, false)
	SetVehicleMod(veh, 6, 1, false)
	SetVehicleMod(veh, 7, 1, false)
	SetVehicleMod(veh, 8, 1, false)
	SetVehicleMod(veh, 9, 1, false)
	SetVehicleMod(veh, 10, 1, false)
	IsVehicleNeonLightEnabled(veh, true)
	SetVehicleNeonLightEnabled(veh, 0, true)
	SetVehicleNeonLightEnabled(veh, 1, true)
	SetVehicleNeonLightEnabled(veh, 2, true)
	SetVehicleNeonLightEnabled(veh, 3, true)
	SetVehicleNeonLightEnabled(veh, 4, true)
	SetVehicleNeonLightEnabled(veh, 5, true)
	SetVehicleNeonLightEnabled(veh, 6, true)
	SetVehicleNeonLightEnabled(veh, 7, true)
	SetVehicleModKit(veh, 0)
	ToggleVehicleMod(veh, 20, true)
	SetVehicleModKit(veh, 0)
	SetVehicleNumberPlateTextIndex(veh, true)
end

function Alma:SetNoclip(bool)
    if (bool) then
        if (CAMERA_NOCLIP == nil) then
            CAMERA_NOCLIP = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        end
        SetCamActive(CAMERA_NOCLIP, true)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(PlayerPedId(), true)
        if (GetVehiclePedIsIn(PlayerPedId(), false)) then
            SetEntityCollision(GetVehiclePedIsIn(PlayerPedId(), false), false, false)
            SetEntityVisible(GetVehiclePedIsIn(PlayerPedId(), false), false, false)
            FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), false), true)
        end
        SetCamCoord(CAMERA_NOCLIP, GetGameplayCamCoord())
        SetCamRot(CAMERA_NOCLIP, GetGameplayCamRot())
        if (GetVehiclePedIsIn(PlayerPedId(), false) == 0) and (PlayerPedId()) then
            SetEntityCollision(PlayerPedId(), false, false)
            SetEntityVisible(PlayerPedId(), false, false)
        end
        SetEveryoneIgnorePlayer(PlayerId(), true)
        SetEntityInvincible(PlayerPedId(), true)
        IS_NOCLIP = true;
    else
        local camCoords = GetCamCoord(CAMERA_NOCLIP)
        DestroyCam(CAMERA_NOCLIP)
        RenderScriptCams(false, false, 0, false, false)
        FreezeEntityPosition(PlayerPedId(), false)
        if (GetVehiclePedIsIn(PlayerPedId(), false)) then
            SetEntityCollision(GetVehiclePedIsIn(PlayerPedId(), false), true, true)
            SetEntityVisible(GetVehiclePedIsIn(PlayerPedId(), false), true)
            FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), false), false)
            SetEntityCoords(GetVehiclePedIsIn(PlayerPedId(), false), camCoords.x, camCoords.y, camCoords.z)
        end
        if (GetVehiclePedIsIn(PlayerPedId(), false) == 0) and (PlayerPedId()) then
            SetEntityCoords(PlayerPedId(), camCoords.x, camCoords.y, camCoords.z)
            SetEntityCollision(PlayerPedId(), true, true)
            SetEntityVisible(PlayerPedId(), true)
            if (GetVehiclePedIsIn(PlayerPedId(), false)) then
                SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), -1)
            end
        end
        SetEveryoneIgnorePlayer(PlayerId(), false)
        SetEntityInvincible(PlayerPedId(), false)
        CAMERA_NOCLIP = nil;
        IS_NOCLIP = false;
    end
end

RANDOM_COLOR = "~g~"

Citizen.CreateThread(function()
    while true do
        if (IS_IN_STAFF) then
            Citizen.Wait(0)
            if (RANDOM_COLOR == "~g~") then 
                RANDOM_COLOR = "~p~"
                Wait(500)
            elseif (RANDOM_COLOR == "~p~") then
                RANDOM_COLOR = "~g~"
                Wait(500)
            end
        else
            Citizen.Wait(750)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if (IS_IN_STAFF) then
            if (IS_IN_STAFF) and (IS_INTERFACE_ADMIN) and not IN_MAIN then
                if (GetVehiclePedIsIn(PlayerPedId(), false) == 0) then
                    Visual.FloatingHelpText("Administration : ~g~Actif~s~\nStaff en services : ~y~"..STAFF_ONLINE_COUNT.."~s~\nJoueurs en lignes : ~o~"..PLAYER_ONLINE_COUNT.."~s~\nReports en attente(s) : ~r~"..REPORTS_WAITING_COUNT.."~s~\n\nCaméra Libre : "..(IS_NOCLIP and "~g~Activé~s~" or "~r~Désactivé~s~").."\nGamertags : "..(IS_GAMER_TAG and "~g~Activé~s~" or "~r~Désactivé~s~"))
                else
                    Visual.FloatingHelpText("Administration : ~g~En Voiture~s~\nStaff en services : ~y~"..STAFF_ONLINE_COUNT.."~s~\nJoueurs en lignes : ~o~"..PLAYER_ONLINE_COUNT.."~s~\nReports en attente(s) : ~r~"..REPORTS_WAITING_COUNT.."~s~\n\nCaméra Libre : "..(IS_NOCLIP and "~g~Activé~s~" or "~r~Désactivé~s~").."\nGamertags : "..(IS_GAMER_TAG and "~g~Activé~s~" or "~r~Désactivé~s~"))
                end
            end
            if (IS_NOCLIP) then
                local camCoords = GetCamCoord(CAMERA_NOCLIP)
                local right, forward, _, _ = GetCamMatrix(CAMERA_NOCLIP)
                if IsControlPressed(0, 32) then
                    local newCamPos = camCoords + forward * NOCLIP_SPEED
                    SetCamCoord(CAMERA_NOCLIP, newCamPos.x, newCamPos.y, newCamPos.z)
                end
                if IsControlPressed(0, 8) then
                    local newCamPos = camCoords + forward * -NOCLIP_SPEED
                    SetCamCoord(CAMERA_NOCLIP, newCamPos.x, newCamPos.y, newCamPos.z)
                end
                if IsControlPressed(0, 34) then
                    local newCamPos = camCoords + right * -NOCLIP_SPEED
                    SetCamCoord(CAMERA_NOCLIP, newCamPos.x, newCamPos.y, newCamPos.z)
                end
                if IsControlPressed(0, 9) then
                    local newCamPos = camCoords + right * NOCLIP_SPEED
                    SetCamCoord(CAMERA_NOCLIP, newCamPos.x, newCamPos.y, newCamPos.z)
                end
                if IsControlPressed(0, 334) then
                    if (NOCLIP_SPEED - 0.1 >= 0.1) then
                        NOCLIP_SPEED = NOCLIP_SPEED - 0.1
                    end
                end
                if IsControlPressed(0, 335) then
                    if (NOCLIP_SPEED + 0.1 >= 0.1) then
                        NOCLIP_SPEED = NOCLIP_SPEED + 0.1
                    end
                end

                local xMagnitude = GetDisabledControlNormal(0, 1)
                local yMagnitude = GetDisabledControlNormal(0, 2)
                local camRot = GetCamRot(CAMERA_NOCLIP)
                local x = camRot.x - yMagnitude * 10
                local y = camRot.y
                local z = camRot.z - xMagnitude * 10
                if x < -75.0 then
                    x = -75.0
                end
                if x > 100.0 then
                    x = 100.0
                end
                if (GetVehiclePedIsIn(PlayerPedId(), false) == 0) and (PlayerPedId()) then
                    SetEntityCoords(PlayerPedId(), camCoords.x, camCoords.y, camCoords.z)
                    SetEntityRotation(PlayerPedId(), x, y, z)
                end
                if (GetVehiclePedIsIn(PlayerPedId(), false)) then
                    SetEntityCoords(GetVehiclePedIsIn(PlayerPedId(), false), camCoords.x, camCoords.y, camCoords.z)
                    SetEntityRotation(GetVehiclePedIsIn(PlayerPedId(), false), x, y, z)
                end
                SetCamRot(CAMERA_NOCLIP, x, y, z)
            end
            if (IS_GAMER_TAG) then 
                for _, id in ipairs(GetActivePlayers()) do
                    PLAYER_ID = GetPlayerServerId(id)
                    if PLAYER_ONLINE[PLAYER_ID] then
                        x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(id)))
                        textScreen = "["..PLAYER_ID.."] ["..Alma:GetLabelRankWithColor(PLAYER_ONLINE[PLAYER_ID].group).."] "..PLAYER_ONLINE[PLAYER_ID].name:gsub("~", "").." ["..PLAYER_ONLINE[PLAYER_ID].job.."]"
                        if NetworkIsPlayerTalking(PLAYER_ID) then
                            DrawMarker(1, x, y, z - 0.97, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 255, 0, 0, 100, 0, 0, 0, 0)
                            Helper:DrawText3D(x, y, z + 1, textScreen, 247, 124, 24, TEXT_SIZE_INDEX / 5)
                        else
                            Helper:DrawText3D(x, y, z + 1, textScreen, 255, 255, 255, TEXT_SIZE_INDEX / 5)
                        end
                    end
                end
            end
            if (IS_BLIPS_ACTIVE) then
                for _, player in pairs(GetActivePlayers()) do
                    local found = false
                    if player ~= PlayerId() then
                        local ped = GetPlayerPed(player)
                        local blip = GetBlipFromEntity( ped )
                        if not DoesBlipExist( blip ) then
                            blip = AddBlipForEntity(ped)
                            SetBlipCategory(blip, 7)
                            SetBlipScale( blip,  0.85 )
                            ShowHeadingIndicatorOnBlip(blip, true)
                            SetBlipSprite(blip, 1)
                            SetBlipColour(blip, 0)
                        end
                    
                        SetBlipNameToPlayerName(blip, player)
                    
                        local veh = GetVehiclePedIsIn(ped, false)
                        local blipSprite = GetBlipSprite(blip)
                    
                        if IsEntityDead(ped) then
                            if blipSprite ~= 303 then
                                SetBlipSprite( blip, 303 )
                                SetBlipColour(blip, 1)
                                ShowHeadingIndicatorOnBlip( blip, false )
                            end
                        elseif veh ~= nil then
                            if IsPedInAnyBoat( ped ) then
                                if blipSprite ~= 427 then
                                    SetBlipSprite( blip, 427 )
                                    SetBlipColour(blip, 0)
                                    ShowHeadingIndicatorOnBlip( blip, false )
                                end
                            elseif IsPedInAnyHeli( ped ) then
                                if blipSprite ~= 43 then
                                    SetBlipSprite( blip, 43 )
                                    SetBlipColour(blip, 0)
                                    ShowHeadingIndicatorOnBlip( blip, false )
                                end
                            elseif IsPedInAnyPlane( ped ) then
                                if blipSprite ~= 423 then
                                    SetBlipSprite( blip, 423 )
                                    SetBlipColour(blip, 0)
                                    ShowHeadingIndicatorOnBlip( blip, false )
                                end
                            elseif IsPedInAnyPoliceVehicle( ped ) then
                                if blipSprite ~= 137 then
                                    SetBlipSprite( blip, 137 )
                                    SetBlipColour(blip, 0)
                                    ShowHeadingIndicatorOnBlip( blip, false )
                                end
                            elseif IsPedInAnySub( ped ) then
                                if blipSprite ~= 308 then
                                    SetBlipSprite( blip, 308 )
                                    SetBlipColour(blip, 0)
                                    ShowHeadingIndicatorOnBlip( blip, false )
                                end
                            elseif IsPedInAnyVehicle( ped ) then
                                if blipSprite ~= 225 then
                                    SetBlipSprite( blip, 225 )
                                    SetBlipColour(blip, 0)
                                    ShowHeadingIndicatorOnBlip( blip, false )
                                end
                            else
                                if blipSprite ~= 1 then
                                    SetBlipSprite(blip, 1)
                                    SetBlipColour(blip, 0)
                                    ShowHeadingIndicatorOnBlip( blip, true )
                                end
                            end
                        else
                            if blipSprite ~= 1 then
                                SetBlipSprite( blip, 1 )
                                SetBlipColour(blip, 0)
                                ShowHeadingIndicatorOnBlip( blip, true )
                            end
                        end
                        if veh then
                            SetBlipRotation( blip, math.ceil( GetEntityHeading( veh ) ) )
                        else
                            SetBlipRotation( blip, math.ceil( GetEntityHeading( ped ) ) )
                        end
                    end
                end
            else
                for _, player in pairs(GetActivePlayers()) do
                    local blip = GetBlipFromEntity( GetPlayerPed(player) )
                    if blip ~= nil then
                        RemoveBlip(blip)
                    end
                end
            end
            Citizen.Wait(0)
        else
            Citizen.Wait(4000)
        end
    end
end)