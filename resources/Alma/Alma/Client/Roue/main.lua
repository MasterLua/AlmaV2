local baseCoords = 29.8
local basePos = vector3(236.00059509277, -880.18023681641, 30.492071151733)
local groundCoords = 29.392116928101

local roue, base, triangle, socle, veh, areEntityCreated = nil,nil,nil,nil,false
local veh_current = nil
local IS_ROLL = true;
local rolling_day = true;
local time_format = nil;
local can_roll = false;

local additionalProps = {
    {model = "prop_table_03", coords = vector3(226.24299621582, -885.10906982422, 29.492115020752), angle = 341.0},
    {model = "prop_direct_chair_01", coords = vector3(225.69311523438,-886.35662841797,29.492118835449), angle = 140.0},
    {model = "prop_streetlight_12b", coords = vector3(215.29782104492, -870.73107910156, 29.40), angle = 160.5},
    {model = "prop_beer_bottle", coords = vector3(225.82942199707,-885.12133789062,30.307487487793), angle = 60.0},
}

local function startSpin()
    Citizen.CreateThread(function()
        local pos = 7
        Visual.Subtitle("~c~~h~Vous tourner la roue de la fortune...", 1750)
        SetEntityRotation(roue, 0, 0, 160.0, false, true);

        local deg = 0.0;
        local inc = 1;

        -- First step, increment speed
        for i = 1,200 do
            SetEntityRotation(roue, 0, -deg, 160.0, false, true);
            deg = deg + inc;

            if inc < 4 then
                inc = inc + 0.2;
            end

            Citizen.Wait(5);
        end

        while math.ceil((deg - ((inc / 0.01) / 2) % 360 - pos) % 360) >= 5 do
            SetEntityRotation(roue, 0, -deg, 160.0, false, true);
            deg = deg + inc;
            Citizen.Wait(5);
        end

        Alma:TriggerServerEvent("Luckywheel", "RequestPrice")
        IS_ROLL = false;
    end)
end

Alma:AddEventHandler("Luckywheel", "man_veh", function(value)
    veh_current = value;
end)

Alma:AddEventHandler("Luckywheel", "man_roll", function(value)
    can_roll = value
end)

Alma:AddEventHandler("Luckywheel", "man_day", function(value)
    rolling_day = value
end)

Alma:AddEventHandler("Luckywheel", "man_time", function(value)
    time_format = value
end)

local function createAllWheelShits()
    -- Roue
    local model = GetHashKey('vw_prop_vw_luckywheel_02a')
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) end
    roue = CreateObject(model, vector3(234.31323242188, -880.28216552734, (baseCoords)), false, false)
    -- Base
    model = GetHashKey("vw_prop_vw_luckywheel_01a")
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) end
    base = CreateObject(model, vector3(234.31323242188, -880.28216552734, (baseCoords-0.3)), false, false)
    -- Triangle
    model = GetHashKey("vw_prop_vw_jackpot_on")
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) end
    triangle = CreateObject(model, vector3(234.31323242188, -880.28216552734, (baseCoords+2.5)), false, false)
    -- Socle
    model = GetHashKey("vw_prop_vw_casino_podium_01a")
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) end
    socle = CreateObject(model, vector3(226.07943725586, -877.56732177734, 29.392116928101), false, false)
    SetEntityRotation(roue, GetEntityPitch(roue), GetEntityRoll(roue), 160.0, 3, 1)
    SetEntityRotation(base, GetEntityPitch(base), GetEntityRoll(base), 160.0, 3, 1)
    SetEntityRotation(triangle, GetEntityPitch(triangle), GetEntityRoll(triangle), 160.0, 3, 1)
    -- Véhicule
    while veh_current == nil do Wait(1) end
    RequestModel(GetHashKey(veh_current))
    while not HasModelLoaded(model) do Wait(1) end
    ESX.Game.SpawnLocalVehicle(GetHashKey(veh_current), vector3(226.07943725586, -877.56732177734, 29.592116928101), 90.0, function(veh) 
        FreezeEntityPosition(veh, true)
        SetVehicleDoorsLocked(veh, 2)
        SetEntityInvincible(veh, true)
        SetVehicleFixed(veh)
        SetVehicleDirtLevel(veh, 0.0)
        SetVehicleEngineOn(veh, true, true, true)
        SetVehicleLights(veh, 2)
        SetVehicleCustomPrimaryColour(veh, 33,33,33)
        SetVehicleCustomSecondaryColour(veh, 33,33,33)
        local rot = 1.0
        while true do
            local interval = 1
            if areEntityCreated and socle ~= nil and veh ~= nil then
                rot = rot - 0.50
                SetEntityRotation(socle, GetEntityPitch(socle), GetEntityRoll(socle), rot, 3, 1)
                SetEntityHeading(veh, rot)
                interval = 150
            else
                interval = 750
            end
            Wait(interval)
        end
    end)
    for k,v in pairs(additionalProps) do
        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do Wait(1) end
        ESX.Game.SpawnObject(GetHashKey(v.model), v.coords, function(prop) 
            FreezeEntityPosition(prop, true)
            SetEntityRotation(prop, GetEntityPitch(prop), GetEntityRoll(prop), v.angle, 3, 1)
            additionalProps[k].entity = prop
        end)
    end
    areEntityCreated = true
end

AddEventHandler("esx:playerLoaded", function()
    createAllWheelShits()
end)


