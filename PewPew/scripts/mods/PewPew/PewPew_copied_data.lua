local mod = get_mod("PewPew")

-- ##################################
-- DATA
-- ##################################
-- ##################
-- Locals for Performance
-- ##################
local tostring = tostring
local type = type
local pairs = pairs
local ipairs = ipairs
local table = table
local table_clone = table.clone
local table_insert = table.insert

-- ##################
-- Game Info
-- ##################
local PlayerCharacterSoundEventAliases = require("scripts/settings/sound/player_character_sound_event_aliases")

-- ##################################
-- Copying Data, then Assigning to a Global
-- ##################################
-- Copy Ranged Sounds
local sound_events_to_copy = {
    "ranged_single_shot_special_extra",
    -- rn it's just one but i'm keeping it like this for flexibility
}
local original_PCSEA_ranged_effects = {}
for _, shoot_effect_name in ipairs(sound_events_to_copy) do
    original_PCSEA_ranged_effects[shoot_effect_name] = {
        events = table_clone(PlayerCharacterSoundEventAliases[shoot_effect_name].events)
    }
end
-- Removes entries from bots and default
original_PCSEA_ranged_effects.events["default"] = nil
--[[
-- Only one thign to remove
for weapon_key, _ in pairs(original_PCSEA_ranged_effects.events) do
    
end
]]

mod.original_PCSEA_ranged_effects = original_PCSEA_ranged_effects

-- Copy Melee Sounds
--  "sfx_swing_heavy_left_hand", is shield and maul only
--  "sfx_swing_special", is pickaxe only
local swing_tables = { 
    "sfx_swing", "sfx_swing_heavy", 
    "melee_blocked_attack", 
    "melee_sweep_hit", "melee_heavy_sweep_hit", --"melee_sweep_hit_crit", -- crit goes events.["true"]???
    "sfx_push_follow_up", 
    "sfx_special_activate", -- Chainsword rev is NOT HERE LMAO
    "weapon_special_end", 
    --"equipped_item_passive", -- moved to looping events
    -- "melee_sticky_loop", -- sounds like something chain specific (even though force swords are here) and may crash because chain weapons are stupid???
}
local original_PCSEA_melee_effects = { }
for _, swing_effect_name in ipairs(swing_tables) do
    original_PCSEA_melee_effects[swing_effect_name] = {
        events = table_clone(PlayerCharacterSoundEventAliases[swing_effect_name].events)
    }
end
mod.original_PCSEA_melee_effects = original_PCSEA_melee_effects