-- Localizations: Universal
--	NOTE FOR FUTURE READERS: This is an absolute mess of copypasted code
--	However, there's so many exceptions to make the main functions work smoothly with Fatshark's naming scheme that automating localization is more effort than copypasting
--	This would require major refactors with not much benefit as far as I can tell
--	en=Localize("loc_weapon_pattern_<PLACEHOLDER>").." "..Localize("loc_weapon_mark_<PLACEHOLDER>").." "..Localize("loc_weapon_family_<PLACEHOLDER>")
--		and no, reassigning localizations for single shot doesn't work...
--		You'd have to assign that to a variable first, and there's still so many exceptions I'd just say fuck it
--	loc_weapon_px_mx brings up the old localizations from before Unlocked and Loaded
local mod = get_mod("PewPew")
-- List of weapons from game code
local WeaponTemplates = require("scripts/settings/equipment/weapon_templates/weapon_templates")
-- Disgusting hardcoded tables
local _weapon_tables_file = mod:io_dofile("PewPew/scripts/mods/PewPew/PewPew_weapon_tables")

-- Get localized version of weapon name
-- 	give it a string, the weapon code (e.g. autogun_p1_m1)
--	returns a string comprised of the pattern, mark, and, family, in that order (e.g. "Accatran Mk VIc Recon Lasgun")
local function get_full_weapon_name_localized(weapon_code) 
	local weapon_pattern = Localize("loc_weapon_pattern_"..weapon_code)
	local weapon_mark = Localize("loc_weapon_mark_"..weapon_code)
	local weapon_family = Localize("loc_weapon_family_"..weapon_code)
	return weapon_pattern.." "..weapon_mark.." "..weapon_family
end

