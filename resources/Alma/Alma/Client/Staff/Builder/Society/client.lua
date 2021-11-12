RegisterCommand("society-creator", function(source,args,rawCommand)
    SocietyCreator()
end, false)

local colorChange = "~r~"
local point = "."

Citizen.CreateThread(function()
    while true do
        Wait(1500)
        if colorChange == "~r~" then 
            colorChange = "~p~" 
        elseif colorChange == "~p~" then
            colorChange = "~o~"
        elseif colorChange == "~o~" then
            colorChange = "~y~"
        elseif colorChange == "~y~" then
            colorChange = "~g~"
        else 
            colorChange = "~r~" 
        end
        if point == "." then
            point = ".."
        elseif point == ".." then
            point = "..."
        elseif point == "..." then
            point = "."
        end
    end
end)

function SocietyCreator()
    local societyMenu = RageUI.CreateMenu("Jobs Builder", "Jobs Builder")
    local creatorJob = RageUI.CreateSubMenu(societyMenu, "Créer votre jobs", "Création de jobs")
    local Validate = false;
    Society = {
        nom = "Non Défini",
        label = "Non Défini",
        blip = false,
        sprite = nil,
        color = nil,
        rank = 1,
        marker = false,
        vestiairepos = nil,
        actionpatron = nil,
        pos = nil
    }

    RageUI.Visible(societyMenu, not RageUI.Visible(societyMenu))
    while societyMenu or creatorJob do
        Citizen.Wait(0)
        RageUI.IsVisible(societyMenu, function()
            RageUI.Separator("↓ ~y~Création de Jobs~s~ ↓")
            RageUI.Button("Créer votre job", "Créer votre job, ", {}, true, {
            }, creatorJob)
        end)
        RageUI.IsVisible(creatorJob, function()
            RageUI.Separator("→ "..colorChange.."Création en cours"..point.."~s~ ←")
            RageUI.Button("Nom du job", (Society.nom ~= "Non Défini" and "Défini : "..Society.nom or nil), {RightLabel = "Non Défini"}, (Society.nom == "Non Défini" and true or false), {
                onSelected = function()
                    local input = Helper:KeyboardInput("Nom du job ?", "police", 99, false)
                    if (type(input) == "string" and input ~= nil) then
                        Society.nom = input;
                    end
                end
            })
            RageUI.Button("Label du job", (Society.label ~= "Non Défini" and "Défini : "..Society.label or nil), {RightLabel = "Non Défini"}, (Society.label == "Non Défini" and true or false), {
                onSelected = function()
                    local input = Helper:KeyboardInput("Label du job ?", "Commissariat", 99, false)
                    if (type(input) == "string" and input ~= nil) then
                        Society.label = input;
                    end
                end
            })
            RageUI.List("Nombre de grade", {
                { Name = "1", Value = 1 },
                { Name = "2", Value = 2 },
                { Name = "3", Value = 3 },
                { Name = "4", Value = 4 },
                { Name = "5", Value = 5 },
                { Name = "6", Value = 6 },
                { Name = "7", Value = 7 }
            }, Society.rank, "Défini : "..Society.rank, {}, not Validate, {
                onListChange = function(Index, Item)
                    Society.rank = Index;
                end,
                onSelected = function(Index, Item)
                    Society.rank = Index;
                    Validate = true;
                end
            }) -- REDOUU ?
            RageUI.Separator("→ Informations Blips. ←")
            RageUI.Checkbox("Mettre un blip", nil, Society.blip, { }, {
                onSelected = function(Index)
                    Society.blip = Index;
                end
            })
            if (Society.blip) then
                RageUI.Button("Blip Sprite", (Society.sprite ~= nil and "Défini : "..Society.sprite or nil), {RightLabel = "Non Défini"}, (Society.sprite == nil and true or false), {
                    onSelected = function()
                        local input = Helper:KeyboardInput("Sprite du blip pour le job ?", "", 3, true)
                        if (type(input) == "number" and input ~= nil) then
                            Society.sprite = input;
                            Visual.Subtitle("~g~Valider~s~, Défini : "..tostring(input), 1000)
                        end
                    end
                })
                RageUI.Button("Blip Color", (type(Society.color) == "number" and "Défini : "..Society.color or nil), {RightLabel = "Non Défini"}, (Society.color == nil and true or false), {
                    onSelected = function()
                        local input = Helper:KeyboardInput("Color du blip pour le job ?", "", 3, true)
                        if (type(input) == "number" and input ~= nil) then
                            Society.color = input;
                            Visual.Subtitle("~g~Valider~s~, Défini : "..tostring(input), 1000)
                        end
                    end
                })
                RageUI.Button("Position du blip", (Society.pos == nil and "" or "Position : "..Society.pos), {RightLabel = Society.pos == nil and "Non Défini" or "Défini"}, true, {
                    onSelected = function()
                        Society.pos = GetEntityCoords(PlayerPedId());
                    end
                })
            end
            RageUI.Separator("→ Informations Markeur. ←")
            RageUI.Checkbox("Mettre des point (markeur)", nil, Society.marker, {}, {
                onSelected = function(Index)
                    Society.marker = Index;
                end
            })
            if (Society.marker) then
                RageUI.Button("Point du vestiaire", (Society.vestiaire == nil and "" or "Position : "..Society.vestiaire), {RightLabel = Society.vestiaire == nil and "Non Défini" or "Défini"}, true, {
                    onSelected = function()
                        Society.vestiaire = GetEntityCoords(PlayerPedId());
                    end
                })
                RageUI.Button("Point Coffre/Patron", (Society.actionpatron == nil and "" or "Position : "..Society.actionpatron), {RightLabel = Society.actionpatron == nil and "Non Défini" or "Défini"}, true, {
                    onSelected = function()
                        Society.actionpatron = GetEntityCoords(PlayerPedId());
                    end
                })
            end
            if (type(Society.color == "number")) and (Society.actionpatron ~= nil) and (Society.vestiaire ~= nil) and (Society.pos ~= nil) and (type(Society.color) == "number") and (type(Society.sprite) == "number") then
                RageUI.Separator("→ Poursuivre la création. ←")
                RageUI.Button("~HUD_COLOUR_DEGEN_GREEN~Poursuivre la création", nil, {}, true, {
                    onSelected = function()

                    end
                }, nextCreatorJob)
            end
        end)
        if not RageUI.Visible(societyMenu) and not RageUI.Visible(creatorJob) then
            societyMenu = RMenu:DeleteType("societyMenu", true)
            creatorJob = RMenu:DeleteType("creatorJob", true)
        end
    end
end