Citizen.CreateThread(function()
    local position = vector3(226, -885.9, 30.5)
	local entity = Pnj(26, GetHashKey("a_m_y_soucent_02"), vector4(position.x, position.y, position.z, 336.7949), 121090)

	local blip = AddBlipForCoord(position)
	SetBlipSprite(blip, 681)
    SetBlipColour(blip, 5)
    SetBlipScale(blip, 0.5)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName("Roue de la chance")
	EndTextCommandSetBlipName(blip)
    local tag = CreateFakeMpGamerTag(entity.ped, "Roue de la chance", true, false, 'NPC', 1)
    SetMpGamerTagBigText(tag, 'Bienvenue')
    SetMpGamerTagVisibility(tag, 2, 1)
    SetMpGamerTagAlpha(tag, 2, 255)
    SetMpGamerTagHealthBarColor(tag, 140)
    SetMpGamerTagIcons(tag, true)
    
    TaskStartScenarioInPlace(entity.ped, "WORLD_HUMAN_AA_COFFEE", -1, false)
	SetEntityCanBeDamaged(entity.ped, false)
	SetPedAsEnemy(entity.ped, false)
	SetBlockingOfNonTemporaryEvents(entity.ped, true)
	SetPedResetFlag(entity.ped, 249, true)
	SetPedConfigFlag(entity.ped, 185, true)
	SetPedConfigFlag(entity.ped, 108, true)
	SetPedCanEvasiveDive(entity.ped, false)
	SetPedCanRagdoll(entity.ped, false)
	SetPedConfigFlag(entity.ped, 208, true)
	SetPedCanRagdollFromPlayerImpact(entity.ped, false)
    Markers:Register({
        vector3 = vector3(227.5, -883.4, 30.5),
        distance = 10.0,
        size = 5.0,
        hidden = true,
        onArea = onLuckywheelArea,
    })
    Markers:Register({
        vector3 = vector3(235.5, -880.3, 30.5),
        distance = 2.0,
        size = 5.0,
        hidden = true,
        onArea = onLuckywheelTourneArea,
    })
end)

function LuckyArea()
    local luckyWheelMenu = RageUI.CreateMenu("Roue", "Roue de la chance", 1, 1200, "casinoui_lucky_wheel", "casinoui_lucky_wheel");
    luckyWheelMenu.TitleFont = 2;
    FreezeEntityPosition(PlayerPedId(), true)

    RageUI.Visible(luckyWheelMenu, not RageUI.Visible(luckyWheelMenu))

    while luckyWheelMenu do
        Citizen.Wait(0)
        RageUI.IsVisible(luckyWheelMenu, function()
            RageUI.Separator("↓ Tirage ↓")
            RageUI.Button(rolling_day == false and "~c~Prendre mon tour" or "~g~Prendre mon tour", (rolling_day == false and "Prochain ticket de roue : demain à "..time_format or nil), {}, (rolling_day == false and false or true), {
                onSelected = function()
                    Alma:TriggerServerEvent("Luckywheel", "RequestTicket")
                end
            })
            if not rolling_day then
                RageUI.Button("Payer un tour", "Vous donne un ticket a jouer !", {RightLabel = "~g~~h~75,000 $~s~"}, true, {
                    onSelected = function()
                        Alma:TriggerServerEvent("Luckywheel", "PayTicket")
                    end
                })
            end
            RageUI.Separator("↓ Aide ↓")
            RageUI.Button("Quesque c'est ?", "~h~Roue de la fortune : \n- C'est une roue de vous pouvez tourner tout ~g~les jours gratuitement~s~\n- Vous pouvez remporter des prix (~g~argents~s~, ~r~véhicule~s~, ~o~objects~s~)\n\nIl ne reste plus qu'à vous souhaiter bonne chance !", {}, true, {})
        end)
        if not RageUI.Visible(luckyWheelMenu) then
            FreezeEntityPosition(PlayerPedId(), false)
            luckyWheelMenu = RMenu:DeleteType("luckyWheelMenu", true)
        end
    end
end

function onLuckywheelTourneArea()
    if not RageUI.Visible(luckyWheelMenu) then
        if not rolling_day and can_roll then
            Visual.FloatingHelpText("~h~Appuyer sur ~INPUT_CONTEXT~ pour tourner la roue de la fortune.", false, false)
            if IsControlJustPressed(0, 51) then
                local playerPed = PlayerPedId()
                local _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@female'
                if IsPedMale(playerPed) then
                    _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@male'
                end
                local lib, anim = _lib, 'enter_right_to_baseidle'
                ESX.Streaming.RequestAnimDict(lib, function()
                    TaskGoStraightToCoord(playerPed,  basePos.x, basePos.y, (baseCoords),  1.0,  -1,  107.2,  0.0)
                    local hasMoved = false
                    while not hasMoved do
                        local coords = GetEntityCoords(PlayerPedId())
                        if coords.x >= (basePos.x - 0.01) and coords.x <= (basePos.x + 0.01) and coords.y >= (basePos.y - 0.01) and coords.y <= (basePos.y + 0.01) then
                            hasMoved = true
                        end
                        Citizen.Wait(0)
                    end
                    TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                    TaskPlayAnim(playerPed, lib, 'armraisedidle_to_spinningidle_high', 8.0, -8.0, -1, 0, 0, false, false, false)
                    startSpin()
                end)
            end
        else
            Visual.FloatingHelpText("~h~~r~Désolé~s~, mais il semblerait que vous ne puissez pas encore tourner la roue !", false, false)
        end
    end
end

function onLuckywheelArea()
    if not RageUI.Visible(luckyWheelMenu) then
        Visual.FloatingHelpText("~h~Appuyer sur ~INPUT_CONTEXT~ pour parler avec le personnage.", false, false)
        if IsControlJustPressed(0, 51) then
            LuckyArea()
        end
    end
end