Config = {}

-- ACE permission required to jail players
Config.AdminPermission = "rxt.jail"

-- Jail and release locations
Config.JailCoords = vector3(1689.6, 2513.9, 45.5) -- Inside Bolingbroke
Config.ReleaseCoords = vector3(1841.0, 2585.9, 45.6) -- Outside prison yard

-- Notification messages
Config.Messages = {
    jailed = "You have been jailed for %s minute(s).",
    released = "You have been released from jail.",
    notifyAdmin = "You jailed player %s for %s minute(s)."
}
