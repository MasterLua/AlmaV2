local labeltype = nil

function random(x, y)
    local u = 0;
    u = u + 1
    if x ~= nil and y ~= nil then
        return math.floor(x + (math.random(math.randomseed(os.time() + u)) * 999999 % y))
    else
        return math.floor((math.random(math.randomseed(os.time() + u)) * 100))
    end
end
---@class eBoutique
eBoutique = eBoutique or {};

---@class eBoutique.Cache
eBoutique.Cache = eBoutique.Cache or {}

---@class eBoutique.Cache.Case
eBoutique.Cache.Case = eBoutique.Cache.Case or {}

function GenerateLootbox(source, box, list)
    local chance = random(1, 100)
    local gift = { category = 1, item = 1 }
    local minimalChance = 4

    local identifier = GetIdentifiers(source);
    if (eBoutique.Cache.Case[source] == nil) then
        eBoutique.Cache.Case[source] = {};
        if (eBoutique.Cache.Case[source][box] == nil) then
            eBoutique.Cache.Case[source][box] = {};
        end
    end
    if chance <= minimalChance then
        local rand = random(1, #list[3])
        eBoutique.Cache.Case[source][box][3] = list[3][rand]
        gift.category = 3
        gift.item = list[3][rand]
    elseif (chance > minimalChance and chance <= 30) then
        local rand = random(1, #list[2])
        eBoutique.Cache.Case[source][box][2] = list[2][rand]
        gift.category = 2
        gift.item = list[2][rand]
    else
        local rand = random(1, #list[1])
        eBoutique.Cache.Case[source][box][1] = list[1][rand]
        gift.category = 1
        gift.item = list[1][rand]
    end
    local finalList = {}
    for _, category in pairs(list) do
        for _, item in pairs(category) do
            local result = { name = item, time = 150 }
            table.insert(finalList, result)
        end
    end
    table.insert(finalList, { name = gift.item, time = 5000 })
    return finalList, gift.item
end

Alma.netRegisterAndHandle('Modern:process_checkout_case', function(type)
    local _src = source
    local source = source;
    if (source) then
        local identifier = GetIdentifiers(source);
        local xPlayer = ESX.GetPlayerFromId(source)
        if type == 1 then
            labeltype = "Caisse Gold"
        elseif type == 2 then
            labeltype = "Caisse Diamond"
        elseif type == 3 then
            labeltype = "Caisse Ruby"
        end
        if (xPlayer) then
            if type == 1 then
                OnProcessCheckout(source, 1000, "Achat d'une caisse (Gold)", function()
                    MomoLogs('https://discord.com/api/webhooks/898899938518368257/GTXf1yjSv2imF2MvaWvA9GEM23gGx_LQbmdDX7lPoR2aO8JqfyWSOqwK3UuVJkV5NHJJ', "Boutique - Achat","**"..GetPlayerName(source).."** vient d'acheter : ***"..labeltype.."***\n **License** : "..xPlayer.identifier, 56108)
                    local boxId = 1;
                    local lists, result = GenerateLootbox(source, boxId, box[boxId])
                    local giveReward = {
                        ["ModernCoins"] = function(_s, license, player)
                            local before, after = result:match("([^_]+)_([^_]+)")
                            local quantity = tonumber(after)
                            if (identifier['fivem']) then
                                local _, fivemid = identifier['fivem']:match("([^:]+):([^:]+)")
                                LiteMySQL:Insert('alma_wallet', {
                                    identifiers = fivemid,
                                    transaction = "Gain dans la boîte ModernCoins",
                                    price = '0',
                                    currency = 'Points',
                                    points = quantity,
                                });
                            end
                        end,
                        ["vehicle"] = function(_s, license, player)
                            if result == 'mule' then 
                                local plate = CreateRandomPlateText()
                                LiteMySQL:Insert('owned_vehicles', {
                                    owner = xPlayer.identifier,
                                    plate = plate,
                                    label = result,
                                    vehicle = json.encode({ model = GetHashKey(result), plate = plate }),
                                    state = 1,
                                    type = 'car',
                                })
                            else
                                local plate = CreateRandomPlateText()
                                LiteMySQL:Insert('owned_vehicles', {
                                    owner = xPlayer.identifier,
                                    plate = plate,
                                    label = result,
                                    vehicle = json.encode({ model = GetHashKey(result), plate = plate }),
                                    state = 1,
                                    type = 'car',
                                    boutique = 1
                                })
                            end
                        end,
                        ["weapon"] = function(_s, license, player)
                            xPlayer.addWeapon(result, 250)
                        end,
                        ["money"] = function(_s, license, player)
                            local before, after = result:match("([^_]+)_([^_]+)")
                            local quantity = tonumber(after)
                            xPlayer.addAccountMoney('bank', quantity)
                        end,
                    }

                    local r = reward[result];
                    if (r ~= nil) then
                        if (giveReward[r.type]) then
                            giveReward[r.type](source, identifier['license'], xPlayer);
                        end
                    end
                    if (identifier['fivem']) then
                        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
                        LiteMySQL:Insert('alma_wallet', {
                            identifiers = after,
                            transaction = r.message,
                            price = '0',
                            currency = 'Box',
                            points = 0,
                        });
                    end
                    MomoLogs('https://discord.com/api/webhooks/898900103249690654/COHgAAfWpBAoAAecTet8LNqZtpolewCnyu0k3kptcY-4eDSRrmp5zVXyZVPtdOkHlleX', "Boutique - Achat","**"..GetPlayerName(source).."** vient de gagner : ***"..result.."***\n **License** : "..xPlayer.identifier, 56108)
                    MomoLogs('https://discord.com/api/webhooks/898899938518368257/GTXf1yjSv2imF2MvaWvA9GEM23gGx_LQbmdDX7lPoR2aO8JqfyWSOqwK3UuVJkV5NHJJ', "Boutique - Achat","**"..GetPlayerName(source).."** vient de gagner : ***"..result.."***\n **License** : "..xPlayer.identifier, 56108)
                    AlmaServerUtils.toClient('ewen:caisseopenclientside', source, lists, result, r.message)
                    end, function()
                    return
                end)
            elseif type == 2 then
                OnProcessCheckout(source, 3000, "Achat d'une caisse (Diamond)", function()
                    MomoLogs('https://discord.com/api/webhooks/898900103249690654/COHgAAfWpBAoAAecTet8LNqZtpolewCnyu0k3kptcY-4eDSRrmp5zVXyZVPtdOkHlleX', "Boutique - Achat","**"..GetPlayerName(source).."** vient d'acheter : ***"..labeltype.."***\n **License** : "..xPlayer.identifier, 56108)
                    local boxId = 1;
                    local lists, result = GenerateLootbox(source, boxId, box2[boxId])
                    local giveReward = {
                        ["ModernCoins"] = function(_s, license, player)
                            local before, after = result:match("([^_]+)_([^_]+)")
                            local quantity = tonumber(after)
                            if (identifier['fivem']) then
                                local _, fivemid = identifier['fivem']:match("([^:]+):([^:]+)")
                                LiteMySQL:Insert('alma_wallet', {
                                    identifiers = fivemid,
                                    transaction = "Gain dans la boîte ModernCoins",
                                    price = '0',
                                    currency = 'Points',
                                    points = quantity,
                                });
                            end
                        end,
                        ["vehicle"] = function(_s, license, player)
                            local plate = CreateRandomPlateText()
                            LiteMySQL:Insert('owned_vehicles', {
                                owner = license,
                                plate = plate,
                                label = result,
                                vehicle = json.encode({ model = GetHashKey(result), plate = plate }),
                                state = 1,
                                type = 'car',
                                boutique = 1
                            })
                        end,
                        ["vip_gold"] = function(_s, license, player)
                            local identifier = GetIdentifiers(source);
                            if (identifier['fivem']) then
                                local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
                                ExecuteCommand('addVipLifetime '.. after..' 1 Gain dans la Caisse Diamond')
                            end
                        end,
                        ["weapon"] = function(_s, license, player)
                            xPlayer.addWeapon(result, 150)
                        end,
                        ["money"] = function(_s, license, player)
                            local before, after = result:match("([^_]+)_([^_]+)")
                            local quantity = tonumber(after)
                            player.addAccountMoney('bank', quantity)
                        end,
                    }
                    local r = reward[result];
                    if (r ~= nil) then
                        if (giveReward[r.type]) then
                            giveReward[r.type](source, identifier['license'], xPlayer);
                        end
                    end
                    if (identifier['fivem']) then
                        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
                        LiteMySQL:Insert('alma_wallet', {
                            identifiers = after,
                            transaction = r.message,
                            price = '0',
                            currency = 'Box',
                            points = 0,
                        });
                    end
                    MomoLogs('https://discord.com/api/webhooks/898900103249690654/COHgAAfWpBAoAAecTet8LNqZtpolewCnyu0k3kptcY-4eDSRrmp5zVXyZVPtdOkHlleX', "Boutique - Achat","**"..GetPlayerName(source).."** vient de gagner : ***"..result.."***\n **License** : "..xPlayer.identifier, 56108)
                    MomoLogs('https://discord.com/api/webhooks/898900263853772871/D3GZ7AgLfZe7WPfd6RK6pP0EOdNXL6wREwpbpeiOJZWTg8HdUMOwogxA6nYHuIFADiG6', "Boutique - Achat","**"..GetPlayerName(source).."** vient de gagner : ***"..result.."***\n **License** : "..xPlayer.identifier, 56108)
                    AlmaServerUtils.toClient('ewen:caisseopenclientside', source, lists, result, r.message)
                    end, function()
                    return
                end)
            elseif type == 3 then
                OnProcessCheckout(source, 5000, "Achat d'une caisse (Ruby)", function()
                    MomoLogs('https://discord.com/api/webhooks/898900103249690654/COHgAAfWpBAoAAecTet8LNqZtpolewCnyu0k3kptcY-4eDSRrmp5zVXyZVPtdOkHlleX', "Boutique - Achat","**"..GetPlayerName(source).."** vient d'acheter : ***"..labeltype.."***\n **License** : "..xPlayer.identifier, 56108)
                    local boxId = 1;
                    local lists, result = GenerateLootbox(source, boxId, box3[boxId])
                    local giveReward = {
                        ["ModernCoins"] = function(_s, license, player)
                            local before, after = result:match("([^_]+)_([^_]+)")
                            local quantity = tonumber(after)
                            if (identifier['fivem']) then
                                local _, fivemid = identifier['fivem']:match("([^:]+):([^:]+)")
                                LiteMySQL:Insert('alma_wallet', {
                                    identifiers = fivemid,
                                    transaction = "Gain dans la boîte ModernCoins",
                                    price = '0',
                                    currency = 'Points',
                                    points = quantity,
                                });
                            end
                        end,
                        ["vehicle"] = function(_s, license, player)
                            local plate = CreateRandomPlateText()
                            LiteMySQL:Insert('owned_vehicles', {
                                owner = license,
                                plate = plate,
                                label = result,
                                vehicle = json.encode({ model = GetHashKey(result), plate = plate }),
                                state = 1,
                                type = 'car',
                                boutique = 1
                            })
                        end,
                        ["helico"] = function(_s, license, player)
                            local plate = CreateRandomPlateText()
                            LiteMySQL:Insert('owned_vehicles', {
                                owner = license,
                                plate = plate,
                                label = result,
                                vehicle = json.encode({ model = GetHashKey(result), plate = plate }),
                                state = 1,
                                type = 'aircraft',
                                boutique = 1
                            })
                        end,
                        ["vip_diamond"] = function(_s, license, player)
                            local identifier = GetIdentifiers(source);
                            if (identifier['fivem']) then
                                local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
                                ExecuteCommand('addVipLifetime '.. after..' 2 Gain dans la Caisse Ruby')
                            end
                        end,
                        ["weapon"] = function(_s, license, player)
                            xPlayer.addWeapon(result, 150)
                        end,
                        ["money"] = function(_s, license, player)
                            local before, after = result:match("([^_]+)_([^_]+)")
                            local quantity = tonumber(after)
                            player.addAccountMoney('bank', quantity)
                        end,
                    }
                    local r = reward[result];
                    if (r ~= nil) then
                        if (giveReward[r.type]) then
                            giveReward[r.type](source, identifier['license'], xPlayer);
                        end
                    end
                    if (identifier['fivem']) then
                        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
                        LiteMySQL:Insert('alma_wallet', {
                            identifiers = after,
                            transaction = r.message,
                            price = '0',
                            currency = 'Box',
                            points = 0,
                        });
                    end
                    MomoLogs('https://discord.com/api/webhooks/898900103249690654/COHgAAfWpBAoAAecTet8LNqZtpolewCnyu0k3kptcY-4eDSRrmp5zVXyZVPtdOkHlleX', "Boutique - Achat","**"..GetPlayerName(source).."** vient de gagner : ***"..result.."***\n **License** : "..xPlayer.identifier, 56108)
                    MomoLogs('https://discord.com/api/webhooks/898900455709618266/dLgqJJObpL6Cj1AhgFgR2y-LONqEAx3rylcjhlOAlXyC0IRtLdlxNoRu9GZx1WIfvRtJ', "Boutique - Achat","**"..GetPlayerName(source).."** vient de gagner : ***"..result.."***\n **License** : "..xPlayer.identifier, 56108)
                    AlmaServerUtils.toClient('ewen:caisseopenclientside', source, lists, result, r.message)
                    end, function()
                        return
                end)
            end
        else
            print('[Error] Failed to retrieve ESX player')
        end
    else
        print('[Error] Failed to retrieve source')
    end
end)