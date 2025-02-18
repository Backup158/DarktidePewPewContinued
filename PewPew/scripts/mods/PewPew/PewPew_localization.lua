-- Localizations: Universal
--	NOTE FOR FUTURE READERS: This is an absolute mess of copypasted code
--	However, there's so many exceptions to make the main functions work smoothly with Fatshark's naming scheme that automating localization is more effort than copypasting
--	This would require major refactors with not much benefit as far as I can tell
--	en=Localize("loc_weapon_pattern_<PLACEHOLDER>").." "..Localize("loc_weapon_mark_<PLACEHOLDER>").." "..Localize("loc_weapon_family_<PLACEHOLDER>")
--		and no, reassigning localizations for single shot doesn't work...
--	loc_weapon_px_mx brings up the old localizations from before Unlocked and Loaded
local localizations = {
	mod_title = { en="PewPew" },
	mod_description = { en="Change ranged weapon sounds and projectile visual effects" },
	line_effects_id = { en="Visual Effects" },
	sound_effects_id = { en="Fully Automatic Fire SFX" },
	single_shot_sound_effects_id = { en="Single Shot SFX" },

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

	-- ######################
	-- Automatic ranged weapon labels
	-- ######################
	autopistol_p1_m1 = { en=Localize("loc_weapon_pattern_autopistol_p1_m1").." "..Localize("loc_weapon_mark_autopistol_p1_m1").." "..Localize("loc_weapon_family_autopistol_p1_m1") },
	-- autopistol_p1_m2 = { en=Localize("loc_autopistol_p1_m2") }, -- Unreleased
	-- autopistol_p1_m3 = { en=Localize("loc_autopistol_p1_m3") }, -- Unreleased
	autogun_p1_m1 = { en=Localize("loc_weapon_pattern_autogun_p1_m1").." "..Localize("loc_weapon_mark_autogun_p1_m1").." "..Localize("loc_weapon_family_autogun_p1_m1") },
	autogun_p1_m2 = { en=Localize("loc_weapon_pattern_autogun_p1_m2").." "..Localize("loc_weapon_mark_autogun_p1_m2").." "..Localize("loc_weapon_family_autogun_p1_m2") },
	autogun_p1_m3 = { en=Localize("loc_weapon_pattern_autogun_p1_m3").." "..Localize("loc_weapon_mark_autogun_p1_m3").." "..Localize("loc_weapon_family_autogun_p1_m3") },
	autogun_p2_m1 = { en=Localize("loc_weapon_pattern_autogun_p2_m1").." "..Localize("loc_weapon_mark_autogun_p2_m1").." "..Localize("loc_weapon_family_autogun_p2_m1") },
	autogun_p2_m2 = { en=Localize("loc_weapon_pattern_autogun_p2_m2").." "..Localize("loc_weapon_mark_autogun_p2_m2").." "..Localize("loc_weapon_family_autogun_p2_m2") },
	autogun_p2_m3 = { en=Localize("loc_weapon_pattern_autogun_p2_m3").." "..Localize("loc_weapon_mark_autogun_p2_m3").." "..Localize("loc_weapon_family_autogun_p2_m3") },
	forcestaff_p2_m1 = { en=Localize("loc_weapon_pattern_forcestaff_p2_m1").." "..Localize("loc_weapon_mark_forcestaff_p2_m1").." "..Localize("loc_weapon_family_forcestaff_p2_m1") .. " Secondary Fire" },
	--forcestaff_p2_m2 = { en=Localize("loc_forcestaff_p2_m2") }, -- Unreleased
	forcestaff_p3_m1 = { en=Localize("loc_weapon_pattern_forcestaff_p3_m1").." "..Localize("loc_weapon_mark_forcestaff_p3_m1").." "..Localize("loc_weapon_family_forcestaff_p3_m1") .. " Secondary Fire" },
	flamer_p1_m1 = { en=Localize("loc_weapon_pattern_flamer_p1_m1").." "..Localize("loc_weapon_mark_flamer_p1_m1").." "..Localize("loc_weapon_family_flamer_p1_m1") },
	lasgun_p3_m1 = { en=Localize("loc_weapon_pattern_lasgun_p3_m1").." "..Localize("loc_weapon_mark_lasgun_p3_m1").." "..Localize("loc_weapon_family_lasgun_p3_m1") },
	lasgun_p3_m2 = { en=Localize("loc_weapon_pattern_lasgun_p3_m2").." "..Localize("loc_weapon_mark_lasgun_p3_m2").." "..Localize("loc_weapon_family_lasgun_p3_m2") },
	lasgun_p3_m3 = { en=Localize("loc_weapon_pattern_lasgun_p3_m3").." "..Localize("loc_weapon_mark_lasgun_p3_m3").." "..Localize("loc_weapon_family_lasgun_p3_m3") },
	ogryn_heavy_stubber_p1_m1 = { en=Localize("loc_weapon_pattern_ogryn_heavystubber_p1_m1").." "..Localize("loc_weapon_mark_ogryn_heavystubber_p1_m1").." "..Localize("loc_weapon_family_ogryn_heavystubber_p1_m1") },
	ogryn_heavy_stubber_p1_m2 = { en=Localize("loc_weapon_pattern_ogryn_heavystubber_p1_m2").." "..Localize("loc_weapon_mark_ogryn_heavystubber_p1_m2").." "..Localize("loc_weapon_family_ogryn_heavystubber_p1_m2") },
	ogryn_heavy_stubber_p1_m3 = { en=Localize("loc_weapon_pattern_ogryn_heavystubber_p1_m3").." "..Localize("loc_weapon_mark_ogryn_heavystubber_p1_m3").." "..Localize("loc_weapon_family_ogryn_heavystubber_p1_m3") },
	ogryn_heavy_stubber_p2_m1 = { en=Localize("loc_weapon_pattern_ogryn_heavystubber_p2_m1").." "..Localize("loc_weapon_mark_ogryn_heavystubber_p2_m1").." "..Localize("loc_weapon_family_ogryn_heavystubber_p2_m1") },
	ogryn_heavy_stubber_p2_m2 = { en=Localize("loc_weapon_pattern_ogryn_heavystubber_p2_m2").." "..Localize("loc_weapon_mark_ogryn_heavystubber_p2_m2").." "..Localize("loc_weapon_family_ogryn_heavystubber_p2_m2") },
	ogryn_heavy_stubber_p2_m3 = { en=Localize("loc_weapon_pattern_ogryn_heavystubber_p2_m3").." "..Localize("loc_weapon_mark_ogryn_heavystubber_p2_m3").." "..Localize("loc_weapon_family_ogryn_heavystubber_p2_m3") },
	
	-- ######################
	-- Single-shot ranged weapon labels
	-- ######################
	autogun_p3_m1 = { en=Localize("loc_weapon_pattern_autogun_p3_m1").." "..Localize("loc_weapon_mark_autogun_p3_m1").." "..Localize("loc_weapon_family_autogun_p3_m1") },
	autogun_p3_m2 = { en=Localize("loc_weapon_pattern_autogun_p3_m2").." "..Localize("loc_weapon_mark_autogun_p3_m2").." "..Localize("loc_weapon_family_autogun_p3_m2") },
	autogun_p3_m3 = { en=Localize("loc_weapon_pattern_autogun_p3_m3").." "..Localize("loc_weapon_mark_autogun_p3_m3").." "..Localize("loc_weapon_family_autogun_p3_m3") },
	bolter_p1_m1 = { en=Localize("loc_weapon_pattern_bolter_p1_m1").." "..Localize("loc_weapon_mark_bolter_p1_m1").." "..Localize("loc_weapon_family_bolter_p1_m1") },
	-- bolter_p1_m2 = { en=Localize("loc_bolter_p1_m2") }, -- Unreleased
	-- bolter_p1_m3 = { en=Localize("loc_bolter_p1_m3") }, -- Unreleased
	boltpistol_p1_m1 = { en=Localize("loc_weapon_pattern_boltpistol_p1_m1").." "..Localize("loc_weapon_mark_boltpistol_p1_m1").." "..Localize("loc_weapon_family_boltpistol_p1_m1") },
	-- bot_autogun_killshot = { en=Localize("loc_bot_autogun_killshot") },
	-- bot_lasgun_killshot = { en=Localize("loc_bot_lasgun_killshot") },
	-- bot_laspistol_killshot = { en=Localize("loc_bot_laspistol_killshot") },
	-- bot_zola_laspistol = { en=Localize("loc_bot_zola_laspistol") },
	psyker_smite = { en="Psyker 'Smite'" },
	forcestaff_p1_m1 = { en=Localize("loc_weapon_pattern_forcestaff_p1_m1").." "..Localize("loc_weapon_mark_forcestaff_p1_m1").." "..Localize("loc_weapon_family_forcestaff_p1_m1") .. " Primary Fire" },
	forcestaff_p4_m1 = { en=Localize("loc_weapon_pattern_forcestaff_p4_m1").." "..Localize("loc_weapon_mark_forcestaff_p4_m1").." "..Localize("loc_weapon_family_forcestaff_p4_m1") },
	lasgun_p1_m1 = { en=Localize("loc_weapon_pattern_lasgun_p1_m1").." "..Localize("loc_weapon_mark_lasgun_p1_m1").." "..Localize("loc_weapon_family_lasgun_p1_m1") },
	lasgun_p1_m2 = { en=Localize("loc_weapon_pattern_lasgun_p1_m2").." "..Localize("loc_weapon_mark_lasgun_p1_m2").." "..Localize("loc_weapon_family_lasgun_p1_m2") },
	lasgun_p1_m3 = { en=Localize("loc_weapon_pattern_lasgun_p1_m3").." "..Localize("loc_weapon_mark_lasgun_p1_m3").." "..Localize("loc_weapon_family_lasgun_p1_m3") },
	lasgun_p2_m1 = { en=Localize("loc_weapon_pattern_lasgun_p2_m1").." "..Localize("loc_weapon_mark_lasgun_p2_m1").." "..Localize("loc_weapon_family_lasgun_p2_m1") },
	lasgun_p2_m2 = { en=Localize("loc_weapon_pattern_lasgun_p2_m2").." "..Localize("loc_weapon_mark_lasgun_p2_m2").." "..Localize("loc_weapon_family_lasgun_p2_m2") },
	lasgun_p2_m3 = { en=Localize("loc_weapon_pattern_lasgun_p2_m3").." "..Localize("loc_weapon_mark_lasgun_p2_m3").." "..Localize("loc_weapon_family_lasgun_p2_m3") },
	laspistol_p1_m1 = { en=Localize("loc_weapon_pattern_laspistol_p1_m1").." "..Localize("loc_weapon_mark_laspistol_p1_m1").." "..Localize("loc_weapon_family_laspistol_p1_m1") },
	-- laspistol_p1_m2 = { en=Localize("loc_laspistol_p1_m2") }, -- Unreleased
	laspistol_p1_m3 = { en=Localize("loc_weapon_pattern_laspistol_p1_m3").." "..Localize("loc_weapon_mark_laspistol_p1_m3").." "..Localize("loc_weapon_family_laspistol_p1_m3") },
	ogryn_gauntlet_p1_m1 = { en=Localize("loc_weapon_pattern_ogryn_gauntlet_p1_m1").." "..Localize("loc_weapon_mark_ogryn_gauntlet_p1_m1").." "..Localize("loc_weapon_family_ogryn_gauntlet_p1_m1") },
	ogryn_thumper_p1_m1 = { en=Localize("loc_weapon_pattern_ogryn_thumper_p1_m1").." "..Localize("loc_weapon_mark_ogryn_thumper_p1_m1").." "..Localize("loc_weapon_family_ogryn_thumper_p1_m1") },
	ogryn_thumper_p1_m2 = { en=Localize("loc_weapon_pattern_ogryn_thumper_p1_m2").." "..Localize("loc_weapon_mark_ogryn_thumper_p1_m2").." "..Localize("loc_weapon_family_ogryn_thumper_p1_m2") },
	-- ogryn_thumper_p1_m3 = { en=Localize("loc_ogryn_thumper_p1_m3") }, -- Unreleased
	ogryn_rippergun_p1_m1 = { en=Localize("loc_weapon_pattern_ogryn_rippergun_p1_m1").." "..Localize("loc_weapon_mark_ogryn_rippergun_p1_m1").." "..Localize("loc_weapon_family_ogryn_rippergun_p1_m1") },
	ogryn_rippergun_p1_m2 = { en=Localize("loc_weapon_pattern_ogryn_rippergun_p1_m2").." "..Localize("loc_weapon_mark_ogryn_rippergun_p1_m2").." "..Localize("loc_weapon_family_ogryn_rippergun_p1_m2") },
	ogryn_rippergun_p1_m3 = { en=Localize("loc_weapon_pattern_ogryn_rippergun_p1_m3").." "..Localize("loc_weapon_mark_ogryn_rippergun_p1_m3").." "..Localize("loc_weapon_family_ogryn_rippergun_p1_m3") },
	shotgun_p1_m1 = { en=Localize("loc_weapon_pattern_shotgun_p1_m1").." "..Localize("loc_weapon_mark_shotgun_p1_m1").." "..Localize("loc_weapon_family_shotgun_p1_m1") },
	shotgun_p1_m2 = { en=Localize("loc_weapon_pattern_shotgun_p1_m2").." "..Localize("loc_weapon_mark_shotgun_p1_m2").." "..Localize("loc_weapon_family_shotgun_p1_m2") },
	shotgun_p1_m3 = { en=Localize("loc_weapon_pattern_shotgun_p1_m3").." "..Localize("loc_weapon_mark_shotgun_p1_m3").." "..Localize("loc_weapon_family_shotgun_p1_m3") },
	shotgun_p2_m1 = { en=Localize("loc_weapon_pattern_shotgun_p2_m1").." "..Localize("loc_weapon_mark_shotgun_p2_m1").." "..Localize("loc_weapon_family_shotgun_p2_m1") },
	stubrevolver_p1_m1 = { en=Localize("loc_weapon_pattern_stubrevolver_p1_m1").." "..Localize("loc_weapon_mark_stubrevolver_p1_m1").." "..Localize("loc_weapon_family_stubrevolver_p1_m1") },
	stubrevolver_p1_m2 = { en=Localize("loc_weapon_pattern_stubrevolver_p1_m2").." "..Localize("loc_weapon_mark_stubrevolver_p1_m2").." "..Localize("loc_weapon_family_stubrevolver_p1_m2") },
	-- stubrevolver_p1_m3 = { en=Localize("loc_stubrevolver_p1_m3") }, -- Unreleased
	plasmagun_p1_m1 = { en=Localize("loc_weapon_pattern_plasmagun_p1_m1").." "..Localize("loc_weapon_mark_plasmagun_p1_m1").." "..Localize("loc_weapon_family_plasmagun_p1_m1") },
	-- plasmagun_p1_m2 = { en=Localize("loc_plasmagun_p1_m2") }, -- Unreleased

	-- ######################
	-- LOOPING RANGED SFX
	-- ######################
	weapon_autopistol_auto = { en=Localize("loc_weapon_family_autopistol_p1_m1") .. " Auto" },
	autogun_p1_m1_auto = { en=Localize("loc_weapon_pattern_autogun_p1_m1").." "..Localize("loc_weapon_mark_autogun_p1_m1").." "..Localize("loc_weapon_family_autogun_p1_m1") .. " Auto" },
	autogun_p1_m2_auto = { en=Localize("loc_weapon_pattern_autogun_p1_m2").." "..Localize("loc_weapon_mark_autogun_p1_m2").." "..Localize("loc_weapon_family_autogun_p1_m2") .. " Auto" },
	autogun_p1_m3_auto = { en=Localize("loc_weapon_pattern_autogun_p1_m3").." "..Localize("loc_weapon_mark_autogun_p1_m3").." "..Localize("loc_weapon_family_autogun_p1_m3") .. " Auto" },
	autogun_p2_m1_auto = { en=Localize("loc_weapon_pattern_autogun_p2_m1").." "..Localize("loc_weapon_mark_autogun_p2_m1").." "..Localize("loc_weapon_family_autogun_p2_m1") .. " Auto" },
	autogun_p2_m2_auto = { en=Localize("loc_weapon_pattern_autogun_p2_m2").." "..Localize("loc_weapon_mark_autogun_p2_m2").." "..Localize("loc_weapon_family_autogun_p2_m2") .. " Auto" },
	autogun_p2_m3_auto = { en=Localize("loc_weapon_pattern_autogun_p2_m3").." "..Localize("loc_weapon_mark_autogun_p2_m3").." "..Localize("loc_weapon_family_autogun_p2_m3") .. " Auto" },
	flamethrower_fire_loop = { en="Flamethrower Fire Loop" },
	forcestaff_warp_fire = { en="Forcestaff Warp Fire" },
	lasgun_p3_m1_fire_auto = { en=Localize("loc_weapon_pattern_lasgun_p3_m1").." "..Localize("loc_weapon_mark_lasgun_p3_m1").." "..Localize("loc_weapon_family_lasgun_p3_m1") .. " Fire Auto" },
	lasgun_p3_m2_fire_auto = { en=Localize("loc_weapon_pattern_lasgun_p3_m2").." "..Localize("loc_weapon_mark_lasgun_p3_m2").." "..Localize("loc_weapon_family_lasgun_p3_m2") .. " Fire Auto" },
	lasgun_p3_m3_fire_auto = { en=Localize("loc_weapon_pattern_lasgun_p3_m3").." "..Localize("loc_weapon_mark_lasgun_p3_m3").." "..Localize("loc_weapon_family_lasgun_p3_m3") .. " Fire Auto" },
	heavy_stubber_auto = { en=Localize("loc_weapon_pattern_ogryn_heavystubber_p1_m1").." "..Localize("loc_weapon_mark_ogryn_heavystubber_p1_m1").." "..Localize("loc_weapon_family_ogryn_heavystubber_p1_m1") .. " Auto" },
	heavy_stubber_p1_m2_auto = { en=Localize("loc_weapon_pattern_ogryn_heavystubber_p1_m2").." "..Localize("loc_weapon_mark_ogryn_heavystubber_p1_m2").." "..Localize("loc_weapon_family_ogryn_heavystubber_p1_m2") .. " Auto" },
	heavy_stubber_p1_m3_auto = { en=Localize("loc_weapon_pattern_ogryn_heavystubber_p1_m3").." "..Localize("loc_weapon_mark_ogryn_heavystubber_p1_m3").." "..Localize("loc_weapon_family_ogryn_heavystubber_p1_m3") .. " Auto" },
	heavy_stubber_p2_m1_auto = { en=Localize("loc_weapon_pattern_ogryn_heavystubber_p2_m1").." "..Localize("loc_weapon_mark_ogryn_heavystubber_p2_m1").." "..Localize("loc_weapon_family_ogryn_heavystubber_p2_m1") .. " Auto" },
	heavy_stubber_p2_m2_auto = { en=Localize("loc_weapon_pattern_ogryn_heavystubber_p2_m2").." "..Localize("loc_weapon_mark_ogryn_heavystubber_p2_m2").." "..Localize("loc_weapon_family_ogryn_heavystubber_p2_m2") .. " Auto" },
	heavy_stubber_p2_m3_auto = { en=Localize("loc_weapon_pattern_ogryn_heavystubber_p2_m3").." "..Localize("loc_weapon_mark_ogryn_heavystubber_p2_m3").." "..Localize("loc_weapon_family_ogryn_heavystubber_p2_m3") .. " Auto" },
	psyker_chain_lightning = { en="Psyker Chain Lightning" },
	-- Charging FX
	-- 	Helbore
	--lasgun_p2_charge = { en="Lasgun P2 Charge" },
	lasgun_p2_charge = { en=Localize("loc_weapon_pattern_lasgun_p2_m1").." "..Localize("loc_weapon_mark_lasgun_p2_m1").." "..Localize("loc_weapon_family_lasgun_p2_m1") .. " Charge" }, -- It's the first mk, as seen in the code. ranged_charging table
	lasgun_p2_m2_charge = { en=Localize("loc_weapon_pattern_lasgun_p2_m2").." "..Localize("loc_weapon_mark_lasgun_p2_m2").." "..Localize("loc_weapon_family_lasgun_p2_m2") .. " Charge" },
	lasgun_p2_m3_charge = { en=Localize("loc_weapon_pattern_lasgun_p2_m3").." "..Localize("loc_weapon_mark_lasgun_p2_m3").." "..Localize("loc_weapon_family_lasgun_p2_m3") .. " Charge" },
	-- 	Psyker
	-- 		Smite
	--psyker_chain_lightning_charge = { en="Psyker Chain Lightning Charge" },
	psyker_chain_lightning_charge = { en="Psyker Smite Charge" },
	--		Brain Burst/Rupture and staff primary
	psyker_smite_charge = { en="Psyker 'Smite' Charge" },
	--psyker_headpop_hands = { en="Psyker Headpop Hands" },
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
	weapon_autopistol = { en=Localize("loc_weapon_pattern_autopistol_p1_m1").." "..Localize("loc_weapon_mark_autopistol_p1_m1").." "..Localize("loc_weapon_family_autopistol_p1_m1") },
	autogun_p3_m1_single = { en=Localize("loc_weapon_pattern_autogun_p3_m1").." "..Localize("loc_weapon_mark_autogun_p3_m1").." "..Localize("loc_weapon_family_autogun_p3_m1") },
	autogun_p3_m2_single = { en=Localize("loc_weapon_pattern_autogun_p3_m3").." "..Localize("loc_weapon_mark_autogun_p3_m3").." "..Localize("loc_weapon_family_autogun_p3_m3") },
	autogun_p3_m3_single = { en=Localize("loc_weapon_pattern_autogun_p3_m3").." "..Localize("loc_weapon_mark_autogun_p3_m3").." "..Localize("loc_weapon_family_autogun_p3_m3") },
	weapon_bolter = { en=Localize("loc_weapon_pattern_bolter_p1_m1").." "..Localize("loc_weapon_mark_bolter_p1_m1").." "..Localize("loc_weapon_family_bolter_p1_m1") },
	bolt_pistol_p1_m1_single = { en=Localize("loc_weapon_pattern_boltpistol_p1_m1").." "..Localize("loc_weapon_mark_boltpistol_p1_m1").." "..Localize("loc_weapon_family_boltpistol_p1_m1") },
	weapon_lasgun_p1_m1 = { en=Localize("loc_weapon_pattern_lasgun_p1_m1").." "..Localize("loc_weapon_mark_lasgun_p1_m1").." "..Localize("loc_weapon_family_lasgun_p1_m1") },
	weapon_lasgun_p1_m2 = { en=Localize("loc_weapon_pattern_lasgun_p1_m2").." "..Localize("loc_weapon_mark_lasgun_p1_m2").." "..Localize("loc_weapon_family_lasgun_p1_m2") },
	weapon_lasgun_p1_m3 = { en=Localize("loc_weapon_pattern_lasgun_p1_m3").." "..Localize("loc_weapon_mark_lasgun_p1_m3").." "..Localize("loc_weapon_family_lasgun_p1_m3") },
	lasgun_p2_m1 = { en=Localize("loc_weapon_pattern_lasgun_p2_m1").." "..Localize("loc_weapon_mark_lasgun_p2_m1").." "..Localize("loc_weapon_family_lasgun_p2_m1") },
	lasgun_p2_m2 = { en=Localize("loc_weapon_pattern_lasgun_p2_m2").." "..Localize("loc_weapon_mark_lasgun_p2_m2").." "..Localize("loc_weapon_family_lasgun_p2_m2") },
	lasgun_p2_m3 = { en=Localize("loc_weapon_pattern_lasgun_p2_m3").." "..Localize("loc_weapon_mark_lasgun_p2_m3").." "..Localize("loc_weapon_family_lasgun_p2_m3") },
	weapon_laspistol = { en=Localize("loc_weapon_pattern_laspistol_p1_m1").." "..Localize("loc_weapon_mark_laspistol_p1_m1").." "..Localize("loc_weapon_family_laspistol_p1_m1") },
	-- laspistol_p1_m2 = { en=Localize("loc_laspistol_p1_m2") },
	laspistol_p1_m3 = { en=Localize("loc_weapon_pattern_laspistol_p1_m3").." "..Localize("loc_weapon_mark_laspistol_p1_m3").." "..Localize("loc_weapon_family_laspistol_p1_m3") },
	weapon_rippergun = { en=Localize("loc_weapon_pattern_ogryn_rippergun_p1_m1").." "..Localize("loc_weapon_mark_ogryn_rippergun_p1_m1").." "..Localize("loc_weapon_family_ogryn_rippergun_p1_m1") },
	ogryn_gauntlet_fire = { en=Localize("loc_weapon_pattern_ogryn_gauntlet_p1_m1").." "..Localize("loc_weapon_mark_ogryn_gauntlet_p1_m1").." "..Localize("loc_weapon_family_ogryn_gauntlet_p1_m1") },
	ogryn_thumper_p1_m1 = { en=Localize("loc_weapon_pattern_ogryn_thumper_p1_m1").." "..Localize("loc_weapon_mark_ogryn_thumper_p1_m1").." "..Localize("loc_weapon_family_ogryn_thumper_p1_m1") },
	ogryn_thumper_p1_m2 = { en=Localize("loc_weapon_pattern_ogryn_thumper_p1_m2").." "..Localize("loc_weapon_mark_ogryn_thumper_p1_m2").." "..Localize("loc_weapon_family_ogryn_thumper_p1_m2") },
	combat_weapon_shotgun = { en=Localize("loc_weapon_pattern_shotgun_p1_m1").." "..Localize("loc_weapon_mark_shotgun_p1_m1").." "..Localize("loc_weapon_family_shotgun_p1_m1") },
	shotgun_p1_m2 = { en=Localize("loc_weapon_pattern_shotgun_p1_m2").." "..Localize("loc_weapon_mark_shotgun_p1_m2").." "..Localize("loc_weapon_family_shotgun_p1_m2") },
	shotgun_p1_m3 = { en=Localize("loc_weapon_pattern_shotgun_p1_m3").." "..Localize("loc_weapon_mark_shotgun_p1_m3").." "..Localize("loc_weapon_family_shotgun_p1_m3") },
	shotgun_p2_m1 = { en=Localize("loc_weapon_pattern_shotgun_p2_m1").." "..Localize("loc_weapon_mark_shotgun_p2_m1").." "..Localize("loc_weapon_family_shotgun_p2_m1") },
	--stub_revolver = { en=Localize("loc_stub_revolver") }, -- For some reason this shows up as 'Chambered'
	stub_revolver = { en=Localize("loc_weapon_pattern_stubrevolver_p1_m1").." "..Localize("loc_weapon_mark_stubrevolver_p1_m1").." "..Localize("loc_weapon_family_stubrevolver_p1_m1") },
	stub_revolver_p1_m2 = { en=Localize("loc_weapon_pattern_stubrevolver_p1_m2").." "..Localize("loc_weapon_mark_stubrevolver_p1_m2").." "..Localize("loc_weapon_family_stubrevolver_p1_m2") },
	-- stub_revolver_p1_m3 = { en=Localize("loc_stubrevolver_p1_m3") },
	weapon_plasmagun = { en=Localize("loc_weapon_pattern_plasmagun_p1_m1").." "..Localize("loc_weapon_mark_plasmagun_p1_m1").." "..Localize("loc_weapon_family_plasmagun_p1_m1") },
	psyker_smite_fire = { en="Psyker 'Smite' Fire" },
}

return localizations