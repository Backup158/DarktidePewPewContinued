--[[
Mod: PewPew
Description: Change ranged weapon sounds and projectile visual effects
Author: tinybike (GlaresAtKoalas on Nexus)
    2025-02-17: Date of adoption by Backup158
]]

local mod = get_mod("PewPew")
local _weapon_tables_file = mod:io_dofile("PewPew/scripts/mods/PewPew/PewPew_weapon_tables")
mod.version = "1.7.0"

-- The required files for PlayerLineEffects and MinionLineEffects each contain a declaration of a line_effects table, then returns that table
local PlayerLineEffects = require("scripts/settings/effects/player_line_effects")
local MinionLineEffects = require("scripts/settings/effects/minion_line_effects")
local PlayerCharacterSoundEventAliases = require("scripts/settings/sound/player_character_sound_event_aliases")

local original_player_line_effects = table.clone(PlayerLineEffects)
local original_minion_line_effects = table.clone(MinionLineEffects)
-- "sfx_swing_heavy_left_hand", is shield and maul only
-- "sfx_swing_special", is pickaxe only
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
        events = table.clone(PlayerCharacterSoundEventAliases[swing_effect_name].events)
    }
end


-- Checks if value exists in table
function table_contains(table, x)
    found = false
    for _, v in pairs(table) do
        if v.text == x then 
            found = true 
        end
    end
    return found
end

