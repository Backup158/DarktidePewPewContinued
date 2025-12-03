local mod = get_mod("PewPew")
local _weapon_tables_file = mod:io_dofile("PewPew/scripts/mods/PewPew/PewPew_weapon_tables")

-- Requirements
local original_player_line_effects = require("scripts/settings/effects/player_line_effects")

-- Local References for Performance
local ENEMY_LINE_EFFECTS = mod.ENEMY_LINE_EFFECTS
local table_contains_text = mod.table_contains_text
local add_effect_from_original_if_not_found = mod.add_effect_from_original_if_not_found

local table = table
local table_clone = table.clone
local table_insert = table.insert
local table_contains = table.contains
local pairs = pairs
local ipairs = ipairs

-- ############################################
-- Defining Effects
-- ############################################
-- ######################
-- Line Effects
-- Shot trails (not impacts!)
-- ######################
local LINE_EFFECTS_OPTIONS = {
	{ text="empty_line_effect" }, -- "Empty" but keeps original impacts

	-- See @scripts/settings/effects/player_line_effects.lua
	{ text="lasbeam" }, -- Bot Zola Laspistol
	{ text="lasbeam_pistol" }, -- laspistol_p1_m1 
	{ text="lasbeam_pistol_ads" }, -- laspistol_p1_m1 ADS
	{ text="lasbeam_heavy_pistol" }, -- laspistol_p1_m3. see 'scripts/settings/equipment/weapon_templates/laspistols/laspistol_p1_m3.lua'
	{ text="lasbeam_killshot" }, -- lasgun_p1 and lasgun_p2 uncharged (Infantry and Helbore)
	{ text="lasbeam_elysian" }, -- lasgun_p3 (Recon)
	{ text="lasbeam_charged" }, -- lasgun_p2 partial charge (Helbore)
	{ text="lasbeam_bfg" }, -- lasgun_p2 full charge (Helbore)
	{ text="autogun_bullet" },
	{ text="heavy_stubpistol_bullet" }, -- It's identical to the autogun bullet
	{ text="heavy_stubber_bullet" },
	{ text="pellet_trail" },
	{ text="pellet_trail_shock" },
	{ text="shotgun_slug_trail" },
	{ text="shotgun_incendiary_trail" },
	{ text="ripper_trail" },
	{ text="boltshell" },
	{ text="plasma_beam" },
}

-- for dev use to see what's new
add_effect_from_original_if_not_found(original_player_line_effects, LINE_EFFECTS_OPTIONS, { })

--	See @scripts/settings/effects/minion_line_effects.lua
-- Adding enemy line effects to overall line effects table
for _, v in ipairs(ENEMY_LINE_EFFECTS) do
	table_insert(LINE_EFFECTS_OPTIONS, v)
end
-- Essentially doing value = text = "string" to use the same name for id and localization id
for i, option in ipairs(LINE_EFFECTS_OPTIONS) do
	LINE_EFFECTS_OPTIONS[i].value = LINE_EFFECTS_OPTIONS[i].text
end

