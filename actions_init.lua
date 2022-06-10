-- CONSTANTS
aura_env.heroPathData = {
    [354462] = "NW",
    [354463] = "PF",
    [354464] = "Mists",
    [354465] = "HOA",
    [354466] = "SOA",
    [354467] = "TOP",
    [354468] = "DOS",
    [354469] = "SD",
    [367416] = "TAZ"
}

-- UTIL
aura_env.getKeys = function(t)
    local keys = {}
    for key, _ in pairs(t) do table.insert(keys, key) end
    return keys
end

aura_env.tableLength = function(t)
    local keys = aura_env.getKeys(t)
    return table.getn(keys)
end

aura_env.getNumPaths = function()
    return aura_env.tableLength(aura_env.heroPathData)
end

aura_env.getSpellFlyoutButtons = function()
    local spellFlyoutButtons = {}

    for i = 1, aura_env.getNumPaths() do
        local buttonNameRoot = "SpellFlyoutButton"
        local button = _G[buttonNameRoot .. i]
        table.insert(spellFlyoutButtons, button)
    end

    return spellFlyoutButtons
end

aura_env.isReadyToCast = function(spellID)
    local _, duration = GetSpellCooldown(spellID)

    return duration == 0
end

-- INIT
if not aura_env.region.SpellFlyoutHook then
    local aura_env = aura_env

    C_Timer.After(1, function()
        SpellFlyout:HookScript("OnShow", function()
            WeakAuras.ScanEvents("SHOW_PORTAL_OVERLAY", true)
        end)
        SpellFlyout:HookScript("OnHide", function()
            WeakAuras.ScanEvents("HIDE_PORTAL_OVERLAY", true)
        end)

        aura_env.region.SpellFlyoutHook = true
    end)
end