-- ##################################################################################
-- Finding Effect Names
--  weapon_id = "wwise/events/weapon/play_<STRING_TO_STEAL>",
--      autogun_p1_m1 = "wwise/events/weapon/play_autogun_p1_m1_first",
--  effect name:    table in PlayerCharacterSoundEventAliases where the string is taken from
--  braced:         ranged_braced_shooting
--  pre_loop_shot:  ranged_pre_loop_shot
--      note: default = "wwise/events/weapon/play_weapon_silence",
--  single_shot:    ranged_single_shot (if automatic. otherwise...)
--      The way update_single_shot_sound_effects operates, this is automatically added from PewPew_data.lua
--      the id in the code is bolter_p1_m1 but weapon id doesn't matter here, only the sound id
--          The weapon_id chosen here is to identify the sounds for the options
-- ##################################################################################
local RANGED_SHOOTING_SOUND_EFFECTS = {
    -- Default (Silence)
    weapon_silence =            { braced="weapon_silence", pre_loop_shot="weapon_silence", single_shot=nil },
    -- Autoguns
    --  Yes, one of them says single instead of first. Blame Fatshark
    --  Infantry
    autogun_p1_m1_auto =        { braced="autogun_p1_m1_auto", pre_loop_shot="autogun_p1_m1_first", single_shot=nil },
    autogun_p1_m2_auto =        { braced="autogun_p1_m2_auto", pre_loop_shot="autogun_p1_m2_single", single_shot=nil },
    autogun_p1_m3_auto =        { braced="autogun_p1_m3_auto", pre_loop_shot="autogun_p1_m3_first", single_shot=nil },
    --  Braced
    autogun_p2_m1_auto =        { braced="autogun_p2_m1_auto", pre_loop_shot="autogun_p2_m1_first", single_shot=nil },
    autogun_p2_m2_auto =        { braced="autogun_p2_m2_auto", pre_loop_shot="autogun_p2_m2_first", single_shot=nil },
    autogun_p2_m3_auto =        { braced="autogun_p2_m3_auto", pre_loop_shot="autogun_p2_m3_first", single_shot=nil },
    -- Shredder Autopistol
    weapon_autopistol_auto =    { braced="weapon_autopistol_auto", pre_loop_shot="weapon_autopistol", single_shot="weapon_autopistol" }, -- equivalent to autopistol_p1_m1
    -- Bolter
    --      See single_shot note
    -- Boltpistol
    --      See single_shot note
    -- Infantry Lasgun
    --      See single_shot note
    -- Helbore Lasgun
    lasgun_p2_charge =          { braced="lasgun_p2_charge", pre_loop_shot="weapon_silence", single_shot=nil }, -- equivalent to lasgun_p2_m1_charge
    -- Bolter
    lasgun_p2_m2_charge =       { braced="lasgun_p2_m2_charge", pre_loop_shot="weapon_silence", single_shot=nil },
    lasgun_p2_m3_charge =       { braced="lasgun_p2_m3_charge", pre_loop_shot="weapon_silence", single_shot=nil },
    -- Recon Lasgun
    lasgun_p3_m1_fire_auto =    { braced="lasgun_p3_m1_fire_auto", pre_loop_shot="lasgun_p3_m1_fire_single", single_shot=nil },
    lasgun_p3_m2_fire_auto =    { braced="lasgun_p3_m2_fire_auto", pre_loop_shot="lasgun_p3_m2_fire_single", single_shot=nil },
    lasgun_p3_m3_fire_auto =    { braced="lasgun_p3_m3_fire_auto", pre_loop_shot="lasgun_p3_m3_fire_single", single_shot=nil },
    -- Laspistol
    --      See single_shot note
    -- Grenade Gauntlet
    --      See single_shot note
    -- Heavy Stubber
    --  Twin-Linked
    heavy_stubber_auto =        { braced="heavy_stubber_auto", pre_loop_shot="heavy_stubber_punch_first", single_shot=nil }, -- equivalent to heavy_stubber_p1_m1_auto
    heavy_stubber_p1_m2_auto =  { braced="heavy_stubber_p1_m2_auto", pre_loop_shot="heavy_stubber_p1_m2_punch_first", single_shot=nil },
    heavy_stubber_p1_m3_auto =  { braced="heavy_stubber_p1_m3_auto", pre_loop_shot="heavy_stubber_p1_m3_punch_first", single_shot=nil },
    --  Single
    --      See single_shot note
    -- Rippergun
    --      See single_shot note
    -- Thumper
    --      Rumbler and Kickback
    --      See single_shot note
    -- Shotgun
    --      Combat, Double-Barreled, and Exterminator
    --      See single_shot note
    -- Psyker Warp stuff
    forcestaff_warp_fire =      { braced="forcestaff_warp_fire", pre_loop_shot="weapon_silence", single_shot="psyker_smite_fire" },
    forcestaff_warp_fire_charge_loop = { braced="forcestaff_warp_fire_charge_loop", pre_loop_shot="weapon_silence", single_shot=nil },
    forcestaff_p4_charge_loop = { braced="forcestaff_p4_charge_loop", pre_loop_shot="weapon_silence", single_shot=nil },
    -- Psyker Blitz
    --  Smite
    psyker_chain_lightning =    { braced="psyker_chain_lightning_heavy", pre_loop_shot="weapon_silence", single_shot=nil },
    psyker_chain_lightning_charge = { braced="psyker_chain_lightning_charge", pre_loop_shot="weapon_silence", single_shot=nil },
    --  Brain Burst/Rupture
    psyker_smite_charge =       { braced="psyker_smite_charge", pre_loop_shot="weapon_silence", single_shot=nil },
    psyker_headpop_hands =      { braced="psyker_headpop_hands", pre_loop_shot="weapon_silence", single_shot=nil },
    -- Flamer
    flamethrower_fire_loop =    { braced=nil, pre_loop_shot="weapon_silence", single_shot=nil },
    -- Plasmagun
    plasmagun_charge =          { braced="plasmagun_charge", pre_loop_shot="weapon_silence", single_shot=nil },
    weapon_plasmagun_charge_fast = { braced="weapon_plasmagun_charge_fast", pre_loop_shot="weapon_silence", single_shot=nil },
    weapon_plasma_mech_vent =   { braced="weapon_plasma_mech_vent", pre_loop_shot="weapon_silence", single_shot=nil },
    -- Weapon Special Power Sounds
    --  Thunderhammer
    thunder_hammer_powered_loop = { braced="thunder_hammer_powered_loop", pre_loop_shot="weapon_silence", single_shot=nil },
    --  Force Sword
    force_sword_loop =          { braced="force_sword_loop", pre_loop_shot="weapon_silence", single_shot=nil },
    force_sword_2h_loop =          { braced="force_2h_sword_loop", pre_loop_shot="weapon_silence", single_shot=nil },
    --  Power Sword (1h Vet, 2h Zealot uses the same sound)
    power_sword_loop =          { braced="power_sword_loop", pre_loop_shot="weapon_silence", single_shot=nil },
    --  Power Maul (1h Ogryn, 2h Zealot uses the same sound)
    ogryn_power_maul_1h_loop =  { braced="ogryn_power_maul_1h_loop", pre_loop_shot="weapon_silence", single_shot=nil },
}
-- fully_charged entries for weapons in ranged_single_shot table
local CHARGED_SINGLE_SHOT_SFX = {
    -- Helbore Lasgun
    lasgun_p2_m1 = "lasgun_p2_m1_charged",
    lasgun_p2_m2 = "lasgun_p2_m2_charged",
    lasgun_p2_m3 = "lasgun_p2_m3_charged",
    -- Plasmagun
    plasmagun_p1_m1 = "weapon_plasmagun_charged",
    --plasmagun_p1_m2 = "weapon_plasmagun_charged", -- Unreleased
}