-- ######################
-- Looping Ranged SFX
-- All of the options that aren't just name_pattern_mark are because of how the automatic sound grabber function works
--	update_sound_effects and update_single_shot_sound_effects
--	Given the sound effect option name, it calls the sound event with the same name after "wwise/events/weapon/play_"
--	You might assume every weapon's sounds would use the same name format as the formatting used for the weapons themselves
-- 	Haha, no. Some weapons have the first mark as just weapon_<name>, such as the twin linked heavy stubber
--		'heavy_stubber_auto' instead of 'heavy_stubber_p1_m1_auto'
--	So to streamline finding the sounds, these variable names match Fatshark's internal naming scheme for weapon sound effects
-- ######################
local LOOPING_AUTOMATIC_SOUND_EFFECTS_OPTIONS = {
	{ text="weapon_silence" },
	{ text="weapon_autopistol_auto" },
	{ text="autogun_p1_m1_auto" },
	{ text="autogun_p1_m2_auto" },
	{ text="autogun_p1_m3_auto" },
	{ text="autogun_p2_m1_auto" },
	{ text="autogun_p2_m2_auto" },
	{ text="autogun_p2_m3_auto" },
	{ text="flamethrower_fire_loop" },
	{ text="forcestaff_warp_fire" },
	{ text="lasgun_p3_m1_fire_auto" },
	{ text="lasgun_p3_m2_fire_auto" },
	{ text="lasgun_p3_m3_fire_auto" },
	{ text="heavy_stubber_auto" },
	{ text="heavy_stubber_p1_m2_auto" },
	{ text="heavy_stubber_p1_m3_auto" },
	{ text="psyker_chain_lightning" },
	--charging fx
	{ text="psyker_chain_lightning_charge" },
	{ text="plasmagun_charge" },
	{ text="psyker_headpop_hands" },
	{ text="forcestaff_warp_fire_charge_loop" },
	{ text="lasgun_p2_charge" },
	{ text="lasgun_p2_m2_charge" },
	{ text="lasgun_p2_m3_charge" },
	{ text="forcestaff_p4_charge_loop" },
	{ text="weapon_plasmagun_charge_fast" },
	--psyker smite
	{ text="psyker_smite_charge" },
	--plasma vent
	{ text="weapon_plasma_mech_vent" },
	--weapon special loop
	{ text="thunder_hammer_powered_loop" },
	{ text="force_sword_loop" },
	{ text="force_sword_2h_loop" },
	{ text="power_sword_loop" },
	{ text="ogryn_power_maul_1h_loop" },
}
for i, option in ipairs(LOOPING_AUTOMATIC_SOUND_EFFECTS_OPTIONS) do
	LOOPING_AUTOMATIC_SOUND_EFFECTS_OPTIONS[i].value = LOOPING_AUTOMATIC_SOUND_EFFECTS_OPTIONS[i].text
end

-- ######################
-- Single Shot Sounds
--	See ranged loop sfx note for weird naming reasons
-- ######################
local SINGLE_SHOT_SOUND_EFFECTS_OPTIONS = {
	{ text="weapon_silence" }, -- "wwise/events/weapon/play_weapon_silence" is the default silent sound
	{ text="weapon_autopistol" }, -- autopistol_p1_m1
	{ text="weapon_dual_autopistols"}, -- dual_autopistols_p1_m1
	{ text="dual_stubpistols_p1_m1_single"},
	{ text="autogun_p3_m1_single" },
	{ text="autogun_p3_m2_single" },
	{ text="autogun_p3_m3_single" },
	{ text="weapon_bolter" }, -- bolter_p1_m1
	{ text="weapon_bolter_m2" }, -- bolter_p1_m2
	{ text="bolt_pistol_p1_m1_single" }, -- boltpistol_p1_m1
	{ text="bolt_pistol_m2_single" }, -- boltpistol_p1_m2
	{ text="weapon_laspistol" },  -- laspistol_p1_m1
	-- { text="laspistol_p1_m2" }, -- Unreleased
	{ text="laspistol_p1_m3" },
	{ text="weapon_lasgun_p1_m1" },
	{ text="weapon_lasgun_p1_m2" },
	{ text="weapon_lasgun_p1_m3" },
	{ text="lasgun_p2_m1" },
	{ text="lasgun_p2_m2" },
	{ text="lasgun_p2_m3" },
	{ text="outlaw_missile_launcher_fire" }, -- missile_launcher, Hive Scum blitz
	{ text="weapon_needle_pistol" }, -- needlepistol_p1_m1-3
	{ text="psyker_smite_fire" },
	{ text="psyker_throw_knife" }, -- Assail
	{ text="combat_weapon_shotgun" }, -- shotgun_p1_m1
	{ text="shotgun_p1_m2" },
	{ text="shotgun_p1_m3" },
	{ text="shotgun_p2_m1" },
	{ text="shotgun_p4_m1" },
	--{ text="shotgun_p4_m2" }, -- Uses the same sound as shotgun_p4_m1 so there's no sound (so it becomes silent)
	--{ text="shotgun_p4_m3" },
	{ text="shotpistol_p1_m1" },
	{ text="stub_revolver" }, -- stubrevolver_p1_m1
	{ text="stub_revolver_p1_m2" },
	-- { text="stub_revolver_p1_m3" }, -- Unreleased
	-- { text="stubrifle_p1_m1" }, -- Unreleased
	{ text="ogryn_gauntlet_fire" },
	{ text="heavy_stubber_p2_m1_punch_first" },
	{ text="heavy_stubber_p2_m2_punch_first" },
	{ text="heavy_stubber_p2_m3_punch_first" },
	{ text="ogryn_thumper_p1_m1" },
	{ text="ogryn_thumper_p1_m2" },
	{ text="weapon_plasmagun" }, -- plasmagun_p1_m1
	{ text="weapon_rippergun" }, -- ogryn_rippergun_p1_m1
	{ text="zealot_throw_knife" }, -- Blades of Faith
}
-- Creating another key value pair for each entry, called value
for i, option in ipairs(SINGLE_SHOT_SOUND_EFFECTS_OPTIONS) do
	SINGLE_SHOT_SOUND_EFFECTS_OPTIONS[i].value = SINGLE_SHOT_SOUND_EFFECTS_OPTIONS[i].text
