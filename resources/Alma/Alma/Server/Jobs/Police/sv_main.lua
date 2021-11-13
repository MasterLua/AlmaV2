local IN_SERVICE_JOB = {}

local LABEL = {
    ["police"] = {
        label = "Police",
        char = "CHAR_CALL911"
    }
}

Alma:AddEventHandler("Jobs", "Join", function(job)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if job == xPlayer.job.name then
        IN_SERVICE_JOB[source] = {}
        IN_SERVICE_JOB[source].job = job
        IN_SERVICE_JOB[source].service = true
        for k,v in pairs(IN_SERVICE_JOB) do
            if v.job == job then
                Helper:showAdvancedNotification(k, LABEL[xPlayer.job.name].label or "<Inconnu>", xPlayer.name, "A pris son service .", LABEL[xPlayer.job.name].char or "CHAR_ACTING_UP", 1)
            end
        end
    end
end)

Alma:AddEventHandler("Jobs", "Leave", function(job)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if job == xPlayer.job.name then
        IN_SERVICE_JOB[source] = {}
        IN_SERVICE_JOB[source].job = job
        IN_SERVICE_JOB[source].service = false
        for k,v in pairs(IN_SERVICE_JOB) do
            if v.job == job then
                Helper:showAdvancedNotification(k, LABEL[xPlayer.job.name].label or "<Inconnu>", xPlayer.name, "A quitter son service .", LABEL[xPlayer.job.name].char or "CHAR_ACTING_UP", 1)
            end
        end
    end
end)

Alma:AddEventHandler("Jobs", "Fouiller", function(job, id)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(id)
    if xPlayer.job.name == job then
        Alma:TriggerClientEvent("Job", "Fouiller", source, xTarget.getInventory())
    end
end)