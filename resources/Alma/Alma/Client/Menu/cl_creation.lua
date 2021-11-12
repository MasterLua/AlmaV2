inCreation = false 
AntiCheat = false 

local FirstSpawn     = true
local PlayerLoaded   = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerLoaded = true
end)

RegisterNetEvent('openCreator')
AddEventHandler('openCreator', function(isFirst)
	CreateThread(function()
		while not PlayerLoaded do
			Wait(10)
		end
		if isFirst then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin == nil then
                    opencreator()
				else
                    TriggerEvent('skinchanger:loadSkin', skin)
				end
			end)
			FirstSpawn = false
		end
	end)
end)

local colorChange = "~r~"

Citizen.CreateThread(function()
    while true do
        Wait(5000)
        if colorChange == "~r~" then 
        colorChange = "~p~" 
        elseif colorChange == "~p~" then
            colorChange = "~o~"
        elseif colorChange == "~o~" then
            colorChange = "~y~"
        elseif colorChange == "~y~" then
            colorChange = "~g~"
    else 
        colorChange = "~r~" end
    end
end)

Creation = {
    valideperso = false,

    dadList = {"Benjamin", "Daniel", "Joshua", "Noah", "Andrew", "Juan", "Alex", "Isaac", "Evan", "Ethan", "Vincent", "Angel", "Diego", "Adrian", "Gabriel", "Michael", "Santiago", "Kevin", "Louis", "Samuel", "Anthony", "Pierre", "Niko"},
    motherList = {"Adelyn", "Emily", "Abigail", "Beverly", "Kristen", "Hailey", "June", "Daisy", "Elizabeth", "Addison", "Ava", "Cameron", "Samantha", "Madison", "Amber", "Heather", "Hillary", "Courtney", "Ashley", "Alyssa", "Mia", "Brittany"},

    IndexList = 1,
    visageIndex = 1,
    couleurpeauIndex = 1,
    hairIndex = 1,
    haircolorIndex = 1,
    haircolorpointIndex = 1,
    barbeIndex = 1,
    barbetailleIndex = 1,
    barbecolorIndex = 1,
    sourcilIndex = 1,
    sourciltailleIndex = 1,
    sourcilColorIndex = 1,
    couleuryeuxIndex = 1,
    makeupIndex = 1,
    epaisseurmakeupInex = 1,
    couleurmakeupIndex = 1,
    couleurmakeupIndex2 = 1,
    levreIndex = 1,
    levreepIndex = 1,
    levrecouleurIndex = 1,

    motherIndex = 1,
    dadIndex = 1,
    skinColorIndex = 5,
    skinColorIndex2 = 0.5,
    faceIndex = 5,
    faceIndex2 = 0.5,
    visageList = {},
    couleurpeauList = {},
    hairList = {},
    haircolorList = {},
    haircolorpointList = {},
    barbeList = {},
    barbetailleList = {},
    barbecolorList = {},
    sourcilList = {},
    sourciltailleList = {},
    sourcilColorList = {},
    couleuryeuxList = {},
    makeupList = {},
    epaisseurmakeupList = {},
    couleurmakeupList = {},
    couleurmakeupList2 = {},
    levreList = {},
    levreepList = {},
    levrecouleurList = {}
}

