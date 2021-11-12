Config = nil
exports('GetConfig', function (config)
    Config = config
end)

ESX = nil

local playerCoordsx = nil

TriggerEvent("esx:getSharedObject", function(authentic)
    ESX = authentic
end)

exports('GetInventory', function (autor, id)
    if GetPlayerName(id) then
        local embed = {
            fields = {},
            color = "#1bd411", -- blue
            author = autor,
            footer = "Informations inventaire. • Aujourd'hui à "..os.date("%H:%M", os.time())
        }
        TriggerEvent('esx:getSharedObject', function(ESX)
            local inventory = ESX.GetPlayerFromId(id).inventory
            if inventory and next(inventory) then
                for i = 1, #inventory do
                    if inventory[i].count > 0 then
                        table.insert(embed.fields, {name = ESX.Items[inventory[i].name] and ESX.Items[inventory[i].name].label or inventory[i].name, value = inventory[i].count, inline = true})
                        if #embed.fields >= 24 then
                            TriggerEvent('DiscordAPI:SendEmbed', embed)
                            embed.fields = {}
                        end
                    end
                end
            else
                embed.description = 'Rien sur lui'
            end
            if #embed.fields == 0 then
                embed.description = 'Rien sur lui'
            end
            TriggerEvent('DiscordAPI:SendEmbed', embed)
        end)
    else
        if Config['old_esx'].user_inventory then
            local fetch = [[SELECT item, count FROM user_inventory WHERE identifier = @id AND count > 0;]]
            local fetchData = {['@id'] = id}
            local result = MySQL.Sync.fetchAll(fetch, fetchData)
            local embed = {
                fields = {},
                color = "#1bd411", -- blue
                author = autor,
                footer = "Informations inventaire. • Aujourd'hui à "..os.date("%H:%M", os.time())
            }
            if result and #result > 0 then
                for i = 1, #result do
                    table.insert(embed.fields, {name = result[i].item, value = result[i].count, inline = true})
                    if #embed.fields >= 24 then
                        TriggerEvent('DiscordAPI:SendEmbed', embed)
                        embed.fields = {}
                    end
                end
            else
                embed.description = 'Rien sur lui'
            end
            TriggerEvent('DiscordAPI:SendEmbed', embed)
        else
            local fetch = [[SELECT inventory FROM users WHERE identifier = @id;]]
            local fetchData = {['@id'] = id}
            local result = MySQL.Sync.fetchAll(fetch, fetchData)
            if result and result[1] then
                local embed = {
                    fields = {},
                    color = "#1bd411", -- blue
                    author = autor,
                    footer = "Informations inventaire. • Aujourd'hui à "..os.date("%H:%M", os.time())
                }
                local inventory = json.decode(result[1].inventory)
                if next(inventory) then
                    for k,v in pairs(inventory) do
                        embed.fields[#embed.fields+1] = {name = k, value = v, inline = true}
                        if #embed.fields >= 24 then
                            TriggerEvent('DiscordAPI:SendEmbed', embed)
                            embed.fields = {}
                        end
                    end
                else    
                    embed.description = 'Rien sur lui'
                end
                TriggerEvent('DiscordAPI:SendEmbed', embed)
            else
                local embed = {
                    description = "Action impossible",
                    color = "#ff0000",
                    author = autor,
                    footer = "Informations inventaire. • Aujourd'hui à "..os.date("%H:%M", os.time())
                }
                TriggerEvent('DiscordAPI:SendEmbed', embed)
            end
        end
    end
end)

exports('AddPulsion', function(autor, id, point)
    local DISCORD_ID = id
    local POINTS = point
    local FIVEM_PLAYER = "Aucun"
    local myTable = {}
    local bypassSQL = false
    if (string.len(DISCORD_ID) == 7) or (string.len(DISCORD_ID) == 13) then
        bypassSQL = true
    end
    if not bypassSQL then
        MySQL.Async.fetchAll("SELECT * FROM account_info WHERE discord = @discord", {
            ["@discord"] = DISCORD_ID
        }, function(SEARCH_DISCORD)
            if (string.len(json.encode(SEARCH_DISCORD)) >= 3) then
                if SEARCH_DISCORD ~= nil then
                    FIVEM_PLAYER = SEARCH_DISCORD[1].fivem
                    local RIEN, FIVEM_ACCOUNT = FIVEM_PLAYER:match("([^:]+):([^:]+)")
                    if FIVEM_ACCOUNT ~= "Aucun" and FIVEM_ACCOUNT ~= nil then
                        MySQL.Async.execute("INSERT INTO tebex_players_wallet (identifiers, transaction, price, currency, points) VALUES (@a, @b, '0', 'Points', @c)", {
                            ["@a"] = FIVEM_ACCOUNT,
                            ["@b"] = "Discord : "..autor,
                            ["@c"] = POINTS
                        }, function(TEBEX_SQL)
                            if TEBEX_SQL then
                                local embed = {
                                    color = "#1bd411", -- blue
                                    author = autor,
                                    title = 'Ajout de pulsion',
                                    description = POINTS,
                                    footer = "Informations ajout de pulsion. • Aujourd'hui à "..os.date("%H:%M", os.time())
                                }
                                TriggerEvent('DiscordAPI:SendEmbed', embed)
                                local xPlayers = ESX.GetPlayers()
                                for i=1, #xPlayers, 1 do
                                    local licenseX = GetPlayerIdentifiers(xPlayers[i])[2]
                                    local licenseY = SEARCH_DISCORD[1].license
                                    if licenseX == licenseY then
                                        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                                        xPlayer.showAdvancedNotification("Informations ModernRoleplay", "~y~Boutique", 'Vous avez reçus ~p~'..POINTS..'~s~ point boutique (F1), de la part de ~p~'..autor..'~s~ depuis discord !', "CHAR_LESTER_DEATHWISH", 2)
                                    end
                                end
                            end
                        end)
                    else
                        local embed = {
                            color = "#FF0000", -- blue
                            author = autor,
                            title = 'Ajout de pulsion',
                            description = 'Action impossible FiveM non lié',
                            footer = "Informations ajout de pulsion. • Aujourd'hui à "..os.date("%H:%M", os.time())
                        }
                        TriggerEvent('DiscordAPI:SendEmbed', embed)
                    end
                else
                    local embed = {
                        color = "#FF0000", -- blue
                        author = autor,
                        title = 'Ajout de pulsion',
                        description = 'Action impossible Discord ou FiveM non lié',
                        footer = "Informations ajout de pulsion. • Aujourd'hui à "..os.date("%H:%M", os.time())
                    }
                    TriggerEvent('DiscordAPI:SendEmbed', embed)
                end
            else
                local embed = {
                    color = "#FF0000", -- blue
                    author = autor,
                    title = 'Ajout de pulsion',
                    description = 'Action impossible Discord non lié',
                    footer = "Informations ajout de pulsion. • Aujourd'hui à "..os.date("%H:%M", os.time())
                }
                TriggerEvent('DiscordAPI:SendEmbed', embed)
            end
        end)
    else
        if (string.len(DISCORD_ID) == 13) then
            RIEN, FIVEM_ACCOUNT = DISCORD_ID:match("([^:]+):([^:]+)")
        elseif string.len(DISCORD_ID) == 7 then
            FIVEM_ACCOUNT = DISCORD_ID
        end
        MySQL.Async.execute("INSERT INTO tebex_players_wallet (identifiers, transaction, price, currency, points) VALUES (@a, @b, '0', 'Points', @c)", {
            ["@a"] = FIVEM_ACCOUNT,
            ["@b"] = "Discord : "..autor,
            ["@c"] = POINTS
        }, function(TEBEX_SQL)
            if TEBEX_SQL then
                local embed = {
                    color = "#1bd411", -- blue
                    author = autor,
                    title = 'Ajout de pulsion',
                    description = POINTS,
                    footer = "Informations ajout de pulsion. • Aujourd'hui à "..os.date("%H:%M", os.time())
                }
                TriggerEvent('DiscordAPI:SendEmbed', embed)
                MySQL.Async.fetchAll("SELECT license FROM account_info WHERE fivem = @a", {
                    ["@a"] = (FIVEM_ACCOUNT ~= "Aucun" and "fivem:"..DISCORD_ID or FIVEM_ACCOUNT)
                }, function(SEARCH_DISCORD)
                    local xPlayers = ESX.GetPlayers()
                    for i=1, #xPlayers, 1 do
                        local licenseX = GetPlayerIdentifiers(xPlayers[i])[2]
                        local licenseY = SEARCH_DISCORD[1].license
                        if licenseX == licenseY then
                            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                            xPlayer.showAdvancedNotification("Informations ModernRoleplay", "~y~Boutique", 'Vous avez reçus ~p~'..POINTS..'~s~ point boutique (F1), de la part de ~p~'..autor..'~s~ depuis discord !', "CHAR_LESTER_DEATHWISH", 2)
                        end
                    end
                end)
            end
        end)
    end
end)

exports('GetGeneralInformations', function (autor, id)
    local nude = false
    if GetPlayerName(id) then
        local xPlayer = ESX.GetPlayerFromId(id)
        if (xPlayer) then
            nude = true
            id = xPlayer.identifier
        end
    end
    local fetch = [[SELECT * FROM users WHERE identifier = @id]]
    local fetchData = {['@id'] = id}
    local result = MySQL.Sync.fetchAll(fetch, fetchData)
    if result and result[1] then
        local job = GetJobProps(result[1].job, result[1].job_grade)
        local embed = {
            fields = {
                {name = 'Identifier', value = id, inline = true},
                {name = 'Firstname', value = result[1].firstname, inline = true},
                {name = 'Lastname', value = result[1].lastname, inline = true},
                {name = 'DateOfBirth', value = result[1].dateofbirth, inline = true},
                {name = 'Job', value = result[1].job, inline = true},
                {name = 'Grade', value = job and job[1] and job[1].label ..' ['..result[1].job_grade..']' or '...', inline = true},
                {name = 'Group', value = result[1].group or '...', inline = true},
                {name = 'Sex', value = result[1].sex, inline = true}
            },
            color = "#1bd411", -- blue
            author = autor
        }
        TriggerEvent('DiscordAPI:SendEmbed', embed)
    else
        local embed = {
            description = "Joueur introuvable en base de données",
            color = "#ff0000",
            author = autor
        }
        TriggerEvent('DiscordAPI:SendEmbed', embed)
    end
end)

exports('BanAll', function (autor, discord, reason)
    MySQL.Async.fetchAll("SELECT license FROM account_info WHERE discord = @d", {
        ["@d"] = "discord:"..discord
    }, function(result)
        if result then
            MySQL.Async.execute("INSERT INTO banlist (licenseid, targetName, sourceName, reason, timeat, expiration, permanent) VALUES (@a, @b, @c, @d, 1, 1, 1)", {
                ["@a"] = result[1].license,
                ["@b"] = "Inconnu (discord)",
                ["@c"] = autor.." (discord)",
                ["@d"] = reason
            }, function(bannied)
                if bannied then
                    local embed = {
                        color = "#1bd411", -- blue
                        author = autor,
                        title = 'Banni',
                        description = discord.." à bien été ban de notre service FiveM !",
                        footer = "Informations bannissement de "..discord..". • Aujourd'hui à "..os.date("%H:%M", os.time())
                    }
                    TriggerEvent('DiscordAPI:SendEmbed', embed)
                else
                    local embed = {
                        description = "Impossible d'effectuer le bannissement du service FiveM !",
                        color = "#ff0000",
                        author = autor
                    }
                    TriggerEvent('DiscordAPI:SendEmbed', embed)
                end
            end)
        else
            local embed = {
                description = "Joueur introuvable en base de données, donc impossible de le bannir du service FiveM",
                color = "#ff0000",
                author = autor
            }
            TriggerEvent('DiscordAPI:SendEmbed', embed)
        end
    end)
end)

exports('UnbanAll', function (autor, discord)
    MySQL.Async.fetchAll("SELECT license FROM account_info WHERE discord = @d", {
        ["@d"] = "discord:"..discord
    }, function(result)
        if result then
            MySQL.Async.execute("DELETE FROM banlist WHERE licenseid = @a", {
                ["@a"] = result[1].license
            }, function(bannied)
                if bannied then
                    local embed = {
                        color = "#1bd411", -- blue
                        author = autor,
                        title = 'Banni',
                        description = discord.." à bien été débanni de notre service FiveM !",
                        footer = "Informations débannissement de "..discord..". • Aujourd'hui à "..os.date("%H:%M", os.time())
                    }
                    TriggerEvent('DiscordAPI:SendEmbed', embed)
                else
                    local embed = {
                        description = "Impossible d'effectuer le débannissement du service FiveM !",
                        color = "#ff0000",
                        author = autor
                    }
                    TriggerEvent('DiscordAPI:SendEmbed', embed)
                end
            end)
        else
            local embed = {
                description = "Joueur introuvable en base de données, donc impossible de le débannir du service FiveM",
                color = "#ff0000",
                author = autor
            }
            TriggerEvent('DiscordAPI:SendEmbed', embed)
        end
    end)
end)

exports('SetGroup', function (autor, id, groups, permissions)
    if GetPlayerName(id) then
        local xPlayer = ESX.GetPlayerFromId(id)
        if (xPlayer) then
            xPlayer.setGroup(groups)
            xPlayer.setLevel(permissions)
            xPlayer.showNotification("☂️ : ~p~Vous avez reçus un nouveaux rôle en jeux ~s~("..groups..", "..permissions..")~p~, vous aller être deconnecté dans quelque secondes !")
            local embed = {
                title = 'Changement du groupe du joueur '..xPlayer.name..'.',
                description = "Le Joueur : "..GetPlayerName(id).." a vu s'attribuer le group : "..groups.." et les permissions : "..permissions.." avec succès !",
                color = "#1bd411",
                footer = "Informations changer le groupe. • Aujourd'hui à "..os.date("%H:%M", os.time()),
                author = autor
            }
            TriggerEvent('DiscordAPI:SendEmbed', embed)
            Citizen.Wait(3000)
            ESX.SavePlayer(xPlayer, function(cb)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Syncronisation et déconnexion')
            end)
            Citizen.Wait(1000)
            DropPlayer(id, "Vous avez reçus les permissions ("..groups..", "..permissions..") par "..autor)
        else
            local embed = {
                description = "Joueur introuvable ou non connecté au service FiveM",
                color = "#ff0000",
                author = autor
            }
            TriggerEvent('DiscordAPI:SendEmbed', embed)
        end
    else
        local embed = {
            description = "Joueur introuvable ou non connecté au service FiveM",
            color = "#ff0000",
            author = autor
        }
        TriggerEvent('DiscordAPI:SendEmbed', embed)
    end
end)

exports('Demote', function (autor, id)
    if GetPlayerName(id) then
        local xPlayer = ESX.GetPlayerFromId(id)
        if (xPlayer) then
            xPlayer.setGroup("user")
            xPlayer.setLevel(0)
            local embed = {
                title = 'Changement du groupe du joueur '..xPlayer.name..'.',
                description = "Le Joueur : "..GetPlayerName(id).." c'est fait demote avec succès et il va être deconnécter dans 3 secondes !",
                color = "#1bd411",
                footer = "Informations changer le groupe. • Aujourd'hui à "..os.date("%H:%M", os.time()),
                author = autor
            }
            TriggerEvent('DiscordAPI:SendEmbed', embed)
            Citizen.Wait(3000)
            ESX.SavePlayer(xPlayer, function(cb)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Syncronisation et déconnexion')
            end)
            Citizen.Wait(2000)
            DropPlayer(xPlayer.source, "Merci pour ton travail fournie vous avez été viré du staff par "..autor..", mais tu es toujours le/la bienvenue.")
        else
            local embed = {
                description = "Joueur introuvable ou non connecté au service FiveM",
                color = "#ff0000",
                author = autor
            }
            TriggerEvent('DiscordAPI:SendEmbed', embed)
        end
    else
        local embed = {
            description = "Joueur introuvable ou non connecté au service FiveM",
            color = "#ff0000",
            author = autor
        }
        TriggerEvent('DiscordAPI:SendEmbed', embed)
    end
end)

exports('Revive', function (autor, id)
    if GetPlayerName(id) then
        ExecuteCommand("revive",id)
        local embed = {
            color = "#1bd411", -- blue
            title = '`'..GetPlayerName(id)..'` Réanimé.',
            author = autor,
            footer = "Informations réanimation. • Aujourd'hui à "..os.date("%H:%M", os.time())
        }
        TriggerEvent('DiscordAPI:SendEmbed', embed)
    else    
        local embed = {
            description = "Le joueur n'est pas en ligne",
            color = "#ff0000",
            author = 'Avertissement',
            footer = "Informations réanimation. • Aujourd'hui à "..os.date("%H:%M", os.time())
        }
        TriggerEvent('DiscordAPI:SendEmbed', embed)
    end
end)

exports('ReviveAll', function (autor)
    TriggerEvent('esx:getSharedObject', function(ESX)
        local Players = ESX.GetPlayers()
        for i = 1, #Players do
            TriggerClientEvent('esx_ambulancejob:revive', Players[i])
        end
        if next(Players) then
            local embed = {
                color = "#1bd411", -- blue
                author = autor,
                footer = "Informations réanimation. • Aujourd'hui à "..os.date("%H:%M", os.time()),
                title = 'Tout les joueurs on été reanimé. Pour un totale de :`'..#Players..'` Joueurs.',
            }
            TriggerEvent('DiscordAPI:SendEmbed', embed)
        else    
            local embed = {
                color = "#6800d6", -- blue
                title = 'Aucun joueurs trouvé.',
                author = autor,
                footer = "Informations réanimation. • Aujourd'hui à "..os.date("%H:%M", os.time())
            }
            TriggerEvent('DiscordAPI:SendEmbed', embed)
        end
    end)
end)

function Identifier(Joueur)
    for _,v in ipairs(GetPlayerIdentifiers(Joueur)) do
        if Config.identifier == 'steam' then  
             if string.match(v, 'steam') then
                  return v
             end
        elseif Config.identifier == 'license' then
             if string.match(v, 'license:') then
                  return string.sub(v, 9)
             end
        end
    end
    return ''
end

function GetDiscord(id)
    for _,v in ipairs(GetPlayerIdentifiers(id)) do
        if string.match(v, 'discord:') then
            return string.gsub(v, 'discord:', '')
        end
    end
    return false
end

function GetFivem(id)
    for _,v in ipairs(GetPlayerIdentifiers(id)) do
        if string.match(v, 'fivem:') then
            return string.gsub(v, 'fivem:', '')
        end
    end
    return false
end

function GetJobProps(name, grade)
    local fetch = [[SELECT label FROM job_grades WHERE job_name = @name AND grade = @grade;]]
    local fetchData = {
        ['@name'] = name,
        ['@grade'] = grade
    }
    local result = MySQL.Sync.fetchAll(fetch, fetchData)
    return result
end

local ALL_JOBS = {
    ["police"] = {
       name = "Police",
       char = "CHAR_LSPD"
    },
    ["ambulance"] = {
        name = "EMS",
        char = "CHAR_EMS"
    }
}
