Sixt = {}
Sixt.__index = Sixt

setmetatable(Sixt, {
	__call = function(_, id, name, description, model, picture, price)
		local self = setmetatable({}, Sixt);

        self.id = id
		self.name = name
		self.description = description
		self.model = model
        self.picture = picture
        self.price = price

        if (Sixt[self.id]) then
            print("Sixt meta-id : "..self.id.." are already used !")
        end

		Sixt[self.id] = self;

		return self
	end
})



function Sixt:New(id, name, description, model, picture, price)
	Sixt(id, name, description, model, picture, price)
end

function Sixt:ModelRetrieve(model)
    for i = 1, #Sixt do
        if Sixt[i].model == model then
            return Sixt[i]
        end
    end
end

Sixt:New(1, "Golf Mk7", nil, "rmodmk7", "rmodmk7", 2500000)
Sixt:New(2, "Toyota Supra", nil, "rmodsuprapandem", "rmodsuprapandem", 3500000)
Sixt:New(3, "Rolls Dawnonyx", nil, "dawnonyx", "dawnonyx", 3000000)
Sixt:New(4, "Porsche 918", nil, "rmodporsche918", "rmodporsche918", 2500000)
Sixt:New(5, "Porsche 911 Turbo", nil, "911turbos", "911turbos", 5000000)
Sixt:New(6, "Nissan Skyline", nil, "rmodskyline34", "rmodskyline34", 4000000)
Sixt:New(7, "Nissan GTR", nil, "rmodgtr50", "rmodgtr50", 3000000)
Sixt:New(8, "Nissan Fairlady", nil, "rmodz350pandem", "rmodz350pandem", 3500000)
Sixt:New(9, "Nissan 240SX", nil, "rmod240sx", "rmod240sx", 2500000)
Sixt:New(10, "Mercedes G65 AMG", nil, "rmodg65", "rmodg65", 3000000)
Sixt:New(11, "Mercedes E63S", nil, "rmode63s", "rmode63s", 2500000)
Sixt:New(12, "Mercedes C63 AMG", nil, "rmodc63amg", "rmodc63amg", 2000000)
Sixt:New(13, "Mercedes A45", nil, "a45", "a45", 2500000)

local SixtList = {
    { Name = "~g~Sortir~s~", Value = 1 },
    { Name = "~b~Renommer~s~", Value = 2 }
}

local SixtLouerList = {
    { Name = "24 heures", Value = 1 },
    { Name = "3 jours", Value = 2 },
    { Name = "1 semaine", Value = 3 }
}

local SixtExpiredList = {
    { Name = "~b~Renouveler~s~", Value = 1 },
    { Name = "~r~Rendre~s~", Value = 2 }
}

local Vehicle = {}

SpawnPointClear = function()
    local clear = true
    local vehicles = ESX.Game.GetVehicles()
    for k,v in pairs(vehicles) do
        if GetDistanceBetweenCoords(GetEntityCoords(v), vector3(-696.255859375,-1641.0620117188,24.115789413452), true) <= 2.5 then
            clear = false
            break
        end
    end
    return clear
end