local localizations = {
	mod_title = { en="PewPew" },
	mod_description = { en="Change ranged weapon sounds and projectile visual effects (Continued). PewPewPew!" },

	enable_debug_mode = { en = "Debug Mode", },
	enable_debug_mode_description = { en = "Enables verbose logging trail effect", },

	line_effects_id = { en="Visual Effects" },
	sound_effects_id = { en="Fully Automatic Fire SFX" },
	single_shot_sound_effects_id = { en="Single Shot SFX" },
	melee_swing_effects_id = { en="Melee Swing SFX" },

	-- ######################
	-- Projectile (line effect) labels
	-- ######################
	lasbeam = { en="Las Beam: Bot Zola Laspistol" },
	lasbeam_pistol = { en="Las Beam: Mk II Laspistol" },
	lasbeam_pistol_ads = { en="Las Beam: Mk II Laspistol ADS" },
	lasbeam_heavy_pistol = { en="Las Beam: Mk X Laspistol" },
	--lasbeam_killshot = { en="Lasbeam Killshot" },
	lasbeam_killshot = { en="Las Beam: Infantry, Helbore (Uncharged)" },
	--lasbeam_elysian = { en="Lasbeam Elysian" },
	lasbeam_elysian = { en="Las beam: Recon" },
	--lasbeam_charged = { en="Lasbeam Charged" },
	lasbeam_charged = { en="Las Beam: Helbore (Partially Charged)" },
	-- lasbeam_bfg = { en="Lasbeam BFG" },
	lasbeam_bfg = { en="Las Beam: Helbore (Fully Charged)" },
	-- heavy_stubpistol_bullet = { en="Stub Pistol Bullet" }, -- Unreleased
	autogun_bullet = { en="Autogun Bullet" },
	heavy_stubber_bullet = { en="Heavy Stubber Bullet" },
	pellet_trail = { en="Pellet Trail" },
	shotgun_slug_trail = { en="Shotgun Slug Trail" },
	shotgun_incendiary_trail = { en="Shotgun Incendiary Trail" },
	ripper_trail = { en="Ripper Trail" },
	boltshell = { en="Bolt Shell" },
	plasma_beam = { en="Plasma Beam" },
	renegade_twin_captain_las_pistol_lasbeam = { en="Scab Captain Laspistol Beam" },
	renegade_lasbeam = { en="Scab Shooter Las Beam" },
	renegade_gunner_lasbeam = { en="Scab Gunner Las Beam" },
	renegade_sniper_lasbeam = { en="Scab Sniper Las Beam" },
	renegade_assault_lasbeam = { en="Scab Stalker Las Beam" },
	cultist_autogun_bullet = { en="Dreg Autogun Bullet" },
	renegade_heavy_stubber_bullet = { en="Reaper Heavy Stubber Bullet" },
	renegade_pellet = { en="Scab Shotgunner Pellet/Slug" },
	renegade_captain_pellet = { en="Scab Captain Pellet Trail" },
	renegade_captain_boltshell = { en="Scab Captain Bolt Shell" },
	renegade_captain_plasma_beam = { en="Rodin Karnak Flaming Plasma Beam" },
	
	-- ######################
	-- Single-shot ranged weapon labels
	-- ######################
	-- bot_autogun_killshot = { en=Localize("loc_bot_autogun_killshot") },
	-- bot_lasgun_killshot = { en=Localize("loc_bot_lasgun_killshot") },
	-- bot_laspistol_killshot = { en=Localize("loc_bot_laspistol_killshot") },
	-- bot_zola_laspistol = { en=Localize("loc_bot_zola_laspistol") },
	-- psyker_smite = { en="Psyker \"Smite\"" },
	psyker_throwing_knives = { en="Psyker "..Localize("loc_ability_psyker_blitz_throwing_knives") },
	zealot_throwing_knives = { en="Zealot "..Localize("loc_ability_zealot_throwing_knifes") },

	-- ######################
	-- LOOPING RANGED SFX
	-- ######################
	weapon_autopistol_auto = { en=get_full_weapon_name_localized("autopistol_p1_m1") .. " Auto" },
	flamethrower_fire_loop = { en="Flamer Fire Loop" },
	forcestaff_warp_fire = { en="Force Staff Warp Fire" },
	heavy_stubber_auto = { en=get_full_weapon_name_localized("ogryn_heavystubber_p1_m1") .. " Auto" },
	heavy_stubber_p1_m2_auto =  { en=get_full_weapon_name_localized("ogryn_heavystubber_p1_m2") .. " Auto" },
    heavy_stubber_p1_m3_auto =  { en=get_full_weapon_name_localized("ogryn_heavystubber_p1_m3") .. " Auto" },
	psyker_chain_lightning = { en="Psyker Smite (Chain Lightning)" },
	-- ----------------
	-- Charging FX
	-- ----------------
	-- 	Helbore
	lasgun_p2_charge = { en=get_full_weapon_name_localized("lasgun_p2_m1") .. " Charge" }, -- It's the first mk, as seen in the code. ranged_charging table
	lasgun_p2_m2_charge = { en=get_full_weapon_name_localized("lasgun_p2_m2") .. " Charge" },
	lasgun_p2_m3_charge = { en=get_full_weapon_name_localized("lasgun_p2_m3") .. " Charge" },
	-- 	Psyker
	-- 		Smite
	psyker_chain_lightning_charge = { en="Psyker Smite (Chain Lightning) Charge" },
	--		Brain Burst/Rupture and staff primary
	psyker_smite_charge = { en="Psyker \"Smite\" Charge" },
	psyker_headpop_hands = { en="Psyker Brain Burst/Rupture Charge" },
	-- 		Staff
	forcestaff_warp_fire_charge_loop = { en="Force Staff Warp Fire Charge Loop" },
	--forcestaff_p4_charge_loop = { en="Forcestaff P4 Charge Loop" },
	forcestaff_p4_charge_loop = { en="Voidstrike Force Staff Charge Loop" },
	-- 	Plasma
	plasmagun_charge = { en="Plasmagun Charge" },
	weapon_plasmagun_charge_fast = { en="Plasmagun Charge Fast" },
	weapon_plasma_mech_vent = { en="Plasma Mech Vent" },
	--	Weapon Special Loop
	thunder_hammer_powered_loop = { en="Thunder Hammer Powered Loop" },
	force_sword_loop = { en="Force Sword Loop" },
	force_sword_2h_loop = { en="Force Greatsword Loop" },
	power_sword_loop = { en="Power Sword Loop" },
	ogryn_power_maul_1h_loop = { en="Ogryn Power Maul 1H Loop" },

	-- ######################
	-- SINGLE-SHOT RANGED SFX
	-- ######################
	weapon_autopistol = { en=get_full_weapon_name_localized("autopistol_p1_m1") },
	autogun_p3_m1_single = { en=get_full_weapon_name_localized("autogun_p3_m1") },
	autogun_p3_m2_single = { en=get_full_weapon_name_localized("autogun_p3_m2") },
	autogun_p3_m3_single = { en=get_full_weapon_name_localized("autogun_p3_m3") },
	weapon_bolter = { en=get_full_weapon_name_localized("bolter_p1_m1") },
	bolt_pistol_p1_m1_single = { en=get_full_weapon_name_localized("boltpistol_p1_m1") },
	weapon_lasgun_p1_m1 = { en=get_full_weapon_name_localized("lasgun_p1_m1") },
	weapon_lasgun_p1_m2 = { en=get_full_weapon_name_localized("lasgun_p1_m2") },
	weapon_lasgun_p1_m3 = { en=get_full_weapon_name_localized("lasgun_p1_m3") },
	weapon_laspistol = { en=get_full_weapon_name_localized("laspistol_p1_m1") },
	weapon_rippergun = { en=get_full_weapon_name_localized("ogryn_rippergun_p1_m1") },
	ogryn_gauntlet_fire = { en=get_full_weapon_name_localized("ogryn_gauntlet_p1_m1") },
	heavy_stubber_p2_m1_punch_first = { en=get_full_weapon_name_localized("ogryn_heavystubber_p2_m1") },
	heavy_stubber_p2_m2_punch_first = { en=get_full_weapon_name_localized("ogryn_heavystubber_p2_m2") },
	heavy_stubber_p2_m3_punch_first = { en=get_full_weapon_name_localized("ogryn_heavystubber_p2_m3") },
	combat_weapon_shotgun = { en=get_full_weapon_name_localized("shotgun_p1_m1") },
	--stub_revolver = { en=Localize("loc_stub_revolver") }, -- For some reason this shows up as 'Chambered'
	shotpistol_p1_m1 = { en=get_full_weapon_name_localized("shotpistol_shield_p1_m1") },
	stub_revolver = { en=get_full_weapon_name_localized("stubrevolver_p1_m1") },
	stub_revolver_p1_m2 = { en=get_full_weapon_name_localized("stubrevolver_p1_m2") },
	weapon_plasmagun = { en=get_full_weapon_name_localized("plasmagun_p1_m1") },
	psyker_smite_fire = { en="Psyker Force Staff Primary Fire" },
	-- The only localization lines related to these are the talent names, so you can get uwu flashbanged
	psyker_throw_knife = { en="Psyker "..Localize("loc_ability_psyker_blitz_throwing_knives") },
	zealot_throw_knife = { en="Zealot "..Localize("loc_ability_zealot_throwing_knifes") },
}

