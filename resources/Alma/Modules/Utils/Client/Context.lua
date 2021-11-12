local ContextUI = {
    Entity = {
        ID = nil,
        Type = nil,
        Model = nil,
        NetID = nil,
        ServerID = nil,
    },
    Menus = {},
    Focus = false,
    Open = false,
    Position = vector2(0.0, 0.0),
    Offset = vector2(0.0, 0.0),
    Options = 0,
    Category = "main",
    CategoryID = 0,
    Description = nil,
}

local Settings = {
    Button = {
        Width = 220,
        Height = 32,
        Background = {
            { 22, 25, 35, 226 },
            { 255, 222, 5, 200 }
        }
    },
    Text = {
        Colors = {
            { 255, 255, 255, 255 },
            { 255, 255, 255, 255 }
        },
        X = 8.0,
        Y = 4.5,
        Scale = 0.26,
        Font = 0,
        Center = 0,
        Outline = false,
        DropShadow = false,
    },
    Title = {
        Background = { 5, 5, 5, 255 },
        Text = { 255, 255, 255, 255 }
    }
}

Alma.IsSeating = false;

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 19) then
            ContextUI.Focus = true
        end

        if IsDisabledControlReleased(0, 19) then
            ContextUI.Focus = false
        end
        if (Alma.IsSeating) then
            Visual.FloatingHelpText("Appuyez sur ~INPUT_CONTEXT~ pour vous relevez.", true)
            if (IsControlJustPressed(1, 51)) then
                if (GetFollowPedCamViewMode() == 4) then
                    SetFollowPedCamViewMode(2)
                end
                TaskStartScenarioAtPosition(PlayerPedId(), "PROP_HUMAN_SEAT_BENCH", 0.0, 0.0, 0.0, 180.0, 2, true, false)
                while IsPedUsingScenario(PlayerPedId(), "PROP_HUMAN_SEAT_BENCH") do
                    Citizen.Wait(100)
                end
                ClearPedTasks(PlayerPedId())
                CPlayer.IsSeating = false;
            end
        end
    end
end)

Audio = {}
Utils = {}
function Utils:PlayAnim(animDict, animName, timewait1, timewait2, flag, duration, cb)
    Citizen.CreateThread(function()
        local dur = -1
        if duration ~= nil then dur = duration end
        if timewait2 >= 0 then Citizen.Wait(timewait2) end
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(1)
        end
        FreezeEntityPosition(PlayerPedId(), false)
        TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, -8.0, dur, flag, 1, 0, 0, 0)
        Citizen.Wait(timewait1)
        if animDict ~= nil then
            RemoveAnimDict(animDict)
        end
        if cb ~= nil then
            cb()
        end
    end)
end
function Audio.PlaySound(Library, Sound, IsLooped)
    local audioId
    if not IsLooped then
        PlaySoundFrontend(-1, Sound, Library, true)
    else
        if not audioId then
            Citizen.CreateThread(function()
                audioId = GetSoundId()
                PlaySoundFrontend(audioId, Sound, Library, true)
                Citizen.Wait(0.01)
                StopSound(audioId)
                ReleaseSoundId(audioId)
                audioId = nil
            end)
        end
    end
