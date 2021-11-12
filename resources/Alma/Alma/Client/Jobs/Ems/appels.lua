Alma.newThread(function()
    Wait(2500)
    Alma.toServer('ewen:RetreiveIsDead')
end)

Alma.netRegisterAndHandle('ewen:PlayerIsDead', function()
    SetEntityHealth(PlayerPedId(), 0)
end)

local ReportListTable = {}

Alma.netRegisterAndHandle('ewen:UpdateTableSignalEms', function(table)
    ReportListTable = table
end)

local AppelsSelected = 0
local SrcSelected = 0
local AppelEnCours = false
local blip = nil
function OpenReportListEms()
    local menu = RageUI.CreateMenu('Emergency System', "Voici les appeles disponibles")
    local OpenSelectedAppel = RageUI.CreateSubMenu(menu, "Emergency System", 'Actions disponible')
    RageUI.Visible(menu, not RageUI.Visible(menu))
    while menu do
        Citizen.Wait(0)
        RageUI.IsVisible(menu, function()
            for k,v in pairs(ReportListTable) do
                RageUI.Separator('~p~Appel en Attente')
                if v.status == 0 then
                    RageUI.Button('Appel N*'..v.numbers, 'Description : '..v.raison, {RightLabel = 'Fait à '..v.heures..'h'..v.minutes.. 'm'..v.secondes..'s'}, true, {
                        onSelected = function() 
                            SrcSelected = v.src
                            AppelsSelected = v.numbers
                        end
                    }, OpenSelectedAppel)
                end
            end
            for k,v in pairs(ReportListTable) do
                RageUI.Separator('~p~Appel en Cours')
                if v.status == 1 then
                    RageUI.Button('Appel N*'..v.numbers, 'Description : '..v.raison..'\nAppel pris par ~p~'..v.EMSName, {RightLabel = 'Fait à '..v.heures..'h'..v.minutes.. 'm'..v.secondes..'s'}, true, {
                        onSelected = function() 
                            SrcSelected = v.src
                            AppelsSelected = v.numbers
                        end
                    }, OpenSelectedAppel)
                end
            end
        end, function()
        end)
        RageUI.IsVisible(OpenSelectedAppel, function()
            RageUI.Separator('')
            RageUI.Separator('Appel N*~p~'..AppelsSelected)
            print(ReportListTable[SrcSelected].status)
            if ReportListTable[SrcSelected].status == 1 then
                StatusText = 'Pris par ~p~'..ReportListTable[SrcSelected].EMSName
            else 
                StatusText = '~r~En Attente'
            end
            RageUI.Separator('Status : '..StatusText)
            RageUI.Separator('')
            if ReportListTable[SrcSelected].status == 0 then
                RageUI.Button('Prendre l\'appel','Permet de prendre l\'appel, Vos collegues seront informer', {RightLabel = '>'}, true, {
                    onSelected = function()
                        if not AppelEnCours then
                            AppelEnCours = true
                            blip = AddBlipForCoord(ReportListTable[SrcSelected].position)
                            SetBlipColour(blip, 60)
                            SetBlipRoute(blip, true)
                            ESX.ShowNotification('~p~Alma ~w~~n~Tu as pris l\'appel N*'..AppelsSelected)
                            Alma.toServer('EMS:UpdateReport', SrcSelected, true) --> TRUE = PRENDRE
                        else
                            ESX.ShowNotification('~p~Alma ~w~~n~Vous avez déjà un appel en cours\nCloture le pour en reprendre un.')
                        end
                    end
                })
            else
                if GetPlayerServerId(PlayerId()) == ReportListTable[SrcSelected].EMS_SRC then
                    RageUI.Button('Informer le patient de votre arriver',nil, {RightLabel = '>'}, true, {
                        onSelected = function()
                            Alma.toServer('EMS:InformPatient', SrcSelected)
                        end
                    })
                    RageUI.Button('Terminer l\'appel',nil, {RightLabel = '>'}, true, {
                        onSelected = function()
                            AppelEnCours = false
                            RemoveBlip(blip)
                            ESX.ShowNotification('~p~Alma ~w~~n~Vous avez terminer l\'intervention N*'..AppelsSelected)
                            Alma.toServer('EMS:UpdateReport', SrcSelected, false)
                        end
                    })
                end
            end
        end)

        if not RageUI.Visible(menu) and not RageUI.Visible(OpenSelectedAppel) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end

Alma.netRegisterAndHandle('EMS:ForceStopAppel', function()
    AppelEnCours = false
    RemoveBlip(blip)
end)