Citizen.CreateThread(function()
    --Cheveux
    for i = 1, 45 do
        table.insert(Creation.visageList, i)
    end
    for i = 1, 45 do
        table.insert(Creation.couleurpeauList, i)
    end

    for i = 1, 73 do
        table.insert(Creation.hairList, i)
    end
    for i = 1, 63 do
        table.insert(Creation.haircolorList, i)
    end
    for i = 1, 63 do
        table.insert(Creation.haircolorpointList, i)
    end
    --Barbe 
    for i = 1, 28 do
        table.insert(Creation.barbeList, i)
    end
    for i = 1, 10 do
        table.insert(Creation.barbetailleList, i)
    end
    for i = 1, 63 do
        table.insert(Creation.barbecolorList, i)
    end
    --Sourcils
    for i = 1, 33 do
        table.insert(Creation.sourcilList, i)
    end
    for i = 1, 10 do
        table.insert(Creation.sourciltailleList, i)
    end
    for i = 1, 10 do
        table.insert(Creation.sourcilColorList, i)
    end
    --Yeux
    for i = 1, 31 do
        table.insert(Creation.couleuryeuxList, i)
    end
    --Maquillage
    for i = 1, 80 do
        table.insert(Creation.makeupList, i)
    end
    for i = 1, 10 do
        table.insert(Creation.epaisseurmakeupList, i)
    end
    for i = 1, 63 do
        table.insert(Creation.couleurmakeupList, i)
    end
    for i = 1, 63 do
        table.insert(Creation.couleurmakeupList2, i)
    end
    --Rouge à lèvre
    for i = 1, 81 do
        table.insert(Creation.levreList, i)
    end
    for i = 1, 10 do
        table.insert(Creation.levreepList, i)
    end
    for i = 1, 63 do
        table.insert(Creation.levrecouleurList, i)
    end
end)


local maincreation = RageUI.CreateMenu('Création d\'identité', 'Créer votre personnage')
local verifident = RageUI.CreateSubMenu(maincreation, 'Vérification', 'Voici vos informations')
local apparence = RageUI.CreateSubMenu(maincreation, 'Apparence', "Vous permet de choisir votre apparence." )
local visage = RageUI.CreateSubMenu(apparence, 'Visage', "Vous permet de regler votre visage.")
local pillosite = RageUI.CreateSubMenu(visage, 'Pillosité', "Vous permet de regler votre pillosité.")
local tenue = RageUI.CreateSubMenu(pillosite, 'Tenue', "Vous permet de choisir votre tenue.")
maincreation:AddInstructionButton({
    [1] = GetControlInstructionalButton(0, 107, 0), 
})
maincreation.Closable = false

RegisterCommand("register", function(soruce, args, rawCommand)
    if not (Alma.IsInJail) and not (Alma.Selecting) then
        opencreator()
    end
end, false)