end
local function StringToArray(str)
    local charCount = #str
    local strCount = math.ceil(charCount / 99)
    local strings = {}
    for i = 1, strCount do
        local start = (i - 1) * 99 + 1
        local clamp = math.clamp(#string.sub(str, start), 0, 99)
        local finish = ((i ~= 1) and (start - 1) or 0) + clamp
        strings[i] = string.sub(str, start, finish)
    end
    return strings
end
local function AddText(str)
    local str = tostring(str)
    local charCount = #str
    if charCount < 100 then
        AddTextComponentSubstringPlayerName(str)
    else
        local strings = StringToArray(str)
        for s = 1, #strings do
            AddTextComponentSubstringPlayerName(strings[s])
        end
    end
end
local function RText(text, x, y, font, scale, r, g, b, a, alignment, dropShadow, outline, wordWrap)
    local Text, X, Y = text, (x or 0) / 1920, (y or 0) / 1080
    SetTextFont(font or 0)
    SetTextScale(1.0, scale or 0)
    SetTextColour(r or 255, g or 255, b or 255, a or 255)
    if dropShadow then
        SetTextDropShadow()
    end
    if outline then
        SetTextOutline()
    end
    if alignment ~= nil then
        if alignment == 1 or alignment == "Center" or alignment == "Centre" then
            SetTextCentre(true)
        elseif alignment == 2 or alignment == "Right" then
            SetTextRightJustify(true)
        end
    end
    if wordWrap and wordWrap ~= 0 then
        if alignment == 1 or alignment == "Center" or alignment == "Centre" then
            SetTextWrap(X - ((wordWrap / 1920) / 2), X + ((wordWrap / 1920) / 2))
        elseif alignment == 2 or alignment == "Right" then
            SetTextWrap(0, X)
        else
            SetTextWrap(X, X + (wordWrap / 1920))
        end
    else
        if alignment == 2 or alignment == "Right" then
            SetTextWrap(0, X)
        end
    end
    return Text, X, Y
end

local function OpenCloseVehicle()
    local coords = GetEntityCoords(PlayerPedId(), false)
	local VehUse = GetVehiclePedIsIn(PlayerPedId()) ~= 0 and GetVehiclePedIsIn(PlayerPedId()) or GetClosestVehicle(coords, 7.0, 0, 71)
	if VehUse ~= 0 then
    	TaskPlayAnim(playerPed, "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
		ESX.TriggerServerCallback('Core:requestPlayerCars', function(isOwnedVehicle)
			if isOwnedVehicle then
				local locked = GetVehicleDoorLockStatus(VehUse)
				if locked == 1 then -- if unlocked
					SetVehicleDoorsLocked(VehUse, 2)	
					ESX.ShowAdvancedNotification("Alma", "~g~Véhicule", "Vous avez ~r~fermé~s~ le véhicule.", "CHAR_CALIFORNIA", 8)
				elseif locked == 2 then -- if locked
					SetVehicleDoorsLocked(VehUse, 1)
					ESX.ShowAdvancedNotification("Alma", "~g~Véhicule", "Vous avez ~g~ouvert~s~ le véhicule.", "CHAR_CALIFORNIA", 8)
				end
			else
				ESX.ShowNotification("~r~Vous n'avez pas les clés de ce véhicule.")
			end
		end, GetVehicleNumberPlateText(VehUse))
	end
end


Graphics = {};
function Graphics.MeasureStringWidth(str, font, scale)
    BeginTextCommandGetWidth("CELL_EMAIL_BCON")
    AddTextComponentSubstringPlayerName(str)
    SetTextFont(font or 0)
    SetTextScale(1.0, scale or 0)
    return EndTextCommandGetWidth(true) * 1920
end
function Graphics.Rectangle(x, y, width, height, r, g, b, a)
    local X, Y, Width, Height = (x or 0) / 1920, (y or 0) / 1080, (width or 0) / 1920, (height or 0) / 1080
    DrawRect(X + Width * 0.5, Y + Height * 0.5, Width, Height, r or 255, g or 255, b or 255, a or 255)
end
function Graphics.Sprite(dictionary, name, x, y, width, height, heading, r, g, b, a)
    local X, Y, Width, Height = (x or 0) / 1920, (y or 0) / 1080, (width or 0) / 1920, (height or 0) / 1080
    if not HasStreamedTextureDictLoaded(dictionary) then
        RequestStreamedTextureDict(dictionary, true)
    end
    DrawSprite(dictionary, name, X + Width * 0.5, Y + Height * 0.5, Width, Height, heading or 0, r or 255, g or 255, b or 255, a or 255)
end
function Graphics.GetLineCount(text, x, y, font, scale, r, g, b, a, alignment, dropShadow, outline, wordWrap)
    local Text, X, Y = RText(text, x, y, font, scale, r, g, b, a, alignment, dropShadow, outline, wordWrap)
    BeginTextCommandLineCount("CELL_EMAIL_BCON")
    AddText(Text)
    return EndTextCommandLineCount(X, Y)
end
function Graphics.Text(text, x, y, font, scale, r, g, b, a, alignment, dropShadow, outline, wordWrap)
    local Text, X, Y = RText(text, x, y, font, scale, r, g, b, a, alignment, dropShadow, outline, wordWrap)
    BeginTextCommandDisplayText("CELL_EMAIL_BCON")
    AddText(Text)
    EndTextCommandDisplayText(X, Y)
end
function Graphics.IsMouseInBounds(X, Y, Width, Height)
    local MX, MY = math.round(GetControlNormal(2, 239) * 1920) / 1920, math.round(GetControlNormal(2, 240) * 1080) / 1080
    X, Y = X / 1920, Y / 1080
    Width, Height = Width / 1920, Height / 1080
    return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end
function Graphics.ConvertToPixel(x, y)
    return (x * 1920), (y * 1080)
end
function Graphics.ScreenToWorld(distance, flags)
    local camRot = GetGameplayCamRot(0)
    local camPos = GetGameplayCamCoord()
    local mouse = vector2(GetControlNormal(2, 239), GetControlNormal(2, 240))
    local cam3DPos, forwardDir = Graphics.ScreenRelToWorld(camPos, camRot, mouse)
    local direction = camPos + forwardDir * distance
    local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(cam3DPos, direction, flags, 0, 0)
    local _, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
    return (hit == 1 and true or false), endCoords, surfaceNormal, entityHit, (entityHit >= 1 and GetEntityType(entityHit) or 0), direction, mouse
end
function Graphics.ScreenRelToWorld(camPos, camRot, cursor)
    local camForward = Graphics.RotationToDirection(camRot)
    local rotUp = vector3(camRot.x + 1.0, camRot.y, camRot.z)
    local rotDown = vector3(camRot.x - 1.0, camRot.y, camRot.z)
    local rotLeft = vector3(camRot.x, camRot.y, camRot.z - 1.0)
    local rotRight = vector3(camRot.x, camRot.y, camRot.z + 1.0)
    local camRight = Graphics.RotationToDirection(rotRight) - Graphics.RotationToDirection(rotLeft)
    local camUp = Graphics.RotationToDirection(rotUp) - Graphics.RotationToDirection(rotDown)
    local rollRad = -(camRot.y * math.pi / 180.0)
    local camRightRoll = camRight * math.cos(rollRad) - camUp * math.sin(rollRad)
    local camUpRoll = camRight * math.sin(rollRad) + camUp * math.cos(rollRad)
    local point3DZero = camPos + camForward * 1.0
    local point3D = point3DZero + camRightRoll + camUpRoll
    local point2D = Graphics.World3DToScreen2D(point3D)
    local point2DZero = Graphics.World3DToScreen2D(point3DZero)
    local scaleX = (cursor.x - point2DZero.x) / (point2D.x - point2DZero.x)
    local scaleY = (cursor.y - point2DZero.y) / (point2D.y - point2DZero.y)
    local point3Dret = point3DZero + camRightRoll * scaleX + camUpRoll * scaleY
    local forwardDir = camForward + camRightRoll * scaleX + camUpRoll * scaleY
    return point3Dret, forwardDir
end
function Graphics.RotationToDirection(rotation)
    local x, z = (rotation.x * math.pi / 180.0), (rotation.z * math.pi / 180.0)
    local num = math.abs(math.cos(x))
    return vector3((-math.sin(z) * num), (math.cos(z) * num), math.sin(x))
end
function Graphics.World3DToScreen2D(pos)
    local _, sX, sY = GetScreenCoordFromWorldCoord(pos.x, pos.y, pos.z)
    return vector2(sX, sY)
end

function ContextUI:OnClosed()
    ResetEntityAlpha(self.Entity.ID)
    self.Entity.ID = nil
    self.Open = false
    self.Focus = false
    self.Category = "main"
    self.Options = 0
end
local function ShowTitle(Label)
    local PosX, PosY = ContextUI.Position.x, ContextUI.Position.y
    PosY = PosY + (ContextUI.Options * Settings.Button.Height)
    Graphics.Rectangle(PosX, PosY, Settings.Button.Width, Settings.Button.Height, Settings.Title.Background[1], Settings.Title.Background[2], Settings.Title.Background[3], Settings.Title.Background[4])
    Graphics.Text(Label, PosX + 110, PosY + 4.0, Settings.Text.Font, 0.28, Settings.Title.Text[1], Settings.Title.Text[2], Settings.Title.Text[3], Settings.Title.Text[4], 1, false, false)
    ContextUI.Options = ContextUI.Options + 1
    ContextUI.Offset = vector2(PosX, PosY)
end
local function ShowDescription(Description)
    local PosX, PosY = ContextUI.Position.x, ContextUI.Position.y
    PosY = PosY + (ContextUI.Options * Settings.Button.Height)
    local GetLineCount = Graphics.GetLineCount(Description, PosX + 110, PosY, Settings.Text.Font, 0.24, Settings.Title.Text[1], Settings.Title.Text[2], Settings.Title.Text[3], Settings.Title.Text[4], 1, false, false, 215)
    Graphics.Rectangle(PosX, PosY, Settings.Button.Width, 2, Settings.Title.Background[1], Settings.Title.Background[2], Settings.Title.Background[3], Settings.Title.Background[4])
    Graphics.Rectangle(PosX, PosY + 2, Settings.Button.Width, 1 + (GetLineCount * 17.5), 0, 0, 0, 160)
    Graphics.Text(Description, PosX + 110, PosY, Settings.Text.Font, 0.24, Settings.Title.Text[1], Settings.Title.Text[2], Settings.Title.Text[3], Settings.Title.Text[4], 1, false, false, 215)
    ContextUI.Offset = vector2(PosX, PosY + 3 +(GetLineCount * 17.5))
end
local lastMenu = nil
function ContextUI:Button(Label, Description, Actions, Submenu)
    local PosX, PosY = self.Position.x, self.Position.y
    PosY = PosY + (self.Options * Settings.Button.Height)
    local onHovered = Graphics.IsMouseInBounds(PosX, PosY, Settings.Button.Width, Settings.Button.Height)
    if (onHovered) then
        local Selected = false;
        if lastMenu == nil or lastMenu ~= Label then
            Audio.PlaySound("HUD_FREEMODE_SOUNDSET", 'NAV_UP_DOWN', false)
            lastMenu = Label
        end
        SetMouseCursorSprite(5)
        if IsControlJustPressed(0, 24) then
            Selected = true
            if (Submenu) then
                self.Category = Submenu.Category
            end
            local audsioName = Label == "← Retour" and "BACK" or "SELECT"
            Audio.PlaySound("HUD_FRONTEND_DEFAULT_SOUNDSET", audioName, false)
        end
        if (Actions) then
            Actions(Selected)
        end
        self.Description = Description
    end
    local Index = (not onHovered) and 1 or 2
    Graphics.Rectangle(PosX, PosY, Settings.Button.Width, Settings.Button.Height, Settings.Button.Background[Index][1], Settings.Button.Background[Index][2], Settings.Button.Background[Index][3], Settings.Button.Background[Index][4])
    Graphics.Text(Label, PosX + Settings.Text.X, PosY + Settings.Text.Y, Settings.Text.Font, Settings.Text.Scale, Settings.Text.Colors[Index][1], Settings.Text.Colors[Index][2], Settings.Text.Colors[Index][3], Settings.Text.Colors[Index][4], Settings.Text.Center, Settings.Text.Outline, Settings.Text.DropShadow)
    self.Options = self.Options + 1
    self.Offset = vector2(PosX, PosY)
end
function ContextUI:Visible()
    SetMouseCursorSprite(1)
    self.Menus[self.Entity.Type .. self.Category]()
    local X, Y = 1920, 1080
    local lastX, lastY = self.Offset.x, self.Offset.y
    if (lastY + (not self.Description and Settings.Button.Height or 0)) >= Y then
        self.Position = vector2(self.Position.x, self.Position.y - 10.0)
    end
    if (lastX + Settings.Button.Width) >= X then
        self.Position = vector2(self.Position.x - 10.0, self.Position.y)
    end
    self.Options = 0;
    self.Description = nil;
end
function ContextUI:CreateMenu(EntityType, Title)
    return { EntityType = EntityType, Category = "main", Parent = nil, Title = Title }
end
function ContextUI:CreateSubMenu(Parent, Title)
    local category = self.CategoryID + 1
    self.CategoryID = category;
    return { EntityType = Parent.EntityType, Category = category, Parent = Parent, Title = Title }
end
function ContextUI:IsVisible(Menu, Callback)
    self.Menus[Menu.EntityType .. Menu.Category] = function()
        if (Menu.Title) then
            -- ShowTitle(Menu.Title)
        end
        Callback(self.Entity)
        if Menu.Parent then
            self:Button("← Retour", nil, nil, Menu.Parent)
        end
        if (self.Description) then
            ShowDescription(self.Description)
        end
    end
end
Citizen.CreateThread(function()
    local controls_actions = { 239, 240, 24, 25 }
    while true do
        local Timer = 250;
        if (ContextUI.Focus) then
            DisableAllControlActions(2)
            SetMouseCursorActiveThisFrame()
            for _, control in ipairs(controls_actions) do
                EnableControlAction(0, control, true)
            end
            if (not ContextUI.Open) then
                local isFound, entityCoords, surfaceNormal, entityHit, entityType, cameraDirection, mouse = Graphics.ScreenToWorld(35.0, 31)
                if (entityType ~= 0) then
                    SetMouseCursorSprite(5)
                    if ContextUI.Entity.ID ~= entityHit then
                        ResetEntityAlpha(ContextUI.Entity.ID)
                        ContextUI.Entity.ID = entityHit
                        SetEntityAlpha(ContextUI.Entity.ID, 200, false)
                    end
                    if IsControlJustPressed(0, 24) or IsDisabledControlPressed(0, 24) then
                        if (ContextUI.Menus[entityType .. ContextUI.Category] ~= nil) then
                            local posX, posY = Graphics.ConvertToPixel(mouse.x, mouse.y)
                            ContextUI.Position = vector2(posX, posY)
                            ContextUI.Entity = {
                                ID = entityHit,
                                Type = entityType,
                                Model = GetEntityModel(entityHit) or 0,
                                NetID = NetworkGetNetworkIdFromEntity(entityHit),
                                ServerID = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHit))
                            }
                            ContextUI.Open = true
                            Audio.PlaySound("HUD_FRONTEND_DEFAULT_SOUNDSET", "SELECT", false)
                        end
                    end
                else
                    if (ContextUI.Entity.ID ~= nil) then
                        ResetEntityAlpha(ContextUI.Entity.ID)
                        ContextUI.Entity.ID = nil
                    end
                    SetMouseCursorSprite(1)
                end
            else
                ContextUI:Visible()
            end
            DisablePlayerFiring(PlayerPedId(), true)
            Timer = 1;
        elseif (ContextUI.Entity.ID ~= nil) then
            ContextUI:OnClosed()
        end
        Citizen.Wait(Timer)
    end
end)