-- #########################################
-- Load Resources
-- checks if package is available to be loaded? legacy code i haven't really looked into
-- #########################################
local function load_resource(package_name, cb)
    if package_name ~= nil and Application.can_get_resource("package", package_name) then
        Managers.package:load(package_name, "PewPew", function () cb(package_name) end)
    else
        cb(nil)
    end
end

-- ##################################################################################
-- Projectile visual effects
--	See @scripts/settings/effects/player_line_effects.lua
--  These are called from @scripts/settings/equipment/weapon_templates/<family>/<weapon>.lua
--      in 'weapon_template.actions' table
--          in 'action_shoot_hip' and 'action_shoot' tables
--              there is 'fx' table
--              this 'fx' table assigns the line effect
--              This is different for shotguns, because they don't have line effects assigned
--              They only use generic ranged shooting trails, which are normally added on top of the weapon's line effect
--      These tables also contain values such as ammo used per shot, handling timings, etc
--      Which likely means these are immutable by mods
-- ##################################################################################
local function update_line_effects(line_effects_to_be_changed)
    -- Get name of new effect we want to replace the current one with
    local new_line_effects = mod:get(line_effects_to_be_changed)

    local changed_effect_is_minion = table_contains(mod.ENEMY_LINE_EFFECTS, new_line_effects)
    -- Makes a local copy of the original effects for faster access
    local original_line_effects
    --  Not used as a destination (?) for assignment, so pass by reference is fine
    if changed_effect_is_minion then
        original_line_effects = original_minion_line_effects
        if mod.debug then mod:notify(tostring(new_line_effects).." is a fuck!") end
    else
        original_line_effects = original_player_line_effects
        if mod.debug then mod:notify(tostring(new_line_effects).." is player") end
    end
    
    -- Assigning the new values
    --  Values are taken from the local copy of the original line effects
    --  If there is no new value, use the value from the default line effect
    --      This is because enemy line effects don't have things such as width
    --      If width is nil, the effect doesn't show up
    if original_line_effects[new_line_effects].vfx_width then
        --  Making an exception for scab sniper width, because that shit is literally 50 times bigger than the normal width lmfao
        --  Instead, it will use the original width at the default value
        if new_line_effects == "renegade_sniper_lasbeam" then
            if mod.debug then mod:echo(tostring(new_line_effects).." is player") end
            PlayerLineEffects[line_effects_to_be_changed].vfx_width = original_player_line_effects[line_effects_to_be_changed].vfx_width
            -- PlayerLineEffects[line_effects_to_be_changed].vfx_width = nil -- Intentionally making it blank
        else
            PlayerLineEffects[line_effects_to_be_changed].vfx_width = original_line_effects[new_line_effects].vfx_width
        end
    end
    PlayerLineEffects[line_effects_to_be_changed].keep_aligned = original_line_effects[new_line_effects].keep_aligned
    PlayerLineEffects[line_effects_to_be_changed].link = original_line_effects[new_line_effects].link
    
    -- putting this here so it can be destroyed afterwards
    -- this means it'll get created every single time you change a setting, but that should happen infrequently enough so the memory usage isn't so much. otherwise i'd have to just keep this table up the entire time the game is running lol
    local sound_event_keys = { "vfx", "sfx", "vfx_crit", }
    for _, effect_key in ipairs(sound_event_keys) do
        if original_line_effects[new_line_effects][effect_key] then
            load_resource(original_line_effects[new_line_effects][effect_key], function (loaded_package_name)
                PlayerLineEffects[line_effects_to_be_changed][effect_key] = loaded_package_name
            end)
        else 
            PlayerLineEffects[line_effects_to_be_changed][effect_key] = original_player_line_effects[line_effects_to_be_changed][effect_key]
        end
    end

    -- Some of these tables may not exist
    --  Handles moving vfx table
    if type(original_line_effects[new_line_effects].moving_sfx) == "table" then
        PlayerLineEffects[line_effects_to_be_changed].moving_sfx = table.clone(original_line_effects[new_line_effects].moving_sfx)
    else
        PlayerLineEffects[line_effects_to_be_changed].moving_sfx = nil
    end
    --  Handles emitters table
    if type(original_line_effects[new_line_effects].emitters) == "table" then
        load_resource(original_line_effects[new_line_effects].emitters.vfx.default, function (loaded_package_name)
            load_resource(original_line_effects[new_line_effects].emitters.vfx.start, function (loaded_package_name)
                PlayerLineEffects[line_effects_to_be_changed].emitters = table.clone(original_line_effects[new_line_effects].emitters)
            end)
        end)
    else
        PlayerLineEffects[line_effects_to_be_changed].emitters = nil
    end
    --  Handles emitters_crit table
    if type(original_line_effects[new_line_effects].emitters_crit) == "table" then
        load_resource(original_line_effects[new_line_effects].emitters_crit.vfx.default, function (loaded_package_name)
            load_resource(original_line_effects[new_line_effects].emitters_crit.vfx.start, function (loaded_package_name)
                PlayerLineEffects[line_effects_to_be_changed].emitters_crit = table.clone(original_line_effects[new_line_effects].emitters_crit)
            end)
        end)
    else
        PlayerLineEffects[line_effects_to_be_changed].emitters_crit = nil
    end
    