end

-- ############################################
-- Creating Widgets
-- ############################################

-- ######################
-- Line Effects Widgets
-- 	Bullet trails to change
-- ######################
mod.line_effects_widgets = {
	-- Player
	{ setting_id="lasbeam" }, -- Bot Zola Laspistol
	{ setting_id="lasbeam_pistol" }, -- laspistol_p1_m1 
	{ setting_id="lasbeam_pistol_ads" }, -- laspistol_p1_m1 ADS
	{ setting_id="lasbeam_heavy_pistol" }, -- laspistol_p1_m3. see 'scripts/settings/equipment/weapon_templates/laspistols/laspistol_p1_m3.lua'
	{ setting_id="lasbeam_killshot" }, -- lasgun_p1 and lasgun_p2 uncharged (Infantry and Helbore)
	{ setting_id="lasbeam_elysian" }, -- lasgun_p3 (Recon)
	{ setting_id="lasbeam_charged" }, -- lasgun_p2 partial charge (Helbore)
	{ setting_id="lasbeam_bfg" }, -- lasgun_p2 full charge (Helbore)
	{ setting_id="autogun_bullet" },
	{ setting_id="heavy_stubpistol_bullet" }, -- Identical to the autogun bullet
	{ setting_id="heavy_stubber_bullet" },
	{ setting_id="pellet_trail" },
	{ setting_id="pellet_trail_shock" },
	{ setting_id="shotgun_slug_trail" },
	{ setting_id="shotgun_incendiary_trail" },
	{ setting_id="ripper_trail" },
	{ setting_id="boltshell" },
	{ setting_id="plasma_beam" },
	-- Minion
	--{ setting_id="renegade_twin_captain_las_pistol_lasbeam" },
	--{ setting_id="renegade_lasbeam" },
	--{ setting_id="renegade_gunner_lasbeam" },
	--{ setting_id="renegade_sniper_lasbeam" },
	--{ setting_id="renegade_assault_lasbeam" },
	--{ setting_id="cultist_autogun_bullet" },
	--{ setting_id="renegade_heavy_stubber_bullet" },
	--{ setting_id="renegade_pellet" },
	--{ setting_id="renegade_captain_pellet" },
	--{ setting_id="renegade_captain_boltshell" },
	--{ setting_id="renegade_captain_plasma_beam" },
}
for i, line_effects_widget in ipairs(mod.line_effects_widgets) do
	mod.line_effects_widgets[i].type = "dropdown"
	mod.line_effects_widgets[i].default_value = line_effects_widget.setting_id
	mod.line_effects_widgets[i].options = table_clone(LINE_EFFECTS_OPTIONS)
end

