local mod = get_mod("PewPew")

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
mod.RANGED_SHOOTING_SOUND_EFFECTS = {
    -- Default (Silence)
    weapon_silence =                    { braced="weapon_silence", pre_loop_shot="weapon_silence", single_shot=nil },
    -- Autoguns
    --  Yes, one of them says single instead of first. Blame Fatshark
    --  Infantry
    autogun_p1_m1_auto =                { braced="autogun_p1_m1_auto", pre_loop_shot="autogun_p1_m1_first", single_shot=nil },
    autogun_p1_m2_auto =                { braced="autogun_p1_m2_auto", pre_loop_shot="autogun_p1_m2_single", single_shot=nil },
    autogun_p1_m3_auto =                { braced="autogun_p1_m3_auto", pre_loop_shot="autogun_p1_m3_first", single_shot=nil },
    --  Braced
    autogun_p2_m1_auto =                { braced="autogun_p2_m1_auto", pre_loop_shot="autogun_p2_m1_first", single_shot=nil },
    autogun_p2_m2_auto =                { braced="autogun_p2_m2_auto", pre_loop_shot="autogun_p2_m2_first", single_shot=nil },
    autogun_p2_m3_auto =                { braced="autogun_p2_m3_auto", pre_loop_shot="autogun_p2_m3_first", single_shot=nil },
    -- Shredder Autopistol
    weapon_autopistol_auto =            { braced="weapon_autopistol_auto", pre_loop_shot="weapon_autopistol", single_shot="weapon_autopistol" }, -- equivalent to autopistol_p1_m1
    -- Dual Autopistols
    weapon_dual_autopistols_dual_auto = { braced="weapon_dual_autopistols_dual_auto", pre_loop_shot="weapon_dual_autopistols", single_shot="weapon_dual_autopistols" },
    -- Dual Stubpistols
    --      See single_shot note
    -- Bolter
    --      See single_shot note
    -- Boltpistol
    --      See single_shot note
    -- Infantry Lasgun
    --      See single_shot note
    -- Helbore Lasgun
    lasgun_p2_charge =                  { braced="lasgun_p2_charge", pre_loop_shot="weapon_silence", single_shot=nil }, -- equivalent to lasgun_p2_m1_charge
    -- Bolter
    lasgun_p2_m2_charge =               { braced="lasgun_p2_m2_charge", pre_loop_shot="weapon_silence", single_shot=nil },
    lasgun_p2_m3_charge =               { braced="lasgun_p2_m3_charge", pre_loop_shot="weapon_silence", single_shot=nil },
    -- Recon Lasgun
    lasgun_p3_m1_fire_auto =            { braced="lasgun_p3_m1_fire_auto", pre_loop_shot="lasgun_p3_m1_fire_single", single_shot=nil },
    lasgun_p3_m2_fire_auto =            { braced="lasgun_p3_m2_fire_auto", pre_loop_shot="lasgun_p3_m2_fire_single", single_shot=nil },
    lasgun_p3_m3_fire_auto =            { braced="lasgun_p3_m3_fire_auto", pre_loop_shot="lasgun_p3_m3_fire_single", single_shot=nil },
    -- Laspistol
    --      See single_shot note
    -- Grenade Gauntlet
    --      See single_shot note
    -- Heavy Stubber
    --  Twin-Linked
    heavy_stubber_auto =                { braced="heavy_stubber_auto", pre_loop_shot="heavy_stubber_punch_first", single_shot=nil }, -- equivalent to heavy_stubber_p1_m1_auto
    heavy_stubber_p1_m2_auto =          { braced="heavy_stubber_p1_m2_auto", pre_loop_shot="heavy_stubber_p1_m2_punch_first", single_shot=nil },
    heavy_stubber_p1_m3_auto =          { braced="heavy_stubber_p1_m3_auto", pre_loop_shot="heavy_stubber_p1_m3_punch_first", single_shot=nil },
    --  Single
    --      See single_shot note
    -- Needlepistol
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
    forcestaff_warp_fire =              { braced="forcestaff_warp_fire", pre_loop_shot="weapon_silence", single_shot="psyker_smite_fire" },
    forcestaff_warp_fire_charge_loop =  { braced="forcestaff_warp_fire_charge_loop", pre_loop_shot="weapon_silence", single_shot=nil },
    forcestaff_p4_charge_loop =         { braced="forcestaff_p4_charge_loop", pre_loop_shot="weapon_silence", single_shot=nil },
    -- Psyker Blitz
    --  Smite
    psyker_chain_lightning =            { braced="psyker_chain_lightning_heavy", pre_loop_shot="weapon_silence", single_shot=nil },
    psyker_chain_lightning_charge =     { braced="psyker_chain_lightning_charge", pre_loop_shot="weapon_silence", single_shot=nil },
    --  Brain Burst/Rupture
    psyker_smite_charge =               { braced="psyker_smite_charge", pre_loop_shot="weapon_silence", single_shot=nil },
    psyker_headpop_hands =              { braced="psyker_headpop_hands", pre_loop_shot="weapon_silence", single_shot=nil },
    -- Flamer
    flamethrower_fire_loop =            { braced=nil, pre_loop_shot="weapon_silence", single_shot=nil },
    -- Plasmagun
    plasmagun_charge =                  { braced="plasmagun_charge", pre_loop_shot="weapon_silence", single_shot=nil },
    weapon_plasmagun_charge_fast =      { braced="weapon_plasmagun_charge_fast", pre_loop_shot="weapon_silence", single_shot=nil },
    weapon_plasma_mech_vent =           { braced="weapon_plasma_mech_vent", pre_loop_shot="weapon_silence", single_shot=nil },
    -- Weapon Special Power Sounds
    --  Thunderhammer
    thunder_hammer_powered_loop =       { braced="thunder_hammer_powered_loop", pre_loop_shot="weapon_silence", single_shot=nil },
    --  Force Sword
    force_sword_loop =                  { braced="force_sword_loop", pre_loop_shot="weapon_silence", single_shot=nil },
    force_sword_2h_loop =               { braced="force_2h_sword_loop", pre_loop_shot="weapon_silence", single_shot=nil },
    --  Power Sword (1h Vet, 2h Zealot uses the same sound)
    power_sword_loop =                  { braced="power_sword_loop", pre_loop_shot="weapon_silence", single_shot=nil },
    --  Power Maul (1h Ogryn, 2h Zealot uses the same sound)
    ogryn_power_maul_1h_loop =          { braced="ogryn_power_maul_1h_loop", pre_loop_shot="weapon_silence", single_shot=nil },
}
-- fully_charged entries for weapons in ranged_single_shot table
mod.CHARGED_SINGLE_SHOT_SFX = {
    -- Helbore Lasgun
    lasgun_p2_m1 = "lasgun_p2_m1_charged",
    lasgun_p2_m2 = "lasgun_p2_m2_charged",
    lasgun_p2_m3 = "lasgun_p2_m3_charged",
    -- Plasmagun
    plasmagun_p1_m1 = "weapon_plasmagun_charged",
    --plasmagun_p1_m2 = "weapon_plasmagun_charged", -- Unreleased
}