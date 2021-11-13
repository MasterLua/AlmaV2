local ENTREPRISE = {};

Citizen.CreateThread(function()
    while true do
        MySQL.Async.fetchAll("SELECT * FROM alma_entreprise", {   
        }, function(result)
            for i = 1, #result do
                ENTREPRISE[result[i].name] = {
                    name = result[i].name,
                    money = result[i].money,
                    dirty = result[i].dirtycash,
                    coffre = json.encode(result[i].coffre)
                }
            end
            print("\n\n[^1Authentic-Entreprise^7] Récuperation des donnés réussi !\n\n")
        end)
        Citizen.Wait(30000);
    end
end)

Citizen.CreateThread(function()
    MySQL.Async.fetchAll("SELECT * FROM jobs", {}, function(result)
        for i = 1, #result do
            local name = result[i].name
            MySQL.Async.fetchAll("SELECT name FROM alma_entreprise WHERE name = @a", { ["@a"] = name }, function(results)
                if results[1] or name == "unemployed" or name == "unemployed2" then
                    return
                else
                    MySQL.Async.execute("INSERT INTO alma_entreprise (name, money, dirtycash, coffre) VALUES (@a, @b, @c, @d)", {
                        ["@a"] = name,
                        ["@b"] = 0,
                        ["@c"] = 0,
                        ["@d"] = json.encode({})
                    })
                    print("\n\n[^1Authentic-Entreprise^7] Ajout de l'entreprise "..name.." réussi !\n\n")
                end
            end)
        end
    end)
end)

AddEventHandler("onResourceStart", function(rn)
    if rn == GetCurrentResourceName() then
        MySQL.Async.fetchAll("SELECT * FROM alma_entreprise", {}, function(result)
            for i = 1, #result do
                ENTREPRISE[result[i].name] = {
                    name = result[i].name,
                    money = result[i].money,
                    dirty = result[i].dirtycash,
                    coffre = json.encode(result[i].coffre)
                }
            end
            print("\n\n[^1Authentic-Entreprise^7] Récuperation des donnés réussi !\n\n")
        end)
    else
        return
    end
end)

ESX.RegisterServerCallback("Inventory:getEntrepriseMenu", function(source, callback)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer.job.grade_name == "boss") then
        callback(tonumber(ENTREPRISE[xPlayer.job.name].money))
    else
        callback({ })
    end
end)

Alma:AddEventHandler("Entreprise", "Leave", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.job.label
    if xPlayer.job.name ~= "unemployed" then
        xPlayer.setJob("unemployed", 0)
        xPlayer.showNotification("Vous avez demissionné de "..name.." !")
    else
        xPlayer.showNotification("Vous n'avez pas de poste !")
    end
end)

Alma:AddEventHandler("Entreprise", "Promote", function(id)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer.job.grade_name == "boss") then
        local xTarget = ESX.GetPlayerFromId(id)
        if not xTarget.job.name == xPlayer.job.name then 
            return xPlayer.showNotification("~r~Cette personne n'est pas dans votre entreprise !") 
        end
        xTarget.setJob(xPlayer.job.name, xTarget.job.grade + 1)
        Helper:showAdvancedNotification(xPlayer.source, "~y~Promotion", xPlayer.name, "Vous avez promu "..xTarget.name..", en tant que ~g~"..xTarget.job.grade_label.."~s~, de la ~g~"..xPlayer.job.label.."~s~ !", "CHAR_LESTER_DEATHWISH", 1)
        Helper:showAdvancedNotification(xTarget.source, "~y~Promotion", xPlayer.name, "Vous avez été promu par "..xPlayer.name..", vous êtes désormais ~g~"..xTarget.job.grade_label.."~s~, de la ~g~"..xPlayer.job.label.."~s~ !", "CHAR_LESTER_DEATHWISH", 1)
    else
        xPlayer.showNotification("~HUD_COLOUR_DEGEN_RED~Vous n'êtes pas patron de l'entreprise !")
    end
