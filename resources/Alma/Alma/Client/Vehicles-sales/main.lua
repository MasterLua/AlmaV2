local CAMERA = 0;
local CAMERA_POSITION = { coords = vector3(-50.132041931152, -1098.7921142578, 28.205955505371), rot = vector3(-11.613740921021, -3.0506639632222e-06, -58.669635772705) }

local VEHICLES_SALES = {};
local VEHICLES_SALES_COUNT = 0

local VEHICLE_ENTITY = nil;
local OWNED_VEHICLES = {};
local OWNED_VEHICLES_COUNT = 0;
local OWNED_VEHICLES_ACTIONS = {};

Alma:AddEventHandler("VehicleSales", "GetVehiclesOwned", function(lists)
	if not (VEHICLE_ENTITY == 0) then
		DeleteEntity(VEHICLE_ENTITY);
		VEHICLE_ENTITY = 0;
	end
	OWNED_VEHICLES_COUNT = 0;
	OWNED_VEHICLES = {}
	for i, v in pairs(lists) do
		local vehicle = json.decode(v.vehicle)
		local name = GetLabelText(GetDisplayNameFromVehicleModel(vehicle.model));
		if (name ~= "NULL") then
			name = name;
		else
			name = "Votre voiture."
		end
		table.insert(OWNED_VEHICLES, { name = name, model = vehicle.model, plate = v.plate, type = v.type, custom = vehicle })
		OWNED_VEHICLES_COUNT = OWNED_VEHICLES_COUNT + 1;
	end
end)

Alma:AddEventHandler("VehicleSales", "RetrieveCatalog", function(content)
	VEHICLES_SALES_COUNT = 0;
	VEHICLES_SALES = {};
	for i, v in pairs(content) do
		VEHICLES_SALES_COUNT = VEHICLES_SALES_COUNT + 1;
		VEHICLES_SALES[#VEHICLES_SALES + 1] = {
			id = v.id,
			seller = v.identifier,
			seller_name = v.seller_name:gsub('~', ''),
			name = v.name:gsub('~', ''),
			description = v.description:gsub('~', ''),
			price = tonumber(v.price),
			vehicle = json.decode(v.vehicle),
			expire_at = v.expire_at,
			formatted_expire_at = v.formatted_expire_at == nil and "Inconnue" or v.formatted_expire_at,
		}
	end
end)

Alma:AddEventHandler("VehicleSales", "BuySuccessfully", function()
	DeleteEntity(VEHICLE_ENTITY)
end)

local function CreateCamera()
	if (CAMERA == 0) then
		CAMERA = Helper:CreateCamera("DEFAULT_SCRIPTED_CAMERA")
	end
	SetCamCoord(CAMERA, CAMERA_POSITION.coords)
	ShakeCam(CAMERA, "HAND_SHAKE", 0.3)
	SetCamRot(CAMERA, CAMERA_POSITION.rot.x, CAMERA_POSITION.rot.y, CAMERA_POSITION.rot.z, 2)
	SetCamActive(CAMERA, true)
	SetFocusPosAndVel(CAMERA_POSITION.coords, 0, 0, 0)
	RenderScriptCams(1, 0, 500, false, false)
end

local function onInteriorID()
	if not (RageUI.Visible(MAIN_MENU)) then
		Visual.FloatingHelpText("Appuyez sur ~INPUT_CONTEXT~ pour visualisé le catalogue.", true)
		if (IsControlJustPressed(1, 51)) then
			DisplayRadar(false)
			Alma:TriggerServerEvent("VehicleSales", "RequestVehiclesOwned");
			Alma:TriggerServerEvent("VehicleSales", "RequestCatalog");
			VehicleSales()
		end
	end
end