end

-- ##################################################################################
-- Sound effects
-- ##################################################################################
-- #########################################
-- Ranged
-- #########################################
local function update_ranged_automatic_sound_effects(weapon_to_be_changed)
    local new_ranged_shooting_sfx = mod:get(weapon_to_be_changed)
    local play_new_ranged_shooting_auto = "wwise/events/weapon/play_" .. new_ranged_shooting_sfx
    local stop_new_ranged_shooting_auto = "wwise/events/weapon/stop_" .. new_ranged_shooting_sfx
    local play_new_ranged_braced_shooting_auto = nil
    local stop_new_ranged_braced_shooting_auto = nil
    if RANGED_SHOOTING_SOUND_EFFECTS[new_ranged_shooting_sfx].braced ~= nil then
        play_new_ranged_braced_shooting_auto = "wwise/events/weapon/play_" .. RANGED_SHOOTING_SOUND_EFFECTS[new_ranged_shooting_sfx].braced
        stop_new_ranged_braced_shooting_auto = "wwise/events/weapon/stop_" .. RANGED_SHOOTING_SOUND_EFFECTS[new_ranged_shooting_sfx].braced
    end
    local play_new_ranged_pre_loop_shot = "wwise/events/weapon/play_" .. RANGED_SHOOTING_SOUND_EFFECTS[new_ranged_shooting_sfx].pre_loop_shot
    if play_new_ranged_shooting_auto ~= PlayerCharacterSoundEventAliases.play_ranged_shooting.events[weapon_to_be_changed] then
        load_resource(play_new_ranged_shooting_auto, function (loaded_package_name)
            PlayerCharacterSoundEventAliases.play_ranged_shooting.events[weapon_to_be_changed] = loaded_package_name
        end)
        load_resource(stop_new_ranged_shooting_auto, function (loaded_package_name)
            PlayerCharacterSoundEventAliases.stop_ranged_shooting.events[weapon_to_be_changed] = loaded_package_name
        end)
        load_resource(play_new_ranged_braced_shooting_auto, function (loaded_package_name)
            PlayerCharacterSoundEventAliases.play_ranged_braced_shooting.events[weapon_to_be_changed] = loaded_package_name
        end)
        load_resource(stop_new_ranged_braced_shooting_auto, function (loaded_package_name)
            PlayerCharacterSoundEventAliases.stop_ranged_braced_shooting.events[weapon_to_be_changed] = loaded_package_name
        end)
        load_resource(play_new_ranged_pre_loop_shot, function (loaded_package_name)
            PlayerCharacterSoundEventAliases.ranged_pre_loop_shot.events[weapon_to_be_changed] = loaded_package_name
        end)
        if RANGED_SHOOTING_SOUND_EFFECTS[new_ranged_shooting_sfx].single_shot ~= nil then
            local play_ranged_single_shot = "wwise/events/weapon/play_" .. RANGED_SHOOTING_SOUND_EFFECTS[new_ranged_shooting_sfx].single_shot
            load_resource(play_ranged_single_shot, function (loaded_package_name)
                PlayerCharacterSoundEventAliases.ranged_single_shot.events[weapon_to_be_changed] = loaded_package_name
            end)
        end
    end
