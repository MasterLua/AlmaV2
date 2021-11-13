function GetIdentifiers(source)
    if (source ~= nil) then
        local identifiers = {}
        local playerIdentifiers = GetPlayerIdentifiers(source)
        for _, v in pairs(playerIdentifiers) do
            local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
            identifiers[before] = playerIdentifiers[_]
        end
        return identifiers
    else
        error("source is nil")
    end
end

function GetBoutiqueCoin(identifier)
    if (identifier['fivem']) then
        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")

        MySQL.Async.fetchAll("SELECT SUM(points) FROM alma_wallet WHERE identifiers = @identifiers", {
            ['@identifiers'] = after
        }, function(result)
            if (result[1]["SUM(points)"] ~= nil) then
                coins = result[1]["SUM(points)"]
            else
                print('[Info] retrieve points nil')
                coins = 0;
            end
        end);
        return coins
    else
        return "ya pas wsh"
    end
end

function GetResultOf(reques)
    MySQL.Async.fetchAll(reques, {}, function(res)
        zeres = res
    end)
    return zeres
end

function GetResultOfs(reqe)
    MySQL.Async.execute(reques, {}, function(res)
        zeres = res
    end)
    return zeres
end

function GetBoutiqueHistory(identifier)
    if (identifier['fivem']) then
        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")

        MySQL.Async.fetchAll("SELECT * FROM alma_wallet WHERE identifiers = @identifiers", {
            ['@identifiers'] = after
        }, function(result)
            if (result[1] ~= nil) then
                history = result
            else
                history = {}
            end
        end);
        return history
    else
        return "ya pas wsh"
    end
end