local main = ContextUI:CreateMenu(1, "Menu Contextuel")
local submenu = ContextUI:CreateSubMenu(main)
local vehicleMenu = ContextUI:CreateMenu(2, "Menu Contextuel")
local otherMenu = ContextUI:CreateMenu(3, "Menu Contextuel")
local contents = {
    index = { 1 },
    targetId = 0
}
local TakeBrancard = false
local Bed = 0
ContextUI:IsVisible(main, function(Entity)
    if IsPedAPlayer(Entity.ID) then
    ContextUI:Button("Récupérer l'id du joueur", "", function(onSelected)
        if onSelected then
            contents.targetId = Entity.ServerID;
        end
    end, submenu)
    end
end)
ContextUI:IsVisible(vehicleMenu, function(Entity)
    if not IsPedInAnyVehicle(PlayerPedId()) and GetVehicleDoorLockStatus(Entity.ID) == 2 and IsVehicleSeatFree(Entity.ID, -1) then
        ContextUI:Button("Crocheter", nil, function(onSelected)
            if onSelected then
                local vcoords, pcoords = GetWorldPositionOfEntityBone(Entity.ID, GetEntityBoneIndexByName(Entity.ID, 'door_dside_f')), GetEntityCoords(PlayerPedId())
                if #(vcoords - pcoords) > 1.5 then
                    return
                end
                TriggerServerEvent('Vehicle:GetPickupVehicleResult', Entity.NetID)
            end
        end)
    end
    ContextUI:Button((GetVehicleDoorLockStatus(Entity.ID) == 2 and "Ouvrir le véhicule" or "Fermer le véhicule"), "", function(onSelected)
        if onSelected then
            local object = CreateObjectNoOffset(GetHashKey('lr_prop_carkey_fob'), GetEntityCoords(PlayerPedId()), 0, 0, 0)
            AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0 ,0.0 ,0.0, 0.0,0.0 ,true, false, false, false, 2, true)
            PlaySoundFromEntity(-1, "Remote_Control_Open", PlayerPedId(), "PI_Menu_Sounds", true, 0)
            Utils:PlayAnim('anim@mp_player_intmenu@key_fob@', 'fob_click', 0, 0, 48, -1, function()
                Citizen.Wait(1000)
                DeleteObject(object)
            end)
            OpenCloseVehicle()
            ContextUI:OnClosed()
        end
    end)
end)
ContextUI:IsVisible(submenu, function(Entity)
    ContextUI:Button(string.format('Id : ~b~%s~w~', contents.targetId), "", function(onSelected)
        if onSelected then
        end
    end)
end)