-- ######################
-- Sound Effect Widget Options: Automatic and Single
--	setting_id:	Weapon's name in the code
--	default_value: the corresponding audio from LOOPING_AUTOMATIC_SOUND_EFFECTS_OPTIONS or SINGLE_SHOT_SOUND_EFFECTS_OPTIONS
-- ######################
-- -------------
-- Automatic
-- -------------
mod.sound_effects_widgets = {
	{ setting_id="autopistol_p1_m1", default_value="weapon_autopistol_auto" },
	-- { setting_id="autopistol_p1_m2", default_value="weapon_autopistol_auto" }, -- Unreleased
	-- { setting_id="autopistol_p1_m3", default_value="weapon_autopistol_auto" }, -- Unreleased
	{ setting_id="dual_autopistols_p1_m1", default_value="dual_autopistols_p1_m1_auto" },
	{ setting_id="autogun_p1_m1", default_value="autogun_p1_m1_auto" },
	{ setting_id="autogun_p1_m2", default_value="autogun_p1_m2_auto" },
	{ setting_id="autogun_p1_m3", default_value="autogun_p1_m3_auto" },
	{ setting_id="autogun_p2_m1", default_value="autogun_p2_m1_auto" },
	{ setting_id="autogun_p2_m2", default_value="autogun_p2_m2_auto" },	
	{ setting_id="autogun_p2_m3", default_value="autogun_p2_m3_auto" },
	{ setting_id="flamer_p1_m1", default_value="flamethrower_fire_loop" },
	{ setting_id="forcestaff_p2_m1", default_value="forcestaff_warp_fire" },
	-- { setting_id="forcestaff_p2_m2", default_value="forcestaff_warp_fire" }, -- Unreleased
	{ setting_id="forcestaff_p3_m1", default_value="psyker_chain_lightning" },
	{ setting_id="lasgun_p3_m1", default_value="lasgun_p3_m1_fire_auto" },
	{ setting_id="lasgun_p3_m2", default_value="lasgun_p3_m2_fire_auto" },
	{ setting_id="lasgun_p3_m3", default_value="lasgun_p3_m3_fire_auto" },
	{ setting_id="ogryn_heavystubber_p1_m1", default_value="heavy_stubber_auto" },
	{ setting_id="ogryn_heavystubber_p1_m2", default_value="heavy_stubber_p1_m2_auto" },
	{ setting_id="ogryn_heavystubber_p1_m3", default_value="heavy_stubber_p1_m3_auto" },
}
for i, sound_effects_widget in ipairs(mod.sound_effects_widgets) do
	mod.sound_effects_widgets[i].type = "dropdown"
	mod.sound_effects_widgets[i].options = table_clone(LOOPING_AUTOMATIC_SOUND_EFFECTS_OPTIONS)