opencreator = function ()
    if inCreation == false then
        if inCreation then
            inCreation = false
        else
            inCreation = true
            FreezeEntityPosition(PlayerPedId(), true)
            SetEntityCoords(PlayerPedId(),  -542.68304443359,-208.32545471191, 37.649791717529  -0.98)
            TriggerEvent('skinchanger:change', 'sex', 0)
            RageUI.Visible(maincreation, true)
            Alma.Serv("PlayerRoutineBucket")
            CreateThread(function ()
                while inCreation do
                    Wait(0)
                    RageUI.IsVisible(maincreation, function ()

                        RageUI.Separator(colorChange..'Bienvenue sur Alma')

                        RageUI.Button(colorChange..'>~s~ Prénom', 'Ecrivez votre prénom', {RightLabel = prenomlabel}, true, {
                            onSelected = function ()
                                local prenom = KeyboardInput("Prenom", "Prenom", "", 10)
                                if tostring(prenom) == "" or prenom == nil then
                                    prenomlabel = "~r~Indéfini"
                                    nomkey = false
                                else
                                    prenomlabel = tostring(prenom)
                                    nomkey = true 
                                    local model = GetEntityModel(GetPlayerPed(-1))
                                    local keu = GetHashKey(model)
                                end
                            end
                        })

                        RageUI.Button(colorChange..'>~s~ Nom', 'Ecrivez votre nom', {RightLabel = nomlabel}, nomkey, {
                            onSelected = function ()
                                local nom = KeyboardInput("Nom", "Nom", "", 10)
                                if tostring(nom) == "" or nom == nil then
                                    nomlabel = "~r~Indéfini"
                                    datekey = false    
                                else 
                                    nomlabel = tostring(nom)
                                    datekey = true                         
                                end
                            end
                        })

                        RageUI.Button(colorChange..'>~s~ Date de naissance', 'Ecrivez votre date de naisance', {RightLabel = datelabel}, datekey, {
                            onSelected = function ()
                                local date = KeyboardInput("Date d'anniversaire", "Date d'anniversaire", "JJ/MM/AAAA", 10)
                                if tostring(date) == "" or date == nil then
                                    datelabel = "~r~Indéfini"
                                    taillekey = false    
                                else 
                                    datelabel = tostring(date)
                                    taillekey = true                         
                                end
                            end
                        })

                        RageUI.Button(colorChange..'>~s~ Taille', 'Définir votre taille (150-210)', {RightLabel = taillelabel}, taillekey, {
                            onSelected = function ()
                                local taille = KeyboardInput('Taille', 'Taille', '', 3)
                                if tostring(taille) == "" or taille == nil or tonumber(taille) > 210 then
                                    taillelabel = "Indéfini"
                                    sexekey = false
                                else
                                    taillelabel = tostring(taille)
                                    sexekey = true
                                end  
                            end
                        })

                        if sexekey then
                            verif, sexelabel = true, 'm'
                            RageUI.List(colorChange..">~s~ Sexe", {"Homme", "Femme"}, Creation.IndexList, nil, {}, sexekey, {
                                onListChange = function(Index) 
                                    if Creation.IndexList ~= Index then
                                        Creation.IndexList = Index 
                                        if Index == 1 then
                                            sexelabel = 'm'
                                            TriggerEvent('skinchanger:change', 'sex', 0)
                                            verif = true     
                                        elseif Index == 2 then
                                            TriggerEvent('skinchanger:change', 'sex', 1)
                                            verif = true   
                                            sexelabel = 'femme'
                                        end
                                    end
                                end, onActive = function(Index) end
                            }) 
                        end

                        RageUI.Button('Vérifier son identité', 'Vous permet de bien vérifier son identité', {RightLabel = "→→→"}, verif, {}, verifident )
                    end, function ()
                    end)

                    RageUI.IsVisible(verifident, function () 

                        RageUI.Separator("~h~Prénom : "..colorChange..prenomlabel)
                        RageUI.Separator("~h~Nom : "..colorChange..nomlabel)
                        RageUI.Separator("~h~Date de naissance: "..colorChange..datelabel)
                        RageUI.Separator("~h~Taille : "..colorChange..taillelabel)
                        RageUI.Separator("~h~Sexe : "..colorChange..sexelabel)
                        if prenomlabel then
                            AntiCheat = true
                        end
                        RageUI.Button('Valider cette identité ?', "Valider l'identité", {RightLabel = "→→→"}, true, {
                            onSelected = function ()
                                local name = GetPlayerName(PlayerId())
                                local id = GetPlayerServerId(PlayerId())
                            end
                        }, apparence)
                    end, function ()
                    end)
                    
                    RageUI.IsVisible(apparence, function()
                        RageUI.Window.Heritage(Creation.motherIndex, Creation.dadIndex)
                        RageUI.List(colorChange..">~s~ Père", Creation.dadList, Creation.dadIndex, nil, {}, true, {
                            onListChange = function(Index, Items)
                                Creation.dadIndex = Index
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'dad', Index)
                            end,
                        })
                        RageUI.List(colorChange..">~s~ Mère", Creation.motherList, Creation.motherIndex, nil, {}, true, {
                            onListChange = function(Index, Items)
                                Creation.motherIndex = Index
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'mom', Index)                                
                            end,
                        })
                        RageUI.UISliderHeritage(colorChange..">~s~  Peau", Creation.skinColorIndex, nil, { 
                            onSliderChange = function(Float, Index)
                                Creation.skinColorIndex = Index
                                Creation.skinColorIndex2 = Index/10
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'skin_md_weight', Creation.skinColorIndex2)                                
                            end
                        })
                        RageUI.UISliderHeritage(colorChange..">~s~  Visage", Creation.faceIndex, nil, {
                            onSliderChange = function(Float, Index)
                                Creation.faceIndex = Index
                                Creation.faceIndex2 = Index*10
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'face_md_weight', Creation.faceIndex2)
                            end
                        })
                        RageUI.Button("Valider son apparence", "", {RightLabel = "→→→"}, true, {
                            onSelected = function ()
                            end
                        }, pillosite)
                    end, function()
                    end)

                    RageUI.IsVisible(pillosite, function()

                        RageUI.Separator('~y~↓ ↓ Cheveux ↓ ↓')
                        RageUI.List("Cheveux", Creation.hairList, Creation.hairIndex, nil, {}, true, {
                            onListChange = function (Index, items)
                                Creation.hairIndex = Index
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'hair_1', Index)
                            end
                        })
                        RageUI.List("Couleur des cheveux", Creation.haircolorList, Creation.haircolorIndex, nil, {}, true, {
                            onListChange = function (Index, items)
                                Creation.haircolorIndex = Index
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'hair_color_1', Index)
                            end
                        })

                        RageUI.List("Couleur des pointes", Creation.haircolorpointList, Creation.haircolorpointIndex, nil, {}, true, {
                            onListChange = function (Index, items)
                                Creation.haircolorpointIndex = Index
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'hair_color_2', Index)
                            end
                        })

                        RageUI.Separator('~y~↓ ↓ Barbe ↓ ↓')
                        RageUI.List("Barbe", Creation.barbeList, Creation.barbeIndex, nil, {}, true, {
                            onListChange = function (Index, items)
                                Creation.barbeIndex = Index
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'beard_1', Index)
                            end
                        })
                        RageUI.List("Taille de la barbe", Creation.barbetailleList, Creation.barbetailleIndex, nil, {}, true, {
                            onListChange = function (Index, items)
                                Creation.barbetailleIndex = Index
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'beard_2', Index)
                            end
                        })
                        
                        RageUI.List("Couleur de la barbe", Creation.barbecolorList, Creation.barbecolorIndex, nil, {}, true, {
                            onListChange = function (Index, items)
                                Creation.barbecolorIndex = Index
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'beard_3', Index)
                            end
                        })
                        
                        RageUI.Separator('~y~↓ ↓ Sourcils ↓ ↓')
                        RageUI.List("Sourcil", Creation.sourcilList, Creation.sourcilIndex, nil, {}, true, {
                            onListChange = function (Index, items)
                                Creation.sourcilIndex = Index
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'eyebrows_1', Index)
                            end
                        })
                        RageUI.List("Taille des sourcils", Creation.sourciltailleList, Creation.sourciltailleIndex, nil, {}, true, {
                            onListChange = function (Index, items)
                                Creation.sourciltailleIndex = Index
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'eyebrows_2', Index)
                            end
                        })
                        RageUI.List("Couleur des sourcils", Creation.sourcilColorList, Creation.sourcilColorIndex, nil, {}, true, {
                            onListChange = function (Index, items)
                                Creation.sourcilColorIndex = Index
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'eyebrows_3', Index)
                            end
                        })
                        
                        RageUI.Button("Valider sa pillosité", nil, {RightLabel = "→→→"}, true, {
                            onSelected = function()
                            end
                        }, visage)

                    end, function()
                    end)

                    RageUI.IsVisible(visage, function()

                        RageUI.Separator('~y~↓ ↓ Yeux ↓ ↓')
                        RageUI.List("Couleur des yeux", Creation.couleuryeuxList, Creation.couleuryeuxIndex, nil, {}, true, {
                            onListChange = function (Index, items)
                                Creation.couleuryeuxIndex = Index
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'eye_color', Index)
                            end
                        })

                        RageUI.Separator('~y~↓ ↓ Maquillage ↓ ↓')
                        RageUI.List("Type de Maquillage", Creation.makeupList, Creation.makeupIndex, nil, {}, true, {
                            onListChange = function (Index, items)
                                Creation.makeupIndex = Index
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'makeup_1', Index)
                            end
                        })
                        RageUI.List("Epaisseur Maquillage", Creation.epaisseurmakeupList, Creation.epaisseurmakeupInex, nil, {}, true, {
                            onListChange = function (Index, items)
                                Creation.epaisseurmakeupInex = Index
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'makeup_2', Index)
                            end
                        })
                        RageUI.List("Couleur Maquillage", Creation.couleurmakeupList, Creation.couleurmakeupIndex, nil, {}, true, {
                            onListChange = function (Index, items)
                                Creation.couleurmakeupIndex = Index
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'makeup_3', Index)
                            end
                        })
                        RageUI.List("Couleur Maquillage Secondaire", Creation.couleurmakeupList2, Creation.couleurmakeupIndex2, nil, {}, true, {
                            onListChange = function (Index, items)
                                Creation.couleurmakeupIndex2 = Index
                                SetCamActiveWithInterp(cam4, cam3, 200, 1, 1)
                                TriggerEvent('skinchanger:change', 'makeup_4', Index)
                            end
                        })

                        RageUI.Separator('~y~↓ ↓ Rouge à lèvre ↓ ↓')
                        RageUI.List('Type de rouge à lèvre', Creation.levreList, Creation.levreIndex, nil, {}, true, {
                            onListChange = function (Index)
                                Creation.levreIndex = Index
                                TriggerEvent('skinchanger:change', 'lipstick_1', Index)
                            end
                        })
                        RageUI.List('Epaisseur du rouge à lèvre', Creation.levreepList, Creation.levreepIndex, nil, {}, true, {
                            onListChange = function (Index)
                                Creation.levreepIndex = Index
                                TriggerEvent('skinchanger:change', 'lipstick_2', Index)
                            end
                        })
                        RageUI.List('Couleur du rouge à lèvre', Creation.levrecouleurList, Creation.levrecouleurIndex, nil, {}, true, {
                            onListChange = function (Index)
                                Creation.levrecouleurIndex = Index
                                TriggerEvent('skinchanger:change', 'lipstick_3', Index)
                            end
                        })
                        
                        RageUI.Button("Valider son visage", nil, {RightLabel = "→→→"}, true, {
                            onSelected = function ()
                            end
                        }, tenue)

                    end, function()
                    end)

                    RageUI.IsVisible(tenue, function()

                        RageUI.Button('Tenue Ville', 'Vous permet d\'avoir une tenue pour la ville', {RightLabel = "→→→"}, true, {
                            onSelected = function ()
                                tville()
                            end
                        })

                        RageUI.Button('Tenue été', 'Vous permet d\'avoir une tenue pour l\'été', {RightLabel = "→→→"}, true, {
                            onSelected = function ()
                                tete()
                            end
                        })

                        RageUI.Button('Tenue sport', 'Vous permet d\'avoir une tenue pour le sport', {RightLabel = "→→→"}, true, {
                            onSelected = function ()
                                tsport()
                            end
                        })

                        RageUI.Button("Valider son personnage", "Valider votre personnage, pour rejoindre l'aventure Roleplay de ~r~AlmaRP~s~ !", {RightLabel = "→→→"}, true, {
                            onSelected = function ()                                
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    TriggerServerEvent('esx_skin:save', skin)
                                end)
                                valideperso()
                            end
                        })
                    end, function()
                    end)
                end
            end)
        end
    end
