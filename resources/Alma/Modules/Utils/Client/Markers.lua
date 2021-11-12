ZonesListe = {
    ["~y~Sixt Luxury"] = {
        Position = vector3(-690.84368896484,-1647.009765625,23.391342163086),
        Public = true,
        Job = nil,
        Blip = {
            Name = "Sixt Location",
            Sprite = 293,
            Display = 4,
            Scale = 0.75,
            Color = 17
        },
        Action = function()
            OpenSixt()
        end
    },
    ["SixtRanger"] = {
        Position = vector3(-706.61151123047,-1628.1643066406,23.594999313354),
        Public = true,
        Job = nil,
        Blip = false,
        Action = function()
            RangerSixtLocation()
        end
    },
    ["Coffre BMA"] = {
        Position = vector3(-696.93194580078,-1640.7854003906,24.079196929932),
        Public = true,
        Job = nil,
        Blip = false,
        Action = function()
            COFFRE_BDA()
        end
    }
}

function AddMarker(id, data)
    if not ZonesListe[id] then 
        ZonesListe[id] = data
    end
end

function RemoveMarker(id)
    ZonesListe[id] = nil
end

Citizen.CreateThread(function()
    for _,marker in pairs(ZonesListe) do
        if marker.Blip then
            local blip = AddBlipForCoord(marker.Position)

            SetBlipSprite(blip, marker.Blip.Sprite)
            SetBlipScale(blip, marker.Blip.Scale)
            SetBlipColour(blip, marker.Blip.Color)
            SetBlipDisplay(blip, marker.Blip.Display)
            SetBlipAsShortRange(blip, true)
    
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(marker.Blip.Name)
            EndTextCommandSetBlipName(blip)
        end
	end

    while true do
        local isProche = false
        for k,v in pairs(ZonesListe) do
            if v.Public or ESX.GetPlayerData().job ~= nil and ESX.GetPlayerData().job.name == v.Job then
                local dist = Vdist2(GetEntityCoords(PlayerPedId(), false), v.Position)

                if dist < 250 then
                    isProche = true
                    DrawMarker(25, v.Position.x, v.Position.y, v.Position.z-0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.55, 0.55, 0.55, 104, 0, 214, 255, false, false, 2, false, false, false, false)
                end
                if dist < 10 then
                    ESX.ShowHelpNotification("~g~"..k.."~s~ : Appuyez sur ~INPUT_CONTEXT~ pour intéragir")
                    if IsControlJustPressed(1,51) then
                        v.Action(v.Position)
                    end
                end
            end
        end
        
		if isProche then
			Wait(0)
		else
			Wait(850)
		end
	end
end)