OpenSixt = function()
    local locationMenu = RageUI.CreateMenu("AlmaRP", "SIXT, FAÎTES VOTRE CHOIX")
    locationMenu.TitleFont = 2;

    RageUI.Visible(locationMenu, not RageUI.Visible(locationMenu))

    FreezeEntityPosition(PlayerPedId(), true)

    while locationMenu do
        Citizen.Wait(0)
        RageUI.IsVisible(locationMenu, function()
            RageUI.Separator("~g~↓ Sixt Luxury ↓")
            RageUI.Button("Mes locations", nil, {RightLabel = "→→"}, true, {
                onSelected = function()
                    LocationSixtMenu()
                end
            })
            RageUI.Button("Louer un véhicule", nil, {RightLabel = "→→"}, true, {
                onSelected = function()
                    LouerSixtMenu()
                end
            })
        end)
        if not RageUI.Visible(locationMenu) then
            locationMenu = RMenu:DeleteType("locationMenu", true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

LocationSixtMenu = function()
    local locationMenu = RageUI.CreateMenu("AlmaRP", "MES LOCATIONS")
    local players_location = {}
    local SixtIndex = 1;
    local SixtExpiredIndex = 1;
    locationMenu.TitleFont = 2;

    ESX.TriggerServerCallback("Sixt:GetLocation", function(result)
        players_location = result;
    end)

    RageUI.Visible(locationMenu, not RageUI.Visible(locationMenu))

    FreezeEntityPosition(PlayerPedId(), true)

    while locationMenu do
        Citizen.Wait(0)
        RageUI.IsVisible(locationMenu, function()
            if #players_location > 0 then
                for _, data in pairs(players_location) do
                    if not data.expired then
                        RageUI.List("#"..data.id.." - "..data.name, SixtList, SixtIndex, "Expiration: ~b~"..data.expiration.."~s~\nPlaque: ~g~"..data.plate, {}, not Vehicle[data.plate], {
                            onActive = function()
                                if Vehicle[data.plate] then Visual.Subtitle("~g~↓ Sixt Luxury ↓~s~\n Ce véhicule est sorti !", 1) end
                            end,
                            onListChange = function(Index, Item)
                                SixtIndex = Index;
                            end,
                            onSelected = function(Index, Item)
                                if Vehicle[data.plate] then return ESX.ShowNotification("~g~Sixt Luxury~s~: Votre véhicule est déja sorti !") end
                                if SixtIndex == 1 then
                                    if not SpawnPointClear() then
                                        ESX.ShowNotification("Il y a trop de véhicules dans la zone d'apparition.")
                                        return
                                    end
                                    ESX.Game.SpawnVehicle(data.model, vector3(-696.255859375,-1641.0620117188,24.115789413452), 300.0, function(vehicle)
                                        SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                        SetVehicleNumberPlateText(vehicle, data.plate)
                                        ESX.ShowNotification("Vous avez sorti votre ~g~"..data.name.."~s~, location n°~g~"..data.id)
                                        RageUI.CloseAll()
                                        FreezeEntityPosition(PlayerPedId(), false)
                                    end)
                                    Vehicle[data.plate] = true
                                else
                                    local string = KeyboardInput('Par quel nom souhaitez vous renommer '..data.name, "", data.name, 100)
                                    if string ~= "" then
                                        TriggerServerEvent("Sixt:LocationRename", data.id, string)
                                    end
                                end
                            end
                        })
                    else
                        RageUI.List("#"..data.id.." - "..data.name, SixtExpiredList, SixtExpiredIndex, "Expiration: ~r~Expiré~s~\nPlaque: ~g~"..data.plate, {}, true, {
                            onActive = function()
                            end,
                            onListChange = function(Index, Item)
                                SixtExpiredIndex = Index;
                            end,
                            onSelected = function(Index, Item)
                                if SixtExpiredIndex == 1 then
                                    ExpiredSixtLocation(data.id, data.plate, data.price, data.model)
                                else
                                    local SixtInfo = Sixt:ModelRetrieve(data.model)
                                    TriggerServerEvent("Sixt:StopRent", data.id, SixtInfo.id)
                                    RageUI.CloseAll()
                                end
                            end
                        })
                    end
                end
            else
                RageUI.Separator("~g~↓ Sixt Luxury ↓~s~")
                RageUI.Separator("")
                RageUI.Separator("Vous n'avez pas de location en cours..")
                RageUI.Separator("")
            end
        end)
        if not RageUI.Visible(locationMenu) then
            locationMenu = RMenu:DeleteType("locationMenu", true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

ExpiredSixtLocation = function(id, plate, name, model)
    local locationMenu = RageUI.CreateMenu("AlmaRP", "Renouvellement")
    local SixtLouerIndex = 1;
    local SixtInfos = Sixt:ModelRetrieve(model)
    locationMenu.TitleFont = 2;

    RageUI.Visible(locationMenu, not RageUI.Visible(locationMenu))

    FreezeEntityPosition(PlayerPedId(), true)

    DisplayRadar(false)

    while locationMenu do
        Citizen.Wait(0)
        RageUI.IsVisible(locationMenu, function()
            RageUI.List("Durée", SixtLouerList, SixtLouerIndex, nil, {}, true, {
                onListChange = function(Index, Item)
                    SixtLouerIndex = Index;
                end,
                onSelected = function(Index, Item)
                    
                end
            })
            RageUI.Button("Plaque", nil, {RightLabel = "~HUD_COLOUR_GREY~"..plate}, true, {

            })
            RageUI.Button("Renouveller", nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(SixtInfos.price * SixtLouerIndex).."$"}, true, {
                onActive = function()
                    RageUI.RenderSixt("vehicles", SixtInfos.model)
                end,
                onSelected = function()
                    TriggerServerEvent("Sixt:RenewSubscription", id, SixtInfos.id, SixtLouerIndex)
                    RageUI.CloseAll()
                end
            })
        end, function()
        end)
        if not RageUI.Visible(locationMenu) then
            locationMenu = RMenu:DeleteType("locationMenu", true)
            DisplayRadar(true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

LouerSixtMenu = function()
    local locationMenu = RageUI.CreateMenu("AlmaRP", "LOUER UN VÉHICULE")
    local SixtLouerIndex = 1;
    locationMenu.TitleFont = 2;

    RageUI.Visible(locationMenu, not RageUI.Visible(locationMenu))

    FreezeEntityPosition(PlayerPedId(), true)

    DisplayRadar(false)

    while locationMenu do
        Citizen.Wait(0)
        RageUI.IsVisible(locationMenu, function()
            RageUI.List("Durée", SixtLouerList, SixtLouerIndex, nil, {}, true, {
                onListChange = function(Index, Item)
                    SixtLouerIndex = Index;
                end,
                onSelected = function(Index, Item)
                    
                end
            })
            for i = 1, #Sixt do
                RageUI.Button(Sixt[i].name, nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(Sixt[i].price * SixtLouerIndex).."$"}, true, {
                    onActive = function()
                        SixtId = i;
                        RageUI.RenderSixt("vehicles", Sixt[i].picture)
                        Visual.Subtitle("~g~↓ Sixt Luxury ↓~s~\nNom : ~g~"..Sixt[i].name.."~s~\nPrix : ~g~"..ESX.Math.GroupDigits(Sixt[i].price * SixtLouerIndex).."$", 1)
                    end,
                    onSelected = function()
                        if SixtLouerIndex == 1 then
                            TriggerServerEvent("Sixt:LocationVehicle", i, SixtLouerIndex)
                        elseif SixtLouerIndex == 2 then
                            TriggerServerEvent("Sixt:LocationVehicle", i, SixtLouerIndex)
                        elseif SixtLouerIndex == 3 then
                            TriggerServerEvent("Sixt:LocationVehicle", i, SixtLouerIndex)
                        end
                    end
                })
            end
        end, function()
            -- RageUI.RenderSprite("vehicles", Sixt[SixtId].picture)
        end)
        if not RageUI.Visible(locationMenu) then
            locationMenu = RMenu:DeleteType("locationMenu", true)
            DisplayRadar(true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

RangerSixtLocation = function()
    local locationMenu = RageUI.CreateMenu("AlmaRP", "LOUER UN VÉHICULE")
    local SixtLouerIndex = 1;
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local vehicleIN = IsPedSittingInAnyVehicle(PlayerPedId(), false)
    locationMenu.TitleFont = 2;

    RageUI.Visible(locationMenu, not RageUI.Visible(locationMenu))

    if not vehicleIN then return ESX.ShowNotification("~r~Vous devez être dans un véhicule !") end

    FreezeEntityPosition(vehicle, true)

    while locationMenu do
        Citizen.Wait(0)
        RageUI.IsVisible(locationMenu, function()
            RageUI.Button("Ranger mon véhicule", "Vous permet de ranger votre véhicule de location Sixt !", {RightLabel = "→→"}, true, {
                onSelected = function()
                    local plate = GetVehicleNumberPlateText(vehicle)
                    if plate:match("SIXT") then
                        DeleteVehicle(vehicle)
                        Vehicle[plate] = false
                        ESX.ShowNotification("Vous avez ~o~ranger~s~ votre véhicule de location ~o~Sixt~s~ !")
                        RageUI.CloseAll()
                        FreezeEntityPosition(vehicle, false)
                    else
                        ESX.ShowNotification("Vous ne possédez pas un véhicule de location ~o~Sixt~s~ !")
                    end
                end
            })
        end)
        if not RageUI.Visible(locationMenu) then
            locationMenu = RMenu:DeleteType("locationMenu", true)
            FreezeEntityPosition(vehicle, false)
        end
    end
end