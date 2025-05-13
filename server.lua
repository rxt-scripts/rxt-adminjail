local jailedPlayers = {}

RegisterCommand("jail", function(source, args)
    local admin = source
    if not IsPlayerAceAllowed(admin, Config.AdminPermission) then
        TriggerClientEvent("chat:addMessage", admin, {
            args = {"^1[Jail]", "You do not have permission to use this command."}
        })
        return
    end

    local target = tonumber(args[1])
    local time = tonumber(args[2])

    if not target or not time then
        TriggerClientEvent("chat:addMessage", admin, {
            args = {"^1[Jail]", "Usage: /jail [playerId] [minutes]"}
        })
        return
    end

    if GetPlayerPing(target) == 0 then
        TriggerClientEvent("chat:addMessage", admin, {
            args = {"^1[Jail]", "Player not found."}
        })
        return
    end

    jailedPlayers[target] = os.time() + (time * 60)

    TriggerClientEvent("rxt:jailPlayer", target, time)
    TriggerClientEvent("chat:addMessage", admin, {
        args = {"^2[Jail]", string.format(Config.Messages.notifyAdmin, target, time)}
    })
end)

-- Unjail logic
CreateThread(function()
    while true do
        Wait(10000) -- every 10 seconds

        local now = os.time()
        for playerId, releaseTime in pairs(jailedPlayers) do
            if now >= releaseTime then
                TriggerClientEvent("rxt:releasePlayer", playerId)
                jailedPlayers[playerId] = nil
            end
        end
    end
end)
