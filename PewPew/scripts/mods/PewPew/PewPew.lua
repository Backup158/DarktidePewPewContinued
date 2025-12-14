--[[
Mod: PewPew
Description: Change ranged weapon sounds and projectile visual effects
Author: tinybike (GlaresAtKoalas on Nexus)
    2025-02-17: Date of adoption by Backup158
]]

local mod = get_mod("PewPew")
mod.version = "1.10.1"
local debug_mode_enabled

local ENEMY_LINE_EFFECTS = mod.ENEMY_LINE_EFFECTS
local table_contains_text = mod.table_contains_text

local tostring = tostring
local type = type
local pairs = pairs
local ipairs = ipairs
local table = table
local table_clone = table.clone
local table_insert = table.insert
local table_find_by_key = table.find_by_key
local table_contains = table.contains
local string = string
local string_find = string.find
local string_regex_sub = string.gsub

-- The required files for PlayerLineEffects and MinionLineEffects each contain a declaration of a line_effects table, then returns that table
local PlayerLineEffects = require("scripts/settings/effects/player_line_effects")
local MinionLineEffects = require("scripts/settings/effects/minion_line_effects")
local PlayerCharacterSoundEventAliases = require("scripts/settings/sound/player_character_sound_event_aliases")

-- Copy Line Effects
local original_player_line_effects = table_clone(PlayerLineEffects)
local original_minion_line_effects = table_clone(MinionLineEffects)
-- Copy Sound Effects
mod:io_dofile("PewPew/scripts/mods/PewPew/PewPew_weapon_tables")
mod:io_dofile("PewPew/scripts/mods/PewPew/PewPew_copied_data")
local original_PCSEA_ranged_effects = mod.original_PCSEA_ranged_effects
local swing_tables = mod.swing_tables
local original_PCSEA_melee_effects = mod.original_PCSEA_melee_effects

-- Widget Data
local line_effects_widgets = mod.line_effects_widgets
local sound_effects_widgets = mod.sound_effects_widgets
local single_shot_sound_effects_widgets = mod.single_shot_sound_effects_widgets
local special_shot_sound_effects_widgets = mod.special_shot_sound_effects_widgets
local melee_sound_effects_widgets = mod.melee_sound_effects_widgets

-- Copying 
mod:io_dofile("PewPew/scripts/mods/PewPew/PewPew_manual_sound_effect_digging")
local RANGED_SHOOTING_SOUND_EFFECTS = mod.RANGED_SHOOTING_SOUND_EFFECTS
local CHARGED_SINGLE_SHOT_SFX = mod.CHARGED_SINGLE_SHOT_SFX

-- #########################################
-- Load Resources
-- @backup158: checks if package is available to be loaded? legacy code i haven't really looked into
-- #########################################
local function load_resource(package_name, cb)
    if package_name ~= nil and Application.can_get_resource("package", package_name) then
        Managers.package:load(package_name, "PewPew", function () cb(package_name) end)
    else
        cb(nil)
    end
end

-- Compatilibity between given full value and manually added values
local function prepend_wwise_if_not_found(given_string)
    local final_string = given_string
    if not string_find(final_string, "wwise") then
        final_string = "wwise/events/weapon/play_"..final_string
    end

    return final_string
end

-- ####################################################################################
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
-- ####################################################################################
local function update_line_effects(line_effects_to_be_changed)
    -- Get name of new effect we want to replace the current one with
    local new_line_effects = mod:get(line_effects_to_be_changed)
    local new_line_string = tostring(new_line_effects)

    local changed_effect_is_minion = table_contains_text(ENEMY_LINE_EFFECTS, new_line_effects)
    -- Makes a local copy of the original effects for faster access
    local original_line_effects
    --  Not used as a destination (?) for assignment, so pass by reference is fine
    if changed_effect_is_minion then
        original_line_effects = original_minion_line_effects
        if debug_mode_enabled then mod:notify(new_line_string.." is a fuck!") end
    else
        original_line_effects = original_player_line_effects
        if debug_mode_enabled then mod:notify(new_line_string.." is player") end
    end

    -- ----------------
    -- Using an empty trail
    -- ----------------
    --[[
    local function table_remove_vfx_width()
        PlayerLineEffects[line_effects_to_be_changed].vfx_width = 0.001
    end
    ]]
    if new_line_string == "empty_line_effect" then
        if debug_mode_enabled then mod:echo(new_line_string.." is empty (keep orig)") end
        
        PlayerLineEffects[line_effects_to_be_changed].vfx_width = 0.001
        return
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
            if debug_mode_enabled then mod:echo(new_line_string.." is player") end
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
        PlayerLineEffects[line_effects_to_be_changed].moving_sfx = table_clone(original_line_effects[new_line_effects].moving_sfx)
    else
        PlayerLineEffects[line_effects_to_be_changed].moving_sfx = nil
    end
    --  Handles emitters table
    if type(original_line_effects[new_line_effects].emitters) == "table" then
        load_resource(original_line_effects[new_line_effects].emitters.vfx.default, function (loaded_package_name)
            load_resource(original_line_effects[new_line_effects].emitters.vfx.start, function (loaded_package_name)
                PlayerLineEffects[line_effects_to_be_changed].emitters = table_clone(original_line_effects[new_line_effects].emitters)
            end)
        end)
    else
        PlayerLineEffects[line_effects_to_be_changed].emitters = nil
    end
    --  Handles emitters_crit table
    if type(original_line_effects[new_line_effects].emitters_crit) == "table" then
        load_resource(original_line_effects[new_line_effects].emitters_crit.vfx.default, function (loaded_package_name)
            load_resource(original_line_effects[new_line_effects].emitters_crit.vfx.start, function (loaded_package_name)
                PlayerLineEffects[line_effects_to_be_changed].emitters_crit = table_clone(original_line_effects[new_line_effects].emitters_crit)
            end)
        end)
    else
        PlayerLineEffects[line_effects_to_be_changed].emitters_crit = nil
    end
    