end

local function update_single_shot_sound_effects(weapon_to_be_changed)
    local new_ranged_shooting_sfx = mod:get(weapon_to_be_changed)
    local play_ranged_single_shot = "wwise/events/weapon/play_" .. new_ranged_shooting_sfx
    if type(PlayerCharacterSoundEventAliases.ranged_single_shot.events[weapon_to_be_changed]) == "table" then
        if play_ranged_single_shot ~= PlayerCharacterSoundEventAliases.ranged_single_shot.events[weapon_to_be_changed].default then
            if CHARGED_SINGLE_SHOT_SFX[new_ranged_shooting_sfx] ~= nil then
                local play_ranged_single_shot_fully_charged = "wwise/events/weapon/play_" .. CHARGED_SINGLE_SHOT_SFX[new_ranged_shooting_sfx]
                load_resource(play_ranged_single_shot, function (loaded_package_name)
                    PlayerCharacterSoundEventAliases.ranged_single_shot.events[weapon_to_be_changed].default = loaded_package_name
                end)
                load_resource(play_ranged_single_shot_fully_charged, function (loaded_package_name)
                    PlayerCharacterSoundEventAliases.ranged_single_shot.events[weapon_to_be_changed].fully_charged = loaded_package_name
                end)
            else
                load_resource(play_ranged_single_shot, function (loaded_package_name)
                    PlayerCharacterSoundEventAliases.ranged_single_shot.events[weapon_to_be_changed].default = loaded_package_name
                    PlayerCharacterSoundEventAliases.ranged_single_shot.events[weapon_to_be_changed].fully_charged = loaded_package_name
                end)
            end
        end
    else
        if play_ranged_single_shot ~= PlayerCharacterSoundEventAliases.ranged_single_shot.events[weapon_to_be_changed] then
            load_resource(play_ranged_single_shot, function (loaded_package_name)
                PlayerCharacterSoundEventAliases.ranged_single_shot.events[weapon_to_be_changed] = loaded_package_name
                -- arbitarary wwise event of non required file: crash. <<Script Error>>scripts/network_lookup/network_lookup.lua:475: [NetworkLookup] Table player_character_sounds does not contain key: wwise/events/minions/play_loc_captain_twin_male_a__mission_twins_arrival_04_a_01_ambisonics<</Script Error>>
                --PlayerCharacterSoundEventAliases.ranged_single_shot.events[weapon_to_be_changed] = "wwise/events/minions/play_loc_captain_twin_male_a__mission_twins_arrival_04_a_01_ambisonics"
                
                -- another wwise event in the player character sounds
                --  Voices have no sound unless played by the correct current voice (and when they do play, they are quiet)
                --PlayerCharacterSoundEventAliases.ranged_single_shot.events[weapon_to_be_changed] = PlayerCharacterSoundEventAliases.attack_long_vce.events.psyker_female_b
                
                -- wwise event in PCSEA: Success!
                --  BUT IT MAY EARRAPE YOU
                --PlayerCharacterSoundEventAliases.ranged_single_shot.events[weapon_to_be_changed] = PlayerCharacterSoundEventAliases.ability_shout.events.veteran_combat_ability
            end)
        end
    end