end
-- -------------
-- Single
-- -------------
mod.single_shot_sound_effects_widgets = {
	{ setting_id="autogun_p3_m1", default_value="autogun_p3_m1_single" },
	{ setting_id="autogun_p3_m2", default_value="autogun_p3_m2_single" },
	{ setting_id="autogun_p3_m3", default_value="autogun_p3_m3_single" },
	{ setting_id="dual_stubpistols_p1_m1", default_value="dual_stubpistols_p1_m1_single" },
	{ setting_id="bolter_p1_m1", default_value="weapon_bolter" },
	{ setting_id="bolter_p1_m2", default_value="weapon_bolter_m2" },
	-- { setting_id="bolter_p1_m3", default_value="weapon_bolter" }, -- Unreleased
	{ setting_id="boltpistol_p1_m1", default_value="bolt_pistol_p1_m1_single" },
	{ setting_id="boltpistol_p1_m2", default_value="bolt_pistol_m2_single" },
	-- { setting_id="bot_zola_laspistol", default_value="weapon_laspistol" },
	-- { setting_id="bot_laspistol_killshot", default_value="weapon_laspistol" },
	-- { setting_id="bot_lasgun_killshot", default_value="weapon_lasgun_p1_m1" },
	-- { setting_id="bot_autogun_killshot", default_value="autogun_p3_m1_single" },
	{ setting_id="forcestaff_p1_m1", default_value="psyker_smite_fire" },
	{ setting_id="forcestaff_p4_m1", default_value="psyker_smite_fire" },
	-- { setting_id="high_bot_autogun_killshot", default_value="autogun_p3_m1_single" },
	-- { setting_id="high_bot_lasgun_killshot", default_value="weapon_lasgun_p1_m1" },
	{ setting_id="laspistol_p1_m1", default_value="weapon_laspistol" },
	-- { setting_id="laspistol_p1_m2", default_value="laspistol_p1_m2" }, -- Unreleased
	{ setting_id="laspistol_p1_m3", default_value="laspistol_p1_m3" },
	{ setting_id="lasgun_p1_m1", default_value="weapon_lasgun_p1_m1" },
	{ setting_id="lasgun_p1_m2", default_value="weapon_lasgun_p1_m2" },
	{ setting_id="lasgun_p1_m3", default_value="weapon_lasgun_p1_m3" },
	{ setting_id="lasgun_p2_m1", default_value="lasgun_p2_m1" },
	{ setting_id="lasgun_p2_m2", default_value="lasgun_p2_m2" },
	{ setting_id="lasgun_p2_m3", default_value="lasgun_p2_m3" },
	{ setting_id="missile_launcher", default_value="outlaw_missile_launcher_fire" },
	{ setting_id="needlepistol_p1_m1", default_value="weapon_needle_pistol" },
	{ setting_id="needlepistol_p1_m2", default_value="weapon_needle_pistol" },
	{ setting_id="needlepistol_p1_m3", default_value="weapon_needle_pistol" },
	{ setting_id="ogryn_gauntlet_p1_m1", default_value="ogryn_gauntlet_fire" },
	{ setting_id="ogryn_heavystubber_p2_m1", default_value="heavy_stubber_p2_m1_punch_first" },
	{ setting_id="ogryn_heavystubber_p2_m2", default_value="heavy_stubber_p2_m2_punch_first" },
	{ setting_id="ogryn_heavystubber_p2_m3", default_value="heavy_stubber_p2_m3_punch_first" },
	{ setting_id="ogryn_rippergun_p1_m1", default_value="weapon_rippergun" },
	{ setting_id="ogryn_rippergun_p1_m2", default_value="weapon_rippergun" },
	{ setting_id="ogryn_rippergun_p1_m3", default_value="weapon_rippergun" },
	{ setting_id="ogryn_thumper_p1_m1", default_value="ogryn_thumper_p1_m1" },
	{ setting_id="ogryn_thumper_p1_m2", default_value="ogryn_thumper_p1_m2" },
	-- { setting_id="ogryn_thumper_p1_m3", default_value="ogryn_thumper_p1_m3" }, -- Unreleased
	{ setting_id="plasmagun_p1_m1", default_value="weapon_plasmagun" },
	-- { setting_id="plasmagun_p1_m2", default_value="weapon_plasmagun" }, -- Unreleased
	-- { setting_id="psyker_smite", default_value="psyker_smite_fire" }, -- I don't think this changes anything
	{ setting_id="psyker_throwing_knives", default_value="psyker_throw_knife" },
	{ setting_id="shotgun_p1_m1", default_value="combat_weapon_shotgun" },
	{ setting_id="shotgun_p1_m2", default_value="shotgun_p1_m2" },
	{ setting_id="shotgun_p1_m3", default_value="shotgun_p1_m3" },
	{ setting_id="shotgun_p2_m1", default_value="shotgun_p2_m1" },
	{ setting_id="shotgun_p4_m1", default_value="shotgun_p4_m1" },
	{ setting_id="shotgun_p4_m2", default_value="shotgun_p4_m1" },
	--{ setting_id="shotgun_p4_m3", default_value="shotgun_p4_m1" },
	{ setting_id="shotpistol_shield_p1_m1", default_value="shotpistol_p1_m1" },
	{ setting_id="stubrevolver_p1_m1", default_value="stub_revolver" },
	{ setting_id="stubrevolver_p1_m2", default_value="stub_revolver_p1_m2" },
	-- { setting_id="stubrevolver_p1_m3", default_value="stub_revolver_p1_m3" }, -- Unreleased
	{ setting_id="zealot_throwing_knives", default_value="zealot_throw_knife" },
}
for i, single_shot_sound_effects_widgets in ipairs(mod.single_shot_sound_effects_widgets) do
	mod.single_shot_sound_effects_widgets[i].type = "dropdown"
	mod.single_shot_sound_effects_widgets[i].options = table_clone(SINGLE_SHOT_SOUND_EFFECTS_OPTIONS)
end
-- -------------
-- Melee
-- -------------
-- From the list of all melee weapons in PewPwe_weapon_tables.lua
for i, option in ipairs(mod.melee_sound_effects_names) do
	mod.melee_sound_effects_names[i].value = mod.melee_sound_effects_names[i].text
end
mod.melee_sound_effects_widgets = { }
for _, weapon_table in pairs(mod.melee_sound_effects_names) do
	mod.melee_sound_effects_widgets[#mod.melee_sound_effects_widgets + 1] = {
		setting_id = weapon_table.text,
		default_value = weapon_table.text,
		type = "dropdown",
		options = table_clone(mod.melee_sound_effects_names),
	}
end

return {
	name = mod:localize("mod_title"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	allow_rehooking = true,
	options = {
		widgets = {
			{ setting_id="enable_debug_mode", type="checkbox", default_value = false, },
			{ setting_id="line_effects_id", type="group", sub_widgets=mod.line_effects_widgets },
			{ setting_id="sound_effects_id", type="group", sub_widgets=mod.sound_effects_widgets },
			{ setting_id="single_shot_sound_effects_id", type="group", sub_widgets=mod.single_shot_sound_effects_widgets },
			{ setting_id="melee_swing_effects_id", type="group", sub_widgets=mod.melee_sound_effects_widgets },
		},
	},
}