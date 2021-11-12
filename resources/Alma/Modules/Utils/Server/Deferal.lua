PLAYER_BANNED = {};

function IsBanned(token)
    MySQL.Async.fetchAll("SELECT id_ban, by_name, reason, permanent, expiration FROM alma_ban WHERE tokens = @tokens", {
        ['@tokens'] = token
    }, function(result)
        if result[1] then
            if os.time() < result[1].expiration then
                PLAYER_BANNED[token] = {
                    id_ban = result[1].id_ban,
                    by_name = result[1].by_name,
                    reason = result[1].reason,
                    permanent = result[1].permanent,
                    expiration = result[1].expiration
                }
            else
                MySQL.Async.execute("DELETE FROM alma_ban WHERE id_ban = @a", {
                    ["@a"] = result[1].id_ban
                })
                PLAYER_BANNED[token] = {
                    id_ban = nil,
                    by_name = nil,
                    reason = nil,
                    permanent = nil,
                    expiration = nil
                }
            end
        else
            PLAYER_BANNED[token] = {
                id_ban = nil,
                by_name = nil,
                reason = nil,
                permanent = nil,
                expiration = nil
            }
        end
    end)
end


function BanPlayer(id, tokens, reason, expi, source, deco)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute("INSERT INTO alma_ban (tokens, by_name, user_name, reason, expiration, permanent) VALUES(@tokens, @by_name, @user_name, @reason, @expiration, @permanent)", {
        ["@by_name"] = "["..LABEL_STAFF_GROUP[xPlayer.getGroup()].. "] "..GetPlayerName(source),
        ["@tokens"] = tokens,
        ["@user_name"] = GetPlayerName(id),
        ["@reason"] = reason,
        ["@expiration"] = (expi == 0 and os.time() or os.time() + expi),
        ["@permanent"] = (expi == 0 and 1 or 0)
    }, function(result)
        if result then
            xPlayer.showNotification("Vous avez banni ~r~"..GetPlayerName(id).."~s~, pour ~r~"..reason.."~s~, pendant ~r~"..(expi == 0 and "infini" or expi / 3600  .."h"))
            if deco then
                DropPlayer(tonumber(id), "Vous venez de vous faire bannir de notre serveur (Alma V2), par ["..LABEL_STAFF_GROUP[xPlayer.getGroup()].."] "..xPlayer.name..", si vous pensez que cette une erreur rejoignez notre discord : https://discord.gg/X5HmUv3xfW")
            end
        end
    end)
end

AddEventHandler("playerConnecting", function(name, blc, deferals)
    local source = source;
    deferals.defer()
    local function Reverse(s)
        return string.gsub(s, "(.)(.)", "%2%1")
    end
    for i = 1, 5 do
        deferals.presentCard({
            ["type"] = "AdaptiveCard",
            ["minHeight"] = "100px",
            ["body"] = {
                {
                    type = "Container",
                    items = {
                        {
                            type = "Image",
                            url = "https://images-ext-1.discordapp.net/attachments/908057347098812446/908057739320782898/8250909609248686083.png",
                            size = "medium",
                            horizontalAlignment = "center",
                            style = "person"
                        },
                        {
                            type = "TextBlock",
                            horizontalAlignment = "center",
                            text = "Bienvenue sur Alma V2, nous vous attendions "..(i == 1 and name or i == 2 and Reverse(name) or i == 3 and name or i == 4 and Reverse(name) or name)
                        }
                    }
                }
            },
            ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
            ["version"] = "1.2"
        })
        Citizen.Wait(200)
    end
    for fs = 0, GetNumPlayerTokens(source) - 1 do
        deferals.presentCard({
            ["type"] = "AdaptiveCard",
            ["minHeight"] = "100px",
            ["body"] = {
                {
                    type = "Container",
                    items = {
                        {
                            type = "Image",
                            url = "https://images-ext-1.discordapp.net/attachments/908057347098812446/908057739320782898/8250909609248686083.png",
                            size = "medium",
                            horizontalAlignment = "center",
                            style = "person"
                        },
                        {
                            type = "TextBlock",
                            horizontalAlignment = "center",
                            text = "Vérification des tokens ["..fs.."/"..GetNumPlayerTokens(source)-1 .."]"
                        }
                    }
                }
            },
            ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
            ["version"] = "1.2"
        })
        Citizen.Wait(100)
    end
    local token = GetPlayerToken(source, 1)
    IsBanned(token)
    Citizen.Wait(400)
    if PLAYER_BANNED[token].id_ban == nil then
        deferals.done()
    else
        deferals.presentCard({
            ["type"] = "AdaptiveCard",
            ["minHeight"] = "100px",
            ["body"] = {
                {
                    type = "Container",
                    items = {
                        {
                            type = "Image",
                            url = "https://images-ext-1.discordapp.net/attachments/908057347098812446/908057739320782898/8250909609248686083.png",
                            size = "medium",
                            horizontalAlignment = "center",
                            style = "person"
                        },
                        {
                            type = "TextBlock",
                            horizontalAlignment = "center",
                            text = "Votre code de banissement : "..tonumber(PLAYER_BANNED[token].id_ban)
                        },
                        {
                            type = "TextBlock",
                            horizontalAlignment = "center",
                            text = "Vous avez été banni de Alma V2 : "..tostring(PLAYER_BANNED[token].reason)
                        },
                        {
                            type = "TextBlock",
                            horizontalAlignment = "center",
                            text = "Par "..tostring(PLAYER_BANNED[token].by_name):gsub("~", "")
                        },
                        {
                            type = "TextBlock",
                            horizontalAlignment = "center",
                            text = (PLAYER_BANNED[token].permanent == false and "Temps restant : "..math.floor((PLAYER_BANNED[token].expiration - os.time()) / 60 / 60 / 24) .. " jour(s) " .. math.floor(((PLAYER_BANNED[token].expiration - os.time()) / 60 / 60 / 24 - math.floor((PLAYER_BANNED[token].expiration - os.time()) / 60 / 60 / 24)) * 24) .. " heure(s) " .. math.ceil((((PLAYER_BANNED[token].expiration - os.time()) / 60 / 60 / 24 - math.floor((PLAYER_BANNED[token].expiration - os.time()) / 60 / 60 / 24)) * 24 - math.floor(((PLAYER_BANNED[token].expiration - os.time()) / 60 / 60 / 24 - math.floor((PLAYER_BANNED[token].expiration - os.time()) / 60 / 60 / 24)) * 24)) * 60) .. " minutes" or PLAYER_BANNED[token].permanent == true and "Temps de bannissement permanent")
                        },
                    }
                }
            },
            ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
            ["version"] = "1.2"
        })
        return
    end
end)

