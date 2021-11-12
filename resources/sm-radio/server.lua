ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterNetEvent('getRadioCount')
AddEventHandler('getRadioCount', function(id)
	local xPlayer = ESX.GetPlayerFromId(id)
	if xPlayer ~= nil then
		TriggerClientEvent('radioCount', id, xPlayer.getInventoryItem("radio").count)
	end
end)