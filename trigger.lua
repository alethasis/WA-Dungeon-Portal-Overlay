function (allstates, event, ...)
    if (event == "SHOW_PORTAL_OVERLAY") then
        local spellFlyoutButtons = aura_env.getSpellFlyoutButtons()

        for _, buttonFrame in ipairs(spellFlyoutButtons) do
            if (buttonFrame and buttonFrame.spellID) then
                local spellID = buttonFrame.spellID
                local shouldShow = aura_env.isReadyToCast(spellID) or
                                       not aura_env.config.hideOnCooldown

                if (aura_env.heroPathData[spellID] and shouldShow) then
                    allstates[spellID] = {
                        show = true,
                        changed = true,
                        buttonFrame = buttonFrame,
                        dungeonAbbreviation = aura_env.heroPathData[spellID],
                        spellID = spellID
                    }
                end
            else
                break -- Potential bug here by exiting early
            end
        end
    end

    if (event == "HIDE_PORTAL_OVERLAY") then
        for _, state in pairs(allstates) do
            state.show = false
            state.changed = true
        end
    end

    return true
end