end)

Alma:AddEventHandler("Entreprise", "UnPromote", function(id)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer.job.grade_name == "boss") then
        local xTarget = ESX.GetPlayerFromId(id)
        if not xTarget.job.name == xPlayer.job.name then 
            return xPlayer.showNotification("~r~Cette personne n'est pas dans votre entreprise !") 
        end
        xTarget.setJob(xPlayer.job.name, (xTarget.job.grade - 1 == 0 and 1 or xTarget.job.grade - 1))
        Helper:showAdvancedNotification(xPlayer.source, "~o~Retrograder", xPlayer.name, "Vous avez rétrograder "..xTarget.name..", il est désormais ~g~"..xTarget.job.grade_label.."~s~, de la ~g~"..xPlayer.job.label.."~s~ !", "CHAR_LESTER_DEATHWISH", 1)
        Helper:showAdvancedNotification(xTarget.source, "~o~Retrograder", xPlayer.name, "Vous avez été rétrograder par "..xPlayer.name..", vous êtes désormais ~g~"..xTarget.job.grade_label.."~s~, de la ~g~"..xPlayer.job.label.."~s~ !", "CHAR_LESTER_DEATHWISH", 1)
    else
        xPlayer.showNotification("~HUD_COLOUR_DEGEN_RED~Vous n'êtes pas patron de l'entreprise !")
    end
end)

Alma:AddEventHandler("Entreprise", "Kick", function(id)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer.job.grade_name == "boss") then
        local xTarget = ESX.GetPlayerFromId(id)
        if not xTarget.job.name == xPlayer.job.name then 
            return xPlayer.showNotification("~r~Cette personne n'est pas dans votre entreprise !") 
        end
        xTarget.setJob("unemployed", 0)
        Helper:showAdvancedNotification(xPlayer.source, "~r~Licenciement", xPlayer.name, "Vous avez licencier ~g~"..xTarget.name.."~s~, de la ~g~"..xPlayer.job.label.."~s~ !", "CHAR_LESTER_DEATHWISH", 1)
        Helper:showAdvancedNotification(xTarget.source, "~r~Licenciement", xPlayer.name, "Vous avez été licencier par "..xPlayer.name.." de la ~g~"..xPlayer.job.label.."~s~ !", "CHAR_LESTER_DEATHWISH", 1)
    else
        xPlayer.showNotification("~HUD_COLOUR_DEGEN_RED~Vous n'êtes pas patron de l'entreprise !")
    end
end)

Alma:AddEventHandler("Entreprise", "Recruit", function(id)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)


    if (xPlayer.job.grade_name == "boss") then
        local xTarget = ESX.GetPlayerFromId(id)
        if xTarget.job.name == xPlayer.job.name then 
            return xPlayer.showNotification("~r~Cette personne est déjà dans l'entreprise !") 
        end
        if xTarget.job.name ~= "unemployed" then
            return xPlayer.showNotification("~r~Cette personne est "..xTarget.job.label..", elle doit demissionner pour devenir votre employé !")
        end
        xTarget.setJob(xPlayer.job.name, 0)
        Helper:showAdvancedNotification(xPlayer.source, "~g~Recrutement", xPlayer.name, "Vous avez recruter ~g~"..xTarget.name.."~s~, dans la ~g~"..xPlayer.job.label.."~s~ !", "CHAR_LESTER_DEATHWISH", 1)
        Helper:showAdvancedNotification(xTarget.source, "~g~Recrutement", xPlayer.name, "Vous avez été recruter par "..xPlayer.name.." dans la ~g~"..xPlayer.job.label.."~s~ !", "CHAR_LESTER_DEATHWISH", 1)
    else
        xPlayer.showNotification("~HUD_COLOUR_DEGEN_RED~Vous n'êtes pas patron de l'entreprise !")
    end
end)