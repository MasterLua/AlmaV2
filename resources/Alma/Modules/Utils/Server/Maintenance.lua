-- Début de la maintenance

-- local Licensestaff = {
--     Staff = {
--         ["556324f99fd7e2ea9ad1fe5542b8d8a1b8470485"] = true,
--         ["b3ac67bb27e84fcb6c5ce99861be6487f27333fb"] = true
--     },
-- }

-- local maintenance = true

-- local function devStart(state)
--      if state then
--         maintenance = true
--           local xPlayers = ESX.GetPlayers()
--           for i = 1, #xPlayers, 1 do
--                if not Licensestaff.Staff[xPlayers[i].identifier] then
--                     print("Le joueur ^6"..GetPlayerName(xPlayers[i]).."^0 connexion ^1reffusé^0 (^5Dev^0)")
--                     DropPlayer(xPlayers[i], "\nInformation\nLe serveur est actuellement en maintenance !")
--                else
--                     print("Le joueur ^6"..GetPlayerName(xPlayers[i]).."^0 connexion ^2accepté^0 (^5Dev^0)")
--                end
--           end
--      else
--         maintenance = false
--      end
-- end

-- Citizen.CreateThread(function()
--     devStart(maintenance)
-- end)

-- AddEventHandler('playerConnecting', function(name, setReason)
--     if maintenance then
--          if not Licensestaff.Staff[xPlayers[i].identifier] then
--             print("[^6Maintenance^0] Le joueur [^6"..name.."^0] connexion [^1reffusé^0] -> ^1Maintenance^0")
--             setReason("\n\nServeur en maintenance, plus d'informations sur discord !\n\ndiscord.gg/modernrp")
--             CancelEvent()
--             return
--          end
--     end
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         Wait(60*1000*4)
--         if maintenance then
--             print("[^6Maintenance^0] ^2détecté^0 !")
--             local xPlayers = ESX.GetPlayers()
--             for i = 1, #xPlayers, 1 do
--                  if not Licensestaff.Staff[xPlayers[i].identifier] then
--                       print("[^6Maintenance^0] Le joueur [^6"..GetPlayerName(xPlayers[i]).."^0] est [^1reffusé^0] dans la maintenance.")
--                       DropPlayer(xPlayers[i], "\nInformation\nLe serveur est actuellement en maintenance !")
--                  else
--                       print("[^6Maintenance^0] Le joueur [^6"..GetPlayerName(xPlayers[i]).."^0] est [^6accepté^0] dans la maintenance .")
--                  end
--             end
--         else
--             print("[^6Maintenance^0] ^2non détecté^0 !")
--         end
--     end
-- end)

-- RegisterCommand("maintenance", function(source)
--     if source == 0 then
--          if not maintenance then
--               print("[^6Maintenance^0] ^1actif^0 !")
--               devStart(true)
--          else
--               print("[^6Maintenance^0] non ^2actif^0 !")
--               devStart(false)
--          end
--     end
-- end)

-- Fin de la maintenance

