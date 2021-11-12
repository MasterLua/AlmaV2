local CONNECTION_CAMERA = 0;

local IS_IN_SELECTING = false;

local CHARACTERS = nil;

local CHARACTER_FINISH = false;

AddEventHandler("esx:playerLoaded", function(xPlayer)
    PlayerData = xPlayer;
end)

Alma:AddEventHandler("OnPlayerInitialised", "Init", function(response)
    if CHARACTER_FINISH then return end
    IS_IN_SELECTING = true;
    TriggerEvent("pma-voice:mutePlayer")
    CHARACTERS = response
    DisplayRadar(false)
    local currentcam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    CONNECTION_CAMERA = 1;
    SetCamCoord(currentcam, 701.47, 1031.08, 330.57)
    ShakeCam(currentcam, "HAND_SHAKE", 0.1)
    SetCamRot(currentcam, -0, -0, -11.48)
    SetCamActive(currentcam, true)
    RenderScriptCams(1, 0, 500, false, false)
    Connecting()
    DoScreenFadeIn(2000)
    DisplayRadar(false)
    AnimpostfxStopAll()
end)

local sex = {
    ["m"] = "Homme",
    ["f"] = "Femme"
}

local function onSelectedPlayer(cId)
    IS_IN_SELECTING = false;
    CHARACTER_FINISH = true;
    Alma.Selecting = false
    RageUI.CloseAll();
    DoScreenFadeOut(5000)
    while not IsScreenFadedOut() do
        Citizen.Wait(0)
    end
    if (CONNECTION_CAMERA ~= 0) then
        DestroyCam(CONNECTION_CAMERA);
        ClearFocus()
        RenderScriptCams(false, false, false, 0, 0)
        CONNECTION_CAMERA = 0
    end
    DoScreenFadeIn(2000)
    if (CHARACTERS == nil) then
        Alma:TriggerServerEvent("Character", "SelectedCharacter", true)
    else
        Alma:TriggerServerEvent("Character", "SelectedCharacter", false)
        SetEntityCoordsNoOffset(PlayerPedId(), PlayerData.coords.x, PlayerData.coords.y, PlayerData.coords.z)
        FreezeEntityPosition(PlayerPedId(), false)
        Visual.Prompt("Chargement de votre position...", true)
        Citizen.Wait(2000)
        BusyspinnerOff();
    end
    while not IsScreenFadedIn() do
        Citizen.Wait(0)
    end
    TriggerEvent("pma-voice:mutePlayer")
    DisplayRadar(true)
    EnableControlAction(1, 199)
    EnableControlAction(1, 200)
end

local function Label(v)
    local firstname, lastname = "Inconnue", "Inconnue";
    if (v) then
        if (v.firstname ~= nil) then
            firstname = v.firstname
        end
        if (v.lastname ~= nil) then
            lastname = v.lastname
        end
    end
    return string.format("%s %s", firstname, lastname)
end

function Connecting()
    local MAIN_MENU = RageUI.CreateMenu("AlmaRP", "BIENVENUE SUR ALMARP");
    Alma.Selecting = true;
    MAIN_MENU.TitleFont = 2;
    MAIN_MENU.TitleScale = 1.2;
    MAIN_MENU.Closable = false;

    RageUI.Visible(MAIN_MENU, not RageUI.Visible(MAIN_MENU))

    while MAIN_MENU do
        Citizen.Wait(0)
        RageUI.IsVisible(MAIN_MENU, function()

            if (CHARACTERS == nil) then
                RageUI.Button("Crée votre personnage.", nil, {}, true, {
                    onSelected = function()
                        onSelectedPlayer(nil)
                    end
                });
            else
                for i, v in pairs(CHARACTERS) do
                    if (v ~= nil) then
                        local description = string.format("Sex : %s\nDate de naissance : %s\nArgent : %s $\nArgent sale : %s $\nArgent en banque : %s $", sex[v.sex] or "Inconnue", v.dateofbirth ~= nil and v.dateofbirth or "Inconnue", v.cash ~= nil and ESX.Math.GroupDigits(v.cash) or "Inconnue", v.dirtycash ~= nil and ESX.Math.GroupDigits(v.dirtycash) or "Inconnue", v.bank ~= nil and ESX.Math.GroupDigits(v.bank) or "Inconnue")
                        RageUI.Button(Label(v), description, {}, true, {
                            onSelected = function()
                                onSelectedPlayer(v.id)
                            end
                        });
                    end

                    RageUI.Button("Crée un autre personnage.", nil, {}, true, {
                        onSelected = function()
                            Visual.Subtitle("~y~Information~s~\nBientôt disponible.\nCette fonctionnalité n'est pas encore disponible", 2000)
                        end
                    });
                end
            end
            if not RageUI.Visible(MAIN_MENU) and not (IS_IN_SELECTING) then
                MAIN_MENU = RMenu:DeleteEntity("MAIN_MENU", true)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if (IS_IN_SELECTING) then
            if not (RageUI.Visible(MAIN_MENU)) then
                RageUI.CloseAll()
                Connecting()
            end
        else
            Citizen.Wait(1500)
        end
    end
end)