BAN = {
    ["admin"] = true,
    ["gf"] = true,
    ["gi"] = true,
    ["gl"] = true,
    ["fondateur"] = true,
    ["superadmin"] = true,
    ["devlopper"] = true
}

RegisterCommand("banissement", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source);
    if not BAN[xPlayer.getGroup()] then return end
    if args[1] and args[2] and args[3] then
        if GetPlayerName(tonumber(args[1])) then
            local id = args[1]
            local time = args[2]
            table.remove(args, 2)
            table.remove(args, 1)
            local argsT = table.concat(args, " ")
            if tonumber(args[2]) == 0 then
                BanPlayer(tonumber(id), GetPlayerToken(tonumber(id), 1), tostring(argsT), 0, source, true)
            else
                BanPlayer(tonumber(id), GetPlayerToken(tonumber(id), 1), tostring(argsT), tonumber(time) * 3600, source, true)
            end
        else
            xPlayer.showNotification("~r~Ce joueur n'est pas ou plus connecté !")
        end
    else
        xPlayer.showNotification("~r~Pour utiliser le bannisement vous devez suivre cette exemple :\n\n /bannissement [id] [temps en sec] [raison de la sanction]")
    end
end)

RegisterCommand("info-ban", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source);
    if args[1] then
        MySQL.Async.fetchAll("SELECT user_name, expiration, reason, by_name FROM alma_ban WHERE id_ban = @a", {
            ["@a"] = tonumber(args[1])
        }, function(result)
            if result[1] then
                xPlayer.showNotification("Banni par : "..result[1].by_name.."\nRaison : "..result[1].reason.."\nExpiration : " .. math.floor((result[1].expiration - os.time()) / 60 / 60 / 24) .. " jour(s) " .. math.floor(((result[1].expiration - os.time()) / 60 / 60 / 24 - math.floor((result[1].expiration - os.time()) / 60 / 60 / 24)) * 24) .. " heure(s) " .. math.ceil((((result[1].expiration - os.time()) / 60 / 60 / 24 - math.floor((result[1].expiration - os.time()) / 60 / 60 / 24)) * 24 - math.floor(((result[1].expiration - os.time()) / 60 / 60 / 24 - math.floor((result[1].expiration - os.time()) / 60 / 60 / 24)) * 24)) * 60) .. " minutes")
            else
                xPlayer.showNotification("~HUD_COLOUR_DEGEN_YELLOW~Banissement~s~\nErreur : ~r~Code de banissement erroné !")
            end
        end)
    else
        xPlayer.showNotification("~r~Pour utiliser les informations vous devez suivre cette exemple :\n\n/info-ban [code]")
    end
end)

RegisterCommand("unban", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source);
    if args[1] then
        MySQL.Async.fetchAll("SELECT user_name, expiration, reason, by_name FROM alma_ban WHERE id_ban = @a", {
            ["@a"] = tonumber(args[1])
        }, function(result)
            if result[1] then
                xPlayer.showNotification("~HUD_COLOUR_DEGEN_YELLOW~Banissement~s~\nCode de ban : "..args[1].." supprimer\nBanni par : "..result[1].by_name)
                MySQL.Async.execute("DELETE FROM alma_ban WHERE id_ban = @a", {
                    ["@a"] = tonumber(args[1])
                })
            else
                xPlayer.showNotification("~HUD_COLOUR_DEGEN_YELLOW~Banissement~s~\nErreur : ~r~Code de banissement erroné !")
            end
        end)
    else
        xPlayer.showNotification("~r~Pour utiliser le débanissement vous devez suivre cette exemple :\n\n/unban [code]")
    end
end)