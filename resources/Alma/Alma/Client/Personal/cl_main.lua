RegisterKeyMapping('+rageui-f5', 'Ouvrir le menu personnel', 'keyboard', 'f5')

RegisterCommand("+rageui-f5", function()
    MainPersonal()
end, false)

local settings = {
    color = {
        [1] = 0,
        [2] = 0,
        [3] = 0
    }
}


local c1 = {
    [1] = "torso",
    [2] = "pants",
    [3] = "shoes",
    [4] = "bag",
    [5] = "bproof"
}

local texts = {
    ["c1_torso"] = "Haut",
    ["c1_pants"] = "Bas",
    ["c1_shoes"] = "Chaussures",
    ["c1_bag"] = "Sac",
    ["c1_bproof"] = "Gilet pare-balle",
    ["c2_Ears"] = "Oreillette",
    ["c2_Glasses"] = "Lunettes",
    ["c2_Helmet"] = "Casque",
    ["c2_Mask"] = "Masque"
}

local function getText(str)
    return (texts[str] or "err")
end

local function startAnimAction(lib, anim)
    ESX.Streaming.RequestAnimDict(lib)
    Visual.Subtitle("Animations..", 854)
    TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, 1.0, -1, 49, 0, false, false, false)
    RemoveAnimDict(lib)
end

local function setUniform(value, plyPed)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:getSkin', function(skina)
            if value == 'torso' then
                startAnimAction('clothingtie', 'try_tie_neutral_a')
                Citizen.Wait(1000)
                ClearPedTasks(plyPed)

                if skin.torso_1 ~= skina.torso_1 then
                    TriggerEvent('skinchanger:loadClothes', skina, { ['torso_1'] = skin.torso_1, ['torso_2'] = skin.torso_2, ['tshirt_1'] = skin.tshirt_1, ['tshirt_2'] = skin.tshirt_2, ['arms'] = skin.arms })
                else
                    TriggerEvent('skinchanger:loadClothes', skina, { ['torso_1'] = 15, ['torso_2'] = 0, ['tshirt_1'] = 15, ['tshirt_2'] = 0, ['arms'] = 15 })
                end
            elseif value == 'pants' then
                if skin.pants_1 ~= skina.pants_1 then
                    TriggerEvent('skinchanger:loadClothes', skina, { ['pants_1'] = skin.pants_1, ['pants_2'] = skin.pants_2 })
                else
                    if skin.sex == 0 then
                        TriggerEvent('skinchanger:loadClothes', skina, { ['pants_1'] = 61, ['pants_2'] = 1 })
                    else
                        TriggerEvent('skinchanger:loadClothes', skina, { ['pants_1'] = 15, ['pants_2'] = 0 })
                    end
                end
            elseif value == 'shoes' then
                if skin.shoes_1 ~= skina.shoes_1 then
                    TriggerEvent('skinchanger:loadClothes', skina, { ['shoes_1'] = skin.shoes_1, ['shoes_2'] = skin.shoes_2 })
                else
                    if skin.sex == 0 then
                        TriggerEvent('skinchanger:loadClothes', skina, { ['shoes_1'] = 34, ['shoes_2'] = 0 })
                    else
                        TriggerEvent('skinchanger:loadClothes', skina, { ['shoes_1'] = 35, ['shoes_2'] = 0 })
                    end
                end
            elseif value == 'bag' then
                if skin.bags_1 ~= skina.bags_1 then
                    TriggerEvent('skinchanger:loadClothes', skina, { ['bags_1'] = skin.bags_1, ['bags_2'] = skin.bags_2 })
                else
                    TriggerEvent('skinchanger:loadClothes', skina, { ['bags_1'] = 0, ['bags_2'] = 0 })
                end
            elseif value == 'bproof' then
                startAnimAction('clothingtie', 'try_tie_neutral_a')
                Citizen.Wait(1000)
                ClearPedTasks(plyPed)

                if skin.bproof_1 ~= skina.bproof_1 then
                    TriggerEvent('skinchanger:loadClothes', skina, { ['bproof_1'] = skin.bproof_1, ['bproof_2'] = skin.bproof_2 })
                else
                    TriggerEvent('skinchanger:loadClothes', skina, { ['bproof_1'] = 0, ['bproof_2'] = 0 })
                end
            end
        end)
    end)
end

