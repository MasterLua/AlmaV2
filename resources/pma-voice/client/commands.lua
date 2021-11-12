RegisterCommand('setvoiceintent', function(source, args)
    if GetConvarInt('voice_allowSetIntent', 1) == 1 then
        local intent = args[1]
        if intent == 'speech' then
            MumbleSetAudioInputIntent(GetHashKey('speech'))
        elseif intent == 'music' then
            MumbleSetAudioInputIntent(GetHashKey('music'))
        end
    end
end)

-- TODO: Better implementation of this?
RegisterCommand('vol', function(_, args)
    if not args[1] then
        return
    end
    setVolume(args[1])
end)

function ForceMinimalVoiceProximity()
    if playerMuted then
        return
    end
    print('forced minimal voice proximity')
    PlaySoundFrontend(-1, 'Goon_Paid_Small', 'GTAO_Boss_Goons_FM_Soundset', 0)

    local voiceModeData = Cfg.voiceModes[1]
    MumbleSetAudioInputDistance(voiceModeData[1] + 0.0)
    LocalPlayer.state:set('proximity', {
        index = 1,
        distance = voiceModeData[1],
        mode = voiceModeData[2],
    }, GetConvarInt('voice_syncData', 1) == 1)
    -- make sure we update the UI to the latest voice mode
    SendNUIMessage({
        voiceMode = 0
    })
    TriggerEvent('pma-voice:setTalkingMode', 1)
end

local function UpdateVoiceProximity()
    if GetConvarInt('voice_enableProximity', 1) ~= 1 then
        return
    end
    if playerMuted then
        return
    end
    if (not IsAllowedToChangeProximity) then
        return print('your are not allowed to perform this action')
    end

    PlaySoundFrontend(-1, 'Goon_Paid_Small', 'GTAO_Boss_Goons_FM_Soundset', 0)
    local voiceMode = mode
    local newMode = voiceMode + 1

    voiceMode = (newMode <= #Cfg.voiceModes and newMode) or 1
    local voiceModeData = Cfg.voiceModes[voiceMode]
    MumbleSetAudioInputDistance(voiceModeData[1] + 0.0)
    mode = voiceMode
    LocalPlayer.state:set('proximity', {
        index = voiceMode,
        distance = voiceModeData[1],
        mode = voiceModeData[2],
    }, GetConvarInt('voice_syncData', 1) == 1)
    -- make sure we update the UI to the latest voice mode
    SendNUIMessage({
        voiceMode = voiceMode - 1
    })
    TriggerEvent('pma-voice:setTalkingMode', voiceMode)
    Citizen.SetTimeout(1000, function()
        showRadius = false
    end)
end

RegisterCommand('cycleproximity', function()
    UpdateVoiceProximity()

end, false)
RegisterKeyMapping('cycleproximity', 'Changer la portée de sa voix', 'keyboard', GetConvar('voice_defaultCycle', 'W'))