end

-- ####################################################################################
-- Sound effects
-- ####################################################################################
-- ##########################################
-- Ranged
-- ##########################################
-- #####################
-- Automatic
-- #####################
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

-- #####################
-- Single
-- #####################
local function update_single_shot_sound_effects(weapon_to_be_changed)
    local new_ranged_shooting_sfx = mod:get(weapon_to_be_changed)
    local play_ranged_single_shot = "wwise/events/weapon/play_" .. new_ranged_shooting_sfx

    if type(PlayerCharacterSoundEventAliases.ranged_single_shot.events[weapon_to_be_changed]) == "table" then
        if play_ranged_single_shot ~= PlayerCharacterSoundEventAliases.ranged_single_shot.events[weapon_to_be_changed].default then
            if CHARGED_SINGLE_SHOT_SFX[new_ranged_shooting_sfx] ~= nil then
                local play_ranged_single_shot_fully_charged = prepend_wwise_if_not_found(CHARGED_SINGLE_SHOT_SFX[new_ranged_shooting_sfx])

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

-- #####################
-- Special
-- These ARE in the PCEA events table!
-- #####################
local function update_special_shot_sound_effects(weapon_to_be_changed)
    local new_weapon_sounds = prepend_wwise_if_not_found(mod:get(weapon_to_be_changed))
    local actual_weapon_name = string_regex_sub(weapon_to_be_changed, "SPECIAL_SHOT_", "")

    --load_resource(new_weapon_sounds, function (loaded_package_name)
        PlayerCharacterSoundEventAliases.ranged_single_shot_special_extra.events[actual_weapon_name] = new_weapon_sounds
    --end)


    --[[
    if original_PCSEA_ranged_effects.ranged_single_shot_special_extra.events[new_weapon_sounds] then
        PlayerCharacterSoundEventAliases.ranged_single_shot_special_extra.events[weapon_to_be_changed] = original_PCSEA_ranged_effects.ranged_single_shot_special_extra
    else
        if debug_mode_enabled then mod:echo("Sound effect for "..new_weapon_sounds.." is fucked when adding to "..weapon_to_be_changed) end
    end
    ]]
end

-- ##########################################
-- Melee
-- These ARE in the PCEA events table!
-- https://github.com/Aussiemon/Darktide-Source-Code/blob/master/scripts/settings/sound/player_character_sound_event_aliases.lua#L2233
-- ##########################################
local function update_melee_sound_effects(weapon_to_be_changed)
    local new_weapon_sounds = mod:get(weapon_to_be_changed)

    -- table defined above for the types of swing types. regular, heavy, etc.
    for _, table_name in ipairs(swing_tables) do
        if original_PCSEA_melee_effects[table_name].events[new_weapon_sounds] then
            PlayerCharacterSoundEventAliases[table_name].events[weapon_to_be_changed] = original_PCSEA_melee_effects[table_name].events[new_weapon_sounds]
        else
            if debug_mode_enabled then mod:echo("Sound effect for "..new_weapon_sounds.." is fucked when adding to "..weapon_to_be_changed) end
        end
    end
end

-- ####################################################################################
-- Applying Mod Logic when the game runs
-- ####################################################################################
mod.on_all_mods_loaded = function (setting_id)
    debug_mode_enabled = mod:get("enable_debug_mode")
    mod:info('PewPewPew v' .. mod.version .. ' loaded uwu nya :3')
    
    for _, line_effects_widget in ipairs(line_effects_widgets) do
        update_line_effects(line_effects_widget.setting_id)
    end
    for _, sound_effects_widget in ipairs(sound_effects_widgets) do
        update_ranged_automatic_sound_effects(sound_effects_widget.setting_id)
    end
    for _, single_shot_sound_effects_widget in ipairs(single_shot_sound_effects_widgets) do
        update_single_shot_sound_effects(single_shot_sound_effects_widget.setting_id)
    end
    for _, special_shot_sound_effects_widget in ipairs(special_shot_sound_effects_widgets) do
        update_special_shot_sound_effects(special_shot_sound_effects_widget.setting_id)
    end
    for _, melee_sound_effects_widget in ipairs(melee_sound_effects_widgets) do
        update_melee_sound_effects(melee_sound_effects_widget.setting_id)
    end
end


mod.on_setting_changed = function (setting_id)
    debug_mode_enabled = mod:get("enable_debug_mode")

    if table_find_by_key(line_effects_widgets, "setting_id", setting_id) ~= nil then
        update_line_effects(setting_id)
    elseif table_find_by_key(sound_effects_widgets, "setting_id", setting_id) ~= nil then
        update_ranged_automatic_sound_effects(setting_id)
    elseif table_find_by_key(single_shot_sound_effects_widgets, "setting_id", setting_id) ~= nil then
        update_single_shot_sound_effects(setting_id)
    elseif table_find_by_key(special_shot_sound_effects_widgets, "setting_id", setting_id) ~= nil then
        update_special_shot_sound_effects(setting_id)
    elseif table_find_by_key(melee_sound_effects_widgets, "setting_id", setting_id) ~= nil then
        update_melee_sound_effects(setting_id)
    end
end