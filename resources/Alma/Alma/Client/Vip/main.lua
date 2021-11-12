local vipRank = 0

Alma.netRegisterAndHandle('AlmaVIP:updateVip', function(rank)
    vipRank = rank
end)

Alma.newThread(function()
    ESX.TriggerServerCallback("AlmaVIP:getVip", function(vip) 
        vipRank = vip
    end)
end)

function GetVIP()
    return vipRank
end