function MainPersonal()
    local DoorList = { "~g~Avant-Gauche~s~", "~g~Avant-Droite~s~", "~g~Arrière-Gauche~s~", "~g~Arrière-Droite~s~" }
    local personalMenu = RageUI.CreateMenu("Personnel", string.upper(GetPlayerName(PlayerId()):gsub("~", "")))
    local persoMenu = RageUI.CreateSubMenu(personalMenu, "Personaliser", "Que voulez-vous faire ?")
    local paramMenu = RageUI.CreateSubMenu(personalMenu, "Paramètres", "Que voulez-vous faire ?")
    local rockMenu = RageUI.CreateSubMenu(paramMenu, "Rockstar", "Que voulez-vous faire ?")
    local pedsMenu = RageUI.CreateSubMenu(personalMenu, "Peds", "Quel peds voulez-vous prendre?")
    local pedsValueMenu = RageUI.CreateSubMenu(pedsMenu, "Peds", "Quel peds voulez-vous prendre?")
    local vetMenu = RageUI.CreateSubMenu(personalMenu, "Vêtement(s)", "Que voulez-vous faire ?")
    local vhMenu = RageUI.CreateSubMenu(personalMenu, "Véhicule", "Que voulez-vous faire ?")
    local DoorIndex = 1;
    local lol = true;
    local PedsValue = nil;
    local vip = 0;
    ESX.TriggerServerCallback("AlmaVIP:getVip", function(response) 
        vip = response
    end)

    RageUI.Visible(personalMenu, not RageUI.Visible(personalMenu))

    while personalMenu do
        Citizen.Wait(0)
        RageUI.IsVisible(personalMenu, function()
            RageUI.Separator("~s~["..GetPlayerName(PlayerId())..""..(vip == 1 and "~s~, ~y~VIP Gold~s~]" or vip == 2 and "~s~, ~b~VIP Diamond~s~]" or "~s~, ~r~Aucun VIP~s~]"))
            RageUI.Button("Inventaire", (vip == 1 and "Vous êtes ~y~VIP Gold~s~, mais pour avoir un inventaire doublé vous devez être ~b~VIP Diamond~s~ !" or vip == 2 and "Vous êtes ~b~VIP Diamond~s~, vous avez donc inventaire double ce qui veux dire 48kg ou lieu de 24kg !" or "Vous n'êtes pas ~r~VIP~s~, si vous vous abonnée a notre ~b~VIP Diamond~s~, vous aurez inventaire double !"), { RightLabel = "→→→" }, true, {
                onSelected = function()
                    Inventory()
                end
            })
            RageUI.Button("Démarche", "~r~Ce boutton vas ouvrir un autre menu", { RightLabel = "→→→"  }, true, {
                onSelected = function()
                    ExecuteCommand("demarche")
                end
            })
            RageUI.Button("Animations", "~r~Ce boutton vas ouvrir un autre menu", { RightLabel = "→→→" }, true, {
                onSelected = function()
                    ExecuteCommand("animmenu")
                end
            })
            if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
                RageUI.Button("Véhicules", "Gérer votre véhicule depuis l'intérieur ! 😉", {RightLabel = "→→→"}, true, {

                }, vhMenu)
            end
            RageUI.Button("Vêtements", nil, {RightLabel = "→→→"}, true, {

            }, vetMenu)
            if (vip == 1) or (vip == 2) then
                local safe = GetSafeZone()
                if safe then
                    RageUI.Button("Peds", nil, {RightLabel = "→→→"}, true, {

                    }, pedsMenu)
                else
                    RageUI.Button("~c~Peds", nil, { }, false, {

                    }, pedsMenu)
                end
            else
                RageUI.Button("~c~Peds", "Vous devez être ~c~VIP~s~, pour bénificier d'un accès au Peds !", { }, true, {

                })
            end
                RageUI.Button("Paramètre(s)", nil, {RightLabel = "→→→"}, true, {

                }, paramMenu)
            end)
        RageUI.IsVisible(vhMenu, function()
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            RageUI.Button("Allumer/Eteindre le moteur", nil, {}, true, {
                onSelected = function()
                    if GetIsVehicleEngineRunning(veh) then
                        SetVehicleEngineOn(veh, false, false, true)
                        SetVehicleUndriveable(veh, true)
                    elseif not GetIsVehicleEngineRunning(veh) then
                        SetVehicleEngineOn(veh, true, false, true)
                        SetVehicleUndriveable(veh, false)
                    end
                end
            })
            RageUI.List("Ouvrir/Fermer Porte", DoorList, DoorIndex, nil, {}, true, {
                onListChange = function(Index)
                    DoorIndex = Index
                end,
                onSelected = function()
                    if Index == 1 then
                        if not DoorState.FrontLeft then
                            DoorState.FrontLeft = true
                            SetVehicleDoorOpen(veh, 0, false, false)
                        elseif DoorState.FrontLeft then
                            DoorState.FrontLeft = false
                            SetVehicleDoorShut(veh, 0, false, false)
                        end
                    elseif Index == 2 then
                        if not DoorState.FrontRight then
                            DoorState.FrontRight = true
                            SetVehicleDoorOpen(veh, 1, false, false)
                        elseif DoorState.FrontRight then
                            DoorState.FrontRight = false
                            SetVehicleDoorShut(veh, 1, false, false)
                        end
                    elseif Index == 3 then
                        if not DoorState.BackLeft then
                            DoorState.BackLeft = true
                            SetVehicleDoorOpen(veh, 2, false, false)
                        elseif DoorState.BackLeft then
                            DoorState.BackLeft = false
                            SetVehicleDoorShut(veh, 2, false, false)
                        end
                    elseif Index == 4 then
                        if not DoorState.BackRight then
                            DoorState.BackRight = true
                            SetVehicleDoorOpen(veh, 3, false, false)
                        elseif DoorState.BackRight then
                            DoorState.BackRight = false
                            SetVehicleDoorShut(veh, 3, false, false)
                        end
                    end
                end
            })
            RageUI.Button("Ouvrir/Fermer Capot", nil, {}, true, {
                onSelected = function()
                    if not DoorState.Hood then
                        DoorState.Hood = true
                        SetVehicleDoorOpen(veh, 4, false, false)
                    elseif DoorState.Hood then
                        DoorState.Hood = false
                        SetVehicleDoorShut(veh, 4, false, false)
                    end
                end
            })

            RageUI.Button("Ouvrir/Fermer Coffre", nil, {}, true, {
                onSelected = function()
                    if not DoorState.Trunk then
                        DoorState.Trunk = true
                        SetVehicleDoorOpen(veh, 5, false, false)
                    elseif DoorState.Trunk then
                        DoorState.Trunk = false
                        SetVehicleDoorShut(veh, 5, false, false)
                    end
                end
            })
        end)
        RageUI.IsVisible(vetMenu, function()
            for i = 1, #c1 do
                RageUI.Button(getText(("c1_%s"):format(c1[i])), nil, { RightBadge = RageUI.BadgeStyle.Clothes }, true, {
                    onSelected = function()
                        setUniform(c1[i], PlayerPedId())
                    end
                })
            end
        end)
        RageUI.IsVisible(pedsMenu, function()
            RageUI.Button("Reprendre mon apparence", nil, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
                        if skin.sex == 1 then
                            local hash = GetHashKey("mp_f_freemode_01")
                            while not HasModelLoaded(hash)
                            do RequestModel(hash)
                                Citizen.Wait(0)
                            end
                            SetPlayerModel(PlayerId(), hash)
                            TriggerEvent("skinchanger:loadSkin", skin)
                            TriggerEvent("esx:restoreLoadout")
                            ESX.ShowNotification("~o~Vous avez repris votre apparence !")
                        else
                            local hash = GetHashKey("mp_m_freemode_01")
                            while not HasModelLoaded(hash)
                            do RequestModel(hash)
                                Citizen.Wait(0)
                            end
                            SetPlayerModel(PlayerId(), hash)
                            TriggerEvent("skinchanger:loadSkin", skin)
                            TriggerEvent("esx:restoreLoadout")
                            ESX.ShowNotification("~o~Vous avez repris votre apparence !")
                        end
                    end)
                end
            })
            RageUI.Separator("")
            for k,v in pairs(PEDS_LIST) do
                RageUI.Button(v.cat_name, nil, {RightLabel = v.rightLabel}, true, {
                    onSelected = function()
                        PedsValue = v.value
                    end
                }, pedsValueMenu)
            end
        end)
        RageUI.IsVisible(pedsValueMenu, function()
            RageUI.Button("Reprendre mon apparence", nil, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
                        if skin.sex == 1 then
                            local hash = GetHashKey("mp_f_freemode_01")
                            while not HasModelLoaded(hash)
                            do RequestModel(hash)
                                Citizen.Wait(0)
                            end
                            SetPlayerModel(PlayerId(), hash)
                            TriggerEvent("skinchanger:loadSkin", skin)
                            TriggerEvent("esx:restoreLoadout")
                            ESX.ShowNotification("~o~Vous avez repris votre apparence !")
                        else
                            local hash = GetHashKey("mp_m_freemode_01")
                            while not HasModelLoaded(hash)
                            do RequestModel(hash)
                                Citizen.Wait(0)
                            end
                            SetPlayerModel(PlayerId(), hash)
                            TriggerEvent("skinchanger:loadSkin", skin)
                            TriggerEvent("esx:restoreLoadout")
                            ESX.ShowNotification("~o~Vous avez repris votre apparence !")
                        end
                    end)
                end
            })
            RageUI.Separator("↓ ~o~Peds Disponible~s~ ↓")
            for i, l in pairs(PEDS_LIST) do
                if l.value == PedsValue then
                    for k,v in pairs(l.peds) do
                        RageUI.Button(v.name, nil, {RightLabel = "→→→"}, lol, {
                            onSelected = function()
                                local hash = GetHashKey(v.hash)
                                RequestModel(hash)
                                while not HasModelLoaded(hash)
                                do RequestModel(hash)
                                    Citizen.Wait(0)
                                end
                                SetPlayerModel(PlayerId(), hash)
                                TriggerEvent("esx:restoreLoadout")
                                lol = false
                                SetTimeout(10000, function()
                                    lol = true
                                end)
                            end
                        })
                    end
                end
            end
        end)
        RageUI.IsVisible(paramMenu, function()
            RageUI.Button("Personnaliser le menu", nil, {}, true, {
                onSelected = function()
                    settings.color[1] = GetResourceKvpInt("menuR")
                    settings.color[2] = GetResourceKvpInt("menuG")
                    settings.color[3] = GetResourceKvpInt("menuB")
                end
            }, persoMenu)
            RageUI.Button("Rockstar", nil, {}, true, {

            }, rockMenu)
            RageUI.Button("Activer le réticule personnalisé", "Option réservé au ~y~VIP", {}, (vip == 1 and true or vip == 2 and true or false), {
                onSelected = function()
                    ExecuteCommand("cross")
                end
            })
            RageUI.Button("Modifier le réticule personnalisé", "Option réservé au ~y~VIP", {}, (vip == 1 and true or vip == 2 and true or false), {
                onSelected = function()
                    ExecuteCommand("crosse")
                    RageUI.CloseAll()
                end
            })
            RageUI.Button("Rénitialiser le réticule personnalisé", "Option réservé au ~y~VIP", {}, (vip == 1 and true or vip == 2 and true or false), {
                onSelected = function()
                    ExecuteCommand("crossr")
                end
            })
        end)
        RageUI.IsVisible(rockMenu, function()
            RageUI.Button("Stop/save record", nil, {}, true, {
                onSelected = function()
                    StopRecordingAndSaveClip()
                end
            })
            RageUI.Button("Stop/discard record", nil, {}, true, {
                onSelected = function()
                    StopRecordingAndDiscardClip()
                end
            })
            RageUI.Button("Start record", nil, {}, true, {
                onSelected = function()
                    StartRecording()
                end
            })
            --[[RageUI.Button("Open editor", nil, {}, true, {
                onSelected = function()
                    NetworkSessionLeaveSinglePlayer()
                    ActivateRockstarEditor()
                end
            })]]
        end)
        RageUI.IsVisible(persoMenu, function()
            RageUI.Slider('Rouge', settings.color[1], 255, "Selectionner sur : "..settings.color[1], true, {}, true, {
                onSliderChange = function(Color)
                    settings.color[1] = Color
                    persoMenu:SetRectangleBanner(settings.color[1], settings.color[2], settings.color[3], 100)
                end,
                onSelected = function(Index)

                end
            })
            RageUI.Slider('Vert', settings.color[2], 255, "Selectionner sur : "..settings.color[2], true, {}, true, {
                onSliderChange = function(Color)
                    settings.color[2] = Color
                    persoMenu:SetRectangleBanner(settings.color[1], settings.color[2], settings.color[3], 100)
                end,
                onSelected = function(Index)

                end
            })
            RageUI.Slider('Bleu', settings.color[3], 255, "Selectionner sur : "..settings.color[3], true, {}, true, {
                onSliderChange = function(Color)
                    settings.color[3] = Color
                    persoMenu:SetRectangleBanner(settings.color[1], settings.color[2], settings.color[3], 100)
                end,
                onSelected = function(Index)

                end
            })

            RageUI.Separator("")

            RageUI.Button("Sauvegarder", nil, {}, true, {
                onSelected = function()
                    SetResourceKvpInt("menuR", settings.color[1])
                    SetResourceKvpInt("menuG", settings.color[2])
                    SetResourceKvpInt("menuB", settings.color[3])
                end
            })
        end)
        if not RageUI.Visible(personalMenu) and not RageUI.Visible(paramMenu) and not RageUI.Visible(rockMenu) and not RageUI.Visible(persoMenu) and not RageUI.Visible(pedsMenu) and not RageUI.Visible(pedsValueMenu) and not RageUI.Visible(vhMenu) and not RageUI.Visible(vetMenu) then
            paramMenu = RMenu:DeleteType("paramMenu", true)
            rockMenu = RMenu:DeleteType("rockMenu", true)
            persoMenu = RMenu:DeleteType("persoMenu", true)
            personalMenu = RMenu:DeleteType("personalMenu", true)
            pedsMenu = RMenu:DeleteType("pedsMenu", true)
            vhMenu = RMenu:DeleteType("vhMenu", true)
            vetMenu = RMenu:DeleteType("vetMenu", true)
            pedsValueMenu = RMenu:DeleteType("pedsValueMenu", true)
        end
    end
end