end
-- #########################################
-- Melee
-- These ARE in the PCEA events table!
-- https://github.com/Aussiemon/Darktide-Source-Code/blob/master/scripts/settings/sound/player_character_sound_event_aliases.lua#L2233
-- #########################################
local function update_melee_sound_effects(weapon_to_be_changed)
    local new_weapon_sounds = mod:get(weapon_to_be_changed)
    -- table defined above for the types of swing types. regular, heavy, etc.
    for _, table_name in ipairs(swing_tables) do
        if original_PCSEA_melee_effects[table_name].events[new_weapon_sounds] then
            PlayerCharacterSoundEventAliases[table_name].events[weapon_to_be_changed] = original_PCSEA_melee_effects[table_name].events[new_weapon_sounds]
        else
            if mod.debug then mod:echo("Sound effect for "..new_weapon_sounds.." is fucked when adding to "..weapon_to_be_changed) end
        end
    end
end

mod.on_all_mods_loaded = function (setting_id)
    mod.debug = mod:get("enable_debug_mode")
    mod:info('PewPewPew v' .. mod.version .. ' loaded uwu nya :3')
    
    for _, line_effects_widget in ipairs(mod.line_effects_widgets) do
        update_line_effects(line_effects_widget.setting_id)
    end
    for _, sound_effects_widget in ipairs(mod.sound_effects_widgets) do
        update_ranged_automatic_sound_effects(sound_effects_widget.setting_id)
    end
    for _, single_shot_sound_effects_widget in ipairs(mod.single_shot_sound_effects_widgets) do
        update_single_shot_sound_effects(single_shot_sound_effects_widget.setting_id)
    end
    for _, melee_sound_effects_widget in ipairs(mod.melee_sound_effects_widgets) do
        update_melee_sound_effects(melee_sound_effects_widget.setting_id)
    end
end


mod.on_setting_changed = function (setting_id)
    mod.debug = mod:get("enable_debug_mode")

    if table.find_by_key(mod.line_effects_widgets, "setting_id", setting_id) ~= nil then
        update_line_effects(setting_id)
    elseif table.find_by_key(mod.sound_effects_widgets, "setting_id", setting_id) ~= nil then
        update_ranged_automatic_sound_effects(setting_id)
    elseif table.find_by_key(mod.single_shot_sound_effects_widgets, "setting_id", setting_id) ~= nil then
        update_single_shot_sound_effects(setting_id)
    elseif table.find_by_key(mod.melee_sound_effects_widgets, "setting_id", setting_id) ~= nil then
        update_melee_sound_effects(setting_id)
    end
end