-- ######################
-- Weapon Labels
-- 	Localizations for the names of the weapons you will be changing the sound of
--	This also covers some of the names for the single shot sounds
-- ######################
-- -------------
-- Ranged
-- -------------
-- Automatics
for weapon_code, _ in pairs(WeaponTemplates) do
	localizations[weapon_code] = {
		en = get_full_weapon_name_localized(weapon_code)
	}
end
localizations["forcestaff_p2_m1"]["en"] = localizations["forcestaff_p2_m1"]["en"].." Secondary Fire"
localizations["forcestaff_p3_m1"]["en"] = localizations["forcestaff_p2_m1"]["en"].." Secondary Fire"
-- Semi Automatics
localizations["forcestaff_p1_m1"]["en"] = localizations["forcestaff_p1_m1"]["en"].." Primary Fire"
--[[
for _, weapon_code in ipairs(mod.semiautomatic_weapon_labels) do
	localizations[weapon_code] = {
		en = get_full_weapon_name_localized(weapon_code)
	}
end
-- -------------
-- Melee
-- -------------
for _, weapon_table in ipairs(mod.melee_sound_effects_names) do
	local weapon_code = weapon_table.text
	localizations[weapon_code] = {
		en = get_full_weapon_name_localized(weapon_code)
	}
end
]]
-- second mark doesn't have a pattern defined because fuck you i guess
localizations["powermaul_shield_p1_m2"]["en"] = Localize("loc_weapon_pattern_powermaul_shield_p1_m1").." "..Localize("loc_weapon_mark_powermaul_shield_p1_m2").." "..Localize("loc_weapon_family_powermaul_shield_p1_m2")

-- ######################
-- Automatic SFX Names
--	Localizations for some of the automatic shooting sounds
--  These are just the labels appended by "_auto" or something
-- ######################
local sfx_automatic_simple = {
	autogun_p1_m1 = "_auto",
	autogun_p1_m2 = "_auto",
	autogun_p1_m3 = "_auto",
	autogun_p2_m1 = "_auto",
	autogun_p2_m2 = "_auto",
	autogun_p2_m3 = "_auto",
	lasgun_p3_m1 = "_fire_auto",
	lasgun_p3_m2 = "_fire_auto",
	lasgun_p3_m3 = "_fire_auto",
}
-- using pairs instead of ipairs because the keys are not just the index 1, 2, 3...
for weapon_code, append in pairs(sfx_automatic_simple) do
	localizations[weapon_code..append] = {
		en = get_full_weapon_name_localized(weapon_code) .. " Auto"
	}
end

return localizations