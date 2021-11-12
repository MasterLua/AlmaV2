local List = {
    Actions = {
        "Déposer",
        "Prendre"
    },
    ActionIndex = 1,
    ActionButton = 1
}

local List2 = {
    Actions = {
        "Déposer",
        "Prendre"
    },
    ActionIndex = 1,
    ActionButton = 1
}

RegisterNetEvent('eSociety:openMenu')
AddEventHandler('eSociety:openMenu', function(society, position)
    OpenSocietyMenu(society, position)
end)

OpenSocietyMenu = function(society, position)
    local menu = RageUI.CreateMenu("Coffre", "Actions disponibles :")
    local data 
    local money
    local moneysale
    local load = false

    ESX.TriggerServerCallback("Core:GetSocietyInfo", function(result) 
        data = result.data
        money = result.money
        moneysale = result.moneysale
        load = true
    end, society.name)

    while not load do 
        Wait(1)
    end

    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Wait(0)
        RageUI.IsVisible(menu, function()

            RageUI.Separator("~b~Société : ~s~"..society.label)
            if ESX.PlayerData.job.grade_name == 'boss' then
                RageUI.Separator("~b~Argent Liquide : ~s~"..money.."$")
                RageUI.Separator("~b~Argent Sale : ~s~"..moneysale.."$")
                RageUI.Separator("")
                RageUI.List("Actions sur l'argent ", List.Actions, List.ActionIndex, nil, {}, true, {
                    onListChange = function(Index, Item)
                        List.ActionIndex = Index;
                        List.ActionButton = Index;
                    end,
                    onSelected = function()
                        if List.ActionButton == 1 then 
                            if UpdateOnscreenKeyboard() == 0 then return end
                            local string = KeyboardInput('Combien voulez vous déposer ?', '', '', 100)
                            if string ~= "" then
                                deposit = tonumber(string) 
                                TriggerServerEvent("Core:ActionMoneyToSocietyCache", society.name, "deposit", deposit)
                                OpenSocietyMenu({label = society.label, name = society.name }, position)
                            end
                        elseif List.ActionButton == 2 then
                            if UpdateOnscreenKeyboard() == 0 then return end
                            local string = KeyboardInput('Combien voulez vous prendre ?', '', '', 100)
                            if string ~= "" then
                                deposit = tonumber(string) 
                                TriggerServerEvent("Core:ActionMoneyToSocietyCache", society.name, "take", deposit)
                                OpenSocietyMenu({label = society.label, name = society.name }, position)
                            end
                        end
                    end
                })
                RageUI.List("Actions sur l'argent Sale ", List2.Actions, List2.ActionIndex, nil, {}, true, {
                    onListChange = function(Index, Item)
                        List2.ActionIndex = Index;
                        List2.ActionButton = Index;
                    end,
                    onSelected = function()    
                        if List2.ActionButton == 1 then 
                            if UpdateOnscreenKeyboard() == 0 then return end
                            local string = KeyboardInput('Combien voulez vous déposer ?', '', '', 100)
                            if string ~= "" then
                                deposit = tonumber(string) 
                                TriggerServerEvent("Core:ActionMoneysaleToSocietyCache", society.name, "deposit", deposit)
                                OpenSocietyMenu({label = society.label, name = society.name }, position)
                            end
                        elseif List2.ActionButton == 2 then
                            if UpdateOnscreenKeyboard() == 0 then return end
                            local string = KeyboardInput('Combien voulez vous prendre ?', '', '', 100)
                            if string ~= "" then
                                deposit = tonumber(string) 
                                TriggerServerEvent("Core:ActionMoneysaleToSocietyCache", society.name, "take", deposit)
                                OpenSocietyMenu({label = society.label, name = society.name }, position)
                            end
                        end
                    end
                })
            end
            RageUI.Button("Déposer dans le coffre", nil, {}, true, {
                onSelected = function()
                    Wait(150)
                    OpenSocietyPlayerInventoryMenu(society, position)
                end
            })
            RageUI.Button("Prendre dans le coffre", nil, {}, true, {
                onSelected = function()
                    Wait(150)
                    OpenSocietyInventoryMenu(society, position, data)
                end
            })

        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end

-- SOCIETYMENU

function OpenSocietyPlayerInventoryMenu(society, position)
    local menu = RageUI.CreateMenu("Déposer", "Contenu de vos poches :")

    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Wait(0)
        RageUI.IsVisible(menu, function()

            RageUI.Separator("~b~Que voulez-vous déposer ?")
            ESX.PlayerData = ESX.GetPlayerData()
            for i = 1, #ESX.PlayerData.inventory do
                if ESX.PlayerData.inventory[i].count > 0 then
                    RageUI.Button("• "..ESX.PlayerData.inventory[i].label, nil, { RightLabel = "Quantité(s) : ~r~x"..ESX.PlayerData.inventory[i].count }, true, {
                        onSelected = function()
                            if UpdateOnscreenKeyboard() == 0 then return end
                            local string = KeyboardInput('Combien voulez vous déposer ?', '', '', 100)
                            if string ~= "" then
                                deposit = tonumber(string)
                                if ESX.PlayerData.inventory[i].count >= deposit then
                                    TriggerServerEvent("Core:AddInventoryToSocietyCache", position, society.name, ESX.PlayerData.inventory[i].name, ESX.PlayerData.inventory[i].label, deposit)
                                else
                                    ESX.ShowNotification('~r~Erreur ~w~~n~Tu n\'as pas assez d\'objets sur toi')
                                end
                            end
                        end
                    })
                end
            end

        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
            OpenSocietyMenu({label = ESX.PlayerData.job.label, name = ESX.PlayerData.job.name }, position)
        end
    end
end

function OpenSocietyInventoryMenu(society, position, data)
    local menu = RageUI.CreateMenu("Prendre", "Contenu du coffre :")

    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Wait(0)
        RageUI.IsVisible(menu, function()
            RageUI.Separator("~b~Que voulez-vous prendre ?")
            for k,v in pairs(data) do
                if v.count ~= 0 then
                    RageUI.Button(v.label, nil, {RightLabel = "Quantité(s) : ~r~x"..v.count}, true, {
                        onSelected = function()
                            if UpdateOnscreenKeyboard() == 0 then return end
                            local string = KeyboardInput('Combien voulez vous prendre ?', '', '', 100)
                            if string ~= "" then
                                deposit = tonumber(string) 
                                if v.count >= deposit then
                                    TriggerServerEvent("Core:RemoveInventoryToSocietyCache", position, society.name, v.item, v.label, deposit)
                                    OpenSocietyMenu({label = ESX.PlayerData.job.label, name = ESX.PlayerData.job.name }, position)
                                else
                                    ESX.ShowNotification('~r~Erreur ~w~~n~Il n\'y a pas assez d\'objets dans le coffre')
                                end
                            end
                        end
                    })
                end
            end

        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
            OpenSocietyMenu({label = ESX.PlayerData.job.label, name = ESX.PlayerData.job.name }, position)
        end
    end
end

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

RegisterNetEvent("Core:Response")
AddEventHandler("Core:Response", function(response)
    for i, v in pairs(response) do
        local x, y, z = table.unpack(v.position)
        local blip = AddBlipForCoord(x, y, z)
        SetBlipSprite(blip, tonumber(v.blip_id))
        SetBlipColour(blip, tonumber(v.blip_color))
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("[Entreprise] - " .. v.label .. "")
        EndTextCommandSetBlipName(blip)
    end
end)