end

function tville()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01")then
            clothesSkin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 86, ['torso_2'] = 2,
                ['arms'] = 1,
                ['pants_1'] = 9, ['pants_2'] = 7,
                ['shoes_1'] =7, ['shoes_2'] = 0,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            }
        else
            clothesSkin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 14,['tshirt_2'] = 0,
                ['torso_1'] = 75, ['torso_2'] = 2,
                ['arms'] = 9, ['arms_2'] = 0,
                ['pants_1'] = 27, ['pants_2'] = 0,
                ['shoes_1'] = 3, ['shoes_2'] = 9,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end

function tete()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01")then
            clothesSkin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 111, ['tshirt_2'] = 0,
                ['torso_1'] = 5, ['torso_2'] = 2,
                ['arms'] = 5,
                ['pants_1'] = 12, ['pants_2'] = 0,
                ['shoes_1'] =5, ['shoes_2'] = 0,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            }
        else
            clothesSkin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 8,['tshirt_2'] = 0,
                ['torso_1'] = 74, ['torso_2'] = 0,
                ['arms'] = 15, ['arms_2'] = 0,
                ['pants_1'] = 44, ['pants_2'] = 0,
                ['shoes_1'] = 3, ['shoes_2'] = 0,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end

function tsport()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01")then
            clothesSkin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 1, ['tshirt_2'] = 4,
                ['torso_1'] = 7, ['torso_2'] = 2,
                ['arms'] = 1,
                ['pants_1'] = 5, ['pants_2'] = 1,
                ['shoes_1'] =8, ['shoes_2'] = 0,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            }
        else
            clothesSkin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 5, ['tshirt_2'] = 9,
                ['torso_1'] = 10, ['torso_2'] = 10,
                ['arms'] = 15,
                ['pants_1'] = 14, ['pants_2'] = 8,
                ['shoes_1'] = 4, ['shoes_2'] = 2,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['chain_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end

StarterPack = {
    { name = "Illégal", desc = "Devenez un vrai gangster, en prenant ce pack vous recevrez :\n\n+ 1 ~o~Scooter~s~\n+ 1 ~p~Batte~s~\n+ 25,000$ ~r~Argent Sale~s~\n+ 5,000$ ~g~Liquide~s~\n+ 200 ~b~Exp", value = "illegal"},
    { name = "Légal", desc = "Trouver un vrai métier grâce a ce pack vous recevrez :\n\n+ 1 ~o~Panto~s~\n+ 25,000$ ~g~Liquide~s~\n+ 5,000$ ~y~Banque~s~\n+ 100 ~b~Exp", value = "legal"},
    { name = "Business", desc = "Devenez un vrai business man grâce a ce pack vous recevrez :\n\n+ 1 ~o~BF-400~s~\n+ 30,000$ ~g~Banque~s~\n+ 400 ~b~Exp", value = "business"}
}

local selected = false;

valideperso = function()
    local ped = PlayerPedId()
    RageUI.CloseAll()
    inCreation = false
    FreezeEntityPosition(ped, false)
    DoScreenFadeOut(500)
    Wait(600)
    Wait(1000)
    DoScreenFadeIn(1000)
    ClearPedTasksImmediately(ped)
    ESX.ShowAdvancedNotification('Alma Information', 'Création', 'Vous avez créez votre personnage avec succès !', "CHAR_CALIFORNIA", 8)
    Alma.Serv("alma:identitecrea", prenomlabel, nomlabel, datelabel, taillelabel, sexelabel)
    SetEntityCoords(ped, 389.47817993164, -356.14352416992, 48.024032592773)
    SetEntityHeading(ped, 337.0)

    local startpack = RageUI.CreateMenu("Starter Pack", "Starter Pack")
    startpack.Closable = false;
    local AllStart = {}
    local AllStartIndex = 1;
    local ValueStart = nil

    table.insert(AllStart, { Name = "Aucun", Value = nil })
    for k,v in pairs(StarterPack) do
        table.insert(AllStart, { Name = v.name, Value = v.value })
    end

    RageUI.Visible(startpack, not RageUI.Visible(startpack))

    while startpack do
        Citizen.Wait(0)
        RageUI.IsVisible(startpack, function()
            if not selected then
                RageUI.List("Choix du type", AllStart, AllStartIndex, nil, {}, true, {
                    onListChange = function(Index, Item)
                        AllStartIndex = Index;
                        ValueStart = Item.Value
                    end,
                    onSelected = function()
                    end
                })
                for k,v in pairs(StarterPack) do
                    if ValueStart == nil or ValueStart == v.value then
                        RageUI.Button(v.name, v.desc, {RightLabel = "→→→"}, true, {
                            onSelected = function()
                                local input = Helper:KeyboardInput("Veuiller confirmer votre choix (~g~y~s~/~r~n~s~)", "n", 1, false)
                                if (type(input) == "string") and (input ~= nil) and (input:upper() == "Y") then
                                    selected = true
                                    Alma:TriggerServerEvent("Starter", "New", v.value)
                                    startpack.Closable = true;
                                else
                                    return Visual.Subtitle('~r~Starter pack : '..v.name..' annulé !')
                                end
                            end
                        })
                    end
                end
            end
        end)
        if not RageUI.Visible(startpack) then
            startpack = RMenu:DeleteType("startpack", true)
        end
    end
end