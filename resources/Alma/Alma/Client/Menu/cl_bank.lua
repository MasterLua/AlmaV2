BANKING_POSITION = {
    vector3(150.266, -1040.203, 29.374),
    vector3(-1212.980, -330.841, 37.787),
    vector3(-2962.582, 482.627, 15.703),
    vector3(-112.202, 6469.295, 31.626),
    vector3(314.187, -278.621, 54.170),
    vector3(-351.534, -49.529, 49.042),
    vector3(241.727, 220.706, 106.286),
    vector3(1175.064, 2706.643, 38.094)
}

local function inArea()
    Visual.FloatingHelpText("~g~Banque~s~ : Appuyer sur ~INPUT_CONTEXT~ pour parler au banquier.", true)
    if (IsControlJustPressed(0, 51)) then
        Banque(GetLabelText(GetNameOfZone(table.unpack(GetEntityCoords(PlayerPedId(), false)))))
    end
end

Citizen.CreateThread(function()
    for _,v in pairs(BANKING_POSITION) do
        Markers:Register({
            vector3 = v,
            distance = 10.0,
            size = 5.75,
            hidden = true,
            onArea = inArea,
        })
        local blip = AddBlipForCoord(v)
        SetBlipSprite(blip, 500)
        SetBlipScale(blip, 0.75)
        SetBlipColour(blip, 2)
        SetBlipAsShortRange(blip, false)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName("Banque - "..GetLabelText(GetNameOfZone(table.unpack(v))))
        EndTextCommandSetBlipName(blip)
	end
end)

function Banque(txt)
    local acc = 0;
    ESX.TriggerServerCallback("Bank:Account", function(response)
        acc = response;
    end)
    local banqueMenu = RageUI.CreateMenu("Banque", "VOTRE COMPTE EN BANQUE")
    local soldeCharge = false;
    SetTimeout(2000, function()
        soldeCharge = true;
    end)

    RageUI.Visible(banqueMenu, not RageUI.Visible(banqueMenu))

    while banqueMenu do
        Citizen.Wait(0)
        RageUI.IsVisible(banqueMenu, function()
            if soldeCharge then
                BusyspinnerOff()
                Visual.Subtitle("~g~Bienvenue à la banque de "..txt, 1)
                RageUI.Separator("Votre solde : ~o~"..ESX.Math.GroupDigits(acc)..".0 $")
                RageUI.Separator("↓");
                RageUI.Button("Déposer des fonds", nil, {}, true, {
                    onSelected = function()
                        local input = Helper:KeyboardInput("Combien souhaitez-vous déposer ?", 1, 20, false)
                        if (input ~= nil) then
                            Alma:TriggerServerEvent("Bank", "Deposit", tonumber(input))
                            ESX.TriggerServerCallback("Bank:Account", function(response)
                                acc = response;
                            end)
                        end
                    end
                })
                RageUI.Button("Retirer des fonds", nil, {}, true, {
                    onSelected = function()
                        local input = Helper:KeyboardInput("Combien souhaitez-vous retirer ?", 1, 20, false)
                        if (input ~= nil) then
                            if tonumber(acc) <= tonumber(input) then
                                Alma:TriggerServerEvent("Bank", "Withdraw", tonumber(input))
                                ESX.TriggerServerCallback("Bank:Account", function(response)
                                    acc = response;
                                end)
                            else
                                ESX.ShowNotification("~g~Pour effectuée cette transaction, il vous manque "..ESX.Math.GroupDigits(input-acc).." $")
                            end
                        end
                    end
                })
            else
                Visual.Prompt("Chargement du compte bancaire..", true)
                RageUI.Separator("")
                RageUI.Separator("Chargement..")
                RageUI.Separator("")
            end
        end)
        if not RageUI.Visible(banqueMenu) then
            banqueMenu = RMenu:DeleteType("banqueMenu", true)
        end
    end
end