function VehicleSales()
    local MAIN_MENU = RageUI.CreateMenu("Catalogue", "VENTE ENTRE PARTICULIERS")
    local CATALOG_MENU = RageUI.CreateSubMenu(MAIN_MENU, "Catalogue", "VENTE ENTRE PARTICULIERS")
    local OWNED_VEHICLES_MENU = RageUI.CreateSubMenu(MAIN_MENU, "Vos vehicles.", "VENTE ENTRE PARTICULIERS")
    CATALOG_MENU.Closed = function()
        if not (VEHICLE_ENTITY == 0) then
            DeleteEntity(VEHICLE_ENTITY);
            VEHICLE_ENTITY = 0;
        end
        CATALOG_MENU.Index = 1;
        ClearFocus()
        DestroyCam(CAMERA)
        RenderScriptCams(false, false, false, 0, 0)
        CAMERA = 0
    end
    CATALOG_MENU.onIndexChange = function(Index)
        if (VEHICLES_SALES[Index]) then
            if not (VEHICLE_ENTITY == 0) then
                DeleteEntity(VEHICLE_ENTITY);
            end
            local value = json.decode(VEHICLES_SALES[Index].vehicle)
            Helper:SpawnLocalVehicle(value.model, vector4(-44.1960, -1095.8929, 26.4223, 130.1532), function(entity)
                VEHICLE_ENTITY = entity
                ESX.Game.SetVehicleProperties(entity, value)
                SetVehicleDirtLevel(entity, 0.0)
                SetEntityHealth(entity, 100)
                FreezeEntityPosition(entity, true)
            end)
        end
    end
    OWNED_VEHICLES_MENU.onIndexChange = function(Index)
        if (OWNED_VEHICLES[Index]) then
            if not (VEHICLE_ENTITY == 0) then
                DeleteEntity(VEHICLE_ENTITY);
            end
            local value = json.decode(OWNED_VEHICLES[Index].custom)
            Helper:SpawnLocalVehicle(value.model, vector4(-44.1960, -1095.8929, 26.4223, 130.1532), function(entity)
                VEHICLE_ENTITY = entity
                ESX.Game.SetVehicleProperties(entity, value)
                SetVehicleDirtLevel(entity, 0.0)
                SetEntityHealth(entity, 100)
                FreezeEntityPosition(entity, true)
            end)
        end
    end
    OWNED_VEHICLES_MENU.Closed = function()
        if not (VEHICLE_ENTITY == 0) then
            DeleteEntity(VEHICLE_ENTITY);
            VEHICLE_ENTITY = 0;
        end
        OWNED_VEHICLES_MENU.Index = 1;
        DestroyCam(CAMERA)
        ClearFocus()
        RenderScriptCams(false, false, false, 0, 0)
        CAMERA = 0
    end
    MAIN_MENU.Closed = function()
        DisplayRadar(true)
    end

    RageUI.Visible(MAIN_MENU, not RageUI.Visible(MAIN_MENU))

    DisplayRadar(false)

    while MAIN_MENU do
        Citizen.Wait(0)
	    RageUI.IsVisible(MAIN_MENU, function()

	    	RageUI.Button("Catalogue", nil, { RightLabel = VEHICLES_SALES_COUNT.." Offre(s)" }, true, {
	    		onSelected = function()
	    			CreateCamera()
	    		end
	    	}, CATALOG_MENU)

	    	RageUI.Separator("Vos activiter")

	    	if (OWNED_VEHICLES_COUNT > 0) then
	    		RageUI.Button("Vos vehicles.", nil, { RightLabel = OWNED_VEHICLES_COUNT }, true, {
	    			onSelected = function()
	    				CreateCamera()
	    			end
	    		}, OWNED_VEHICLES_MENU)
	    	end
	    end)

	    RageUI.IsVisible(OWNED_VEHICLES_MENU, function()
	    	for i, v in pairs(OWNED_VEHICLES) do
	    		if (OWNED_VEHICLES_ACTIONS[v.plate] == nil) then
	    			OWNED_VEHICLES_ACTIONS[v.plate] = 1;
	    		end
                RageUI.List(v.name, {
                    { Name = "Mettre en vente" },
                }, OWNED_VEHICLES_ACTIONS[v.plate], "Plaque : " .. v.plate .. "\n\n~HUD_COLOUR_DEGEN_RED~Lorsque vous mettez un véhicule en vente, il sera indisponible, et non utilisable jusqu'à ce que votre annonce soit expirée. (dans ce cas la vous le retrouveras dans votre garage automatiquement)", {}, true, {
                    onListChange = function(Index, Item)
                        OWNED_VEHICLES_ACTIONS[v.plate] = Index
                    end,
                    onSelected = function(Index, Item)
                        local price = Helper:KeyboardInput("Prix de votre vente", 500000, 500, true)
                        if not (price) or (tonumber(price) <= 0) then
                            return
                        end
                        local name = Helper:KeyboardInput("Nom.", "BF400, bla bla..", 500, false)
                        if not (name) then
                            return
                        end
                        if (#name >= 50) then
                            ESX.ShowNotification('~r~50 charactère maximum pour le nom')
                            return
                        end
                        local description = Helper:KeyboardInput("Description.", "BF400, Rouge, casi neuf, bla bla bla..", 500, false)
                        if not (description) then
                            return
                        end
                        if (#description >= 500) then
                            print('500 charecter max pour le description')
                            return
                        end
                        local expire_at = Helper:KeyboardInput("Expiration de votre annonce. (en heurs exemple avec 12 heures)", 12, 500, true)
                        if not (expire_at) or (tonumber(expire_at) <= 0) then
                            return
                        end
                        Alma:TriggerServerEvent("VehicleSales", "Selling", v.plate, name, description, price, expire_at)
                    end
                })
	    	end
	    end)

	    RageUI.IsVisible(CATALOG_MENU, function()
	    	for i, v in pairs(VEHICLES_SALES) do
                if i == 0 then
                    RageUI.Separator("Aucune offfres.")
                end
	    		RageUI.List("["..i.."] "..v.name, { "Acheter" }, 1, "Prix : ~g~" .. ESX.Math.GroupDigits(v.price) .. " $~s~\nVendeur : " .. v.seller_name .. "\n\nExpire dans : " .. v.formatted_expire_at .. "h\n\nDescription : " .. v.description .. "", {}, true, {
	    			onListChange = function(Index, Item)

	    			end,
	    			onSelected = function(Index, Item)
	    				local input = Helper:KeyboardInput("Confirmer votre achat | oui, ou non", "non")
	    				if (input) then
	    					if (string.upper(input) == "OUI") then
	    						Alma:TriggerServerEvent("VehicleSales", "Buy", v.id)
	    					end
	    				end
	    			end
	    		})
	    	end
	    end)
        if not RageUI.Visible(MAIN_MENU) and not RageUI.Visible(CATALOG_MENU) and not RageUI.Visible(OWNED_VEHICLES_MENU) then
            MAIN_MENU = RMenu:DeleteType("MAIN_MENU", true)
            CATALOG_MENU = RMenu:DeleteType("CATALOG_MENU", true)
            OWNED_VEHICLES_MENU = RMenu:DeleteType("OWNED_VEHICLES_MENU", true)
            DisplayRadar(true)
        end
    end
end

Citizen.CreateThread(function()
	local position = vector3(-48.8581, -1102.8409, 26.4223)
	local entity = Pnj(26, GetHashKey("cs_taostranslator"), vector4(position.x, position.y, position.z, -15.7949), 281089)

	local blip = AddBlipForCoord(position)
	SetBlipSprite(blip, 227)
	SetBlipScale(blip, 0.5)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName("Vente de véhicules entre particuliers")
	EndTextCommandSetBlipName(blip)

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
						  vector3 = position,
						  distance = 10.0,
						  size = 5.0,
						  hidden = true,
						  onArea = onInteriorID,
					  })
end)
