local mod = get_mod("PewPew")

local LINE_EFFECTS_OPTIONS = {
	{ text="lasbeam" },
	{ text="lasbeam_pistol" },
	{ text="lasbeam_pistol_ads" },
	{ text="lasbeam_heavy_pistol" }, -- scripts/settings/equipment/weapon_templates/laspistols/laspistol_p1_m3.lua
	{ text="lasbeam_killshot" },
	{ text="lasbeam_elysian" },
	{ text="lasbeam_charged" },
	{ text="lasbeam_bfg" },
	{ text="autogun_bullet" },
	--{ text="heavy_stubpistol_bullet" },
	{ text="heavy_stubber_bullet" },
	{ text="pellet_trail" },
	{ text="shotgun_slug_trail" },
	{ text="shotgun_incendiary_trail" },
	{ text="ripper_trail" },
	{ text="boltshell" },
	{ text="plasma_beam" },
}
for i, option in ipairs(LINE_EFFECTS_OPTIONS) do
	LINE_EFFECTS_OPTIONS[i].value = LINE_EFFECTS_OPTIONS[i].text
end
local SOUND_EFFECTS_OPTIONS = {
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
	{ text="heavy_stubber_p2_m1_auto" },
	{ text="heavy_stubber_p2_m2_auto" },
	{ text="heavy_stubber_p2_m3_auto" },
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
for i, option in ipairs(SOUND_EFFECTS_OPTIONS) do
	SOUND_EFFECTS_OPTIONS[i].value = SOUND_EFFECTS_OPTIONS[i].text
end
local SINGLE_SHOT_SOUND_EFFECTS_OPTIONS = {
	{ text="weapon_autopistol" },
	{ text="autogun_p3_m1_single" },
	{ text="autogun_p3_m2_single" },
	{ text="autogun_p3_m3_single" },
	{ text="weapon_bolter" },
	{ text="bolt_pistol_p1_m1_single" },
	{ text="weapon_laspistol" },  -- laspistol_p1_m1
	-- { text="laspistol_p1_m2" },
	{ text="laspistol_p1_m3" },	-- Uncommented for Mk X Heavy Laspistol
	{ text="weapon_lasgun_p1_m1" },
	{ text="weapon_lasgun_p1_m2" },
	{ text="weapon_lasgun_p1_m3" },
	{ text="lasgun_p2_m1" },
	{ text="lasgun_p2_m2" },
	{ text="lasgun_p2_m3" },
	{ text="psyker_smite_fire" },
	{ text="combat_weapon_shotgun" },
	{ text="shotgun_p1_m2" },
	{ text="shotgun_p1_m3" },
	{ text="shotgun_p2_m1" }, -- double barrel
	{ text="stub_revolver" }, -- stubrevolver_p1_m1
	{ text="stub_revolver_p1_m2" },	-- uncommented for Mk XIV agri cowboy yeehaw
	-- { text="stub_revolver_p1_m3" },
	{ text="ogryn_gauntlet_fire" },
	{ text="ogryn_thumper_p1_m1" },
	{ text="ogryn_thumper_p1_m2" },
	{ text="weapon_plasmagun" },
	{ text="weapon_rippergun" },
}
for i, option in ipairs(SINGLE_SHOT_SOUND_EFFECTS_OPTIONS) do
	SINGLE_SHOT_SOUND_EFFECTS_OPTIONS[i].value = SINGLE_SHOT_SOUND_EFFECTS_OPTIONS[i].text
end

mod.line_effects_widgets = {
	{ setting_id="lasbeam" },
	{ setting_id="lasbeam_pistol" },
	{ setting_id="lasbeam_pistol_ads" },
	{ setting_id="lasbeam_heavy_pistol" },
	{ setting_id="lasbeam_killshot" },
	{ setting_id="lasbeam_elysian" },
	{ setting_id="lasbeam_charged" },
	{ setting_id="lasbeam_bfg" },
	{ setting_id="autogun_bullet" },
	--{ setting_id="heavy_stubpistol_bullet" },
	{ setting_id="heavy_stubber_bullet" },
	{ setting_id="pellet_trail" },
	{ setting_id="shotgun_slug_trail" },
	{ setting_id="shotgun_incendiary_trail" },
	{ setting_id="ripper_trail" },
	{ setting_id="boltshell" },
	{ setting_id="plasma_beam" },
}
for i, line_effects_widget in ipairs(mod.line_effects_widgets) do
	mod.line_effects_widgets[i].type = "dropdown"
	mod.line_effects_widgets[i].default_value = line_effects_widget.setting_id
	mod.line_effects_widgets[i].options = table.clone(LINE_EFFECTS_OPTIONS)
end
mod.sound_effects_widgets = {
	{ setting_id="autopistol_p1_m1", default_value="weapon_autopistol_auto" },
	-- { setting_id="autopistol_p1_m2", default_value="weapon_autopistol_auto" },
	-- { setting_id="autopistol_p1_m3", default_value="weapon_autopistol_auto" },
	{ setting_id="autogun_p1_m1", default_value="autogun_p1_m1_auto" },
	{ setting_id="autogun_p1_m2", default_value="autogun_p1_m2_auto" },
	{ setting_id="autogun_p1_m3", default_value="autogun_p1_m3_auto" },
	{ setting_id="autogun_p2_m1", default_value="autogun_p2_m1_auto" },
	{ setting_id="autogun_p2_m2", default_value="autogun_p2_m2_auto" },	
	{ setting_id="autogun_p2_m3", default_value="autogun_p2_m3_auto" },
	{ setting_id="flamer_p1_m1", default_value="flamethrower_fire_loop" },
	{ setting_id="forcestaff_p2_m1", default_value="forcestaff_warp_fire" },
	-- { setting_id="forcestaff_p2_m2", default_value="forcestaff_warp_fire" },
	{ setting_id="forcestaff_p3_m1", default_value="psyker_chain_lightning" },
	{ setting_id="lasgun_p3_m1", default_value="lasgun_p3_m1_fire_auto" },
	{ setting_id="lasgun_p3_m2", default_value="lasgun_p3_m2_fire_auto" },
	{ setting_id="lasgun_p3_m3", default_value="lasgun_p3_m3_fire_auto" },
	{ setting_id="ogryn_heavy_stubber_p1_m1", default_value="heavy_stubber_auto" },
	{ setting_id="ogryn_heavy_stubber_p1_m2", default_value="heavy_stubber_p1_m2_auto" },
	{ setting_id="ogryn_heavy_stubber_p1_m3", default_value="heavy_stubber_p1_m3_auto" },
	{ setting_id="ogryn_heavy_stubber_p2_m1", default_value="heavy_stubber_p2_m1_auto" },
	{ setting_id="ogryn_heavy_stubber_p2_m2", default_value="heavy_stubber_p2_m2_auto" },
	{ setting_id="ogryn_heavy_stubber_p2_m3", default_value="heavy_stubber_p2_m3_auto" },
}
mod.single_shot_sound_effects_widgets = {
	{ setting_id="autogun_p3_m1", default_value="autogun_p3_m1_single" },
	{ setting_id="autogun_p3_m2", default_value="autogun_p3_m2_single" },
	{ setting_id="autogun_p3_m3", default_value="autogun_p3_m3_single" },
	{ setting_id="bolter_p1_m1", default_value="weapon_bolter" },
	-- { setting_id="bolter_p1_m2", default_value="weapon_bolter" },
	-- { setting_id="bolter_p1_m3", default_value="weapon_bolter" },
	{ setting_id="boltpistol_p1_m1", default_value="bolt_pistol_p1_m1_single" },
	{ setting_id="forcestaff_p1_m1", default_value="psyker_smite_fire" },
	{ setting_id="forcestaff_p4_m1", default_value="psyker_smite_fire" },
	{ setting_id="laspistol_p1_m1", default_value="weapon_laspistol" },
	-- { setting_id="laspistol_p1_m2", default_value="laspistol_p1_m2" },
	{ setting_id="laspistol_p1_m3", default_value="laspistol_p1_m3" },	-- Uncommented for Mk X Heavy Laspistol
	{ setting_id="lasgun_p1_m1", default_value="weapon_lasgun_p1_m1" },
	{ setting_id="lasgun_p1_m2", default_value="weapon_lasgun_p1_m2" },
	{ setting_id="lasgun_p1_m3", default_value="weapon_lasgun_p1_m3" },
	{ setting_id="lasgun_p2_m1", default_value="lasgun_p2_m1" },
	{ setting_id="lasgun_p2_m2", default_value="lasgun_p2_m2" },
	{ setting_id="lasgun_p2_m3", default_value="lasgun_p2_m3" },
	{ setting_id="ogryn_gauntlet_p1_m1", default_value="ogryn_gauntlet_fire" },
	{ setting_id="ogryn_rippergun_p1_m1", default_value="weapon_rippergun" },
	{ setting_id="ogryn_rippergun_p1_m2", default_value="weapon_rippergun" },
	{ setting_id="ogryn_rippergun_p1_m3", default_value="weapon_rippergun" },
	{ setting_id="ogryn_thumper_p1_m1", default_value="ogryn_thumper_p1_m1" },
	{ setting_id="ogryn_thumper_p1_m2", default_value="ogryn_thumper_p1_m2" },
	-- { setting_id="ogryn_thumper_p1_m3", default_value="ogryn_thumper_p1_m3" },
	{ setting_id="plasmagun_p1_m1", default_value="weapon_plasmagun" },
	-- { setting_id="plasmagun_p1_m2", default_value="weapon_plasmagun" },
	{ setting_id="psyker_smite", default_value="psyker_smite_fire" },
	{ setting_id="shotgun_p1_m1", default_value="combat_weapon_shotgun" },
	{ setting_id="shotgun_p1_m2", default_value="shotgun_p1_m2" },
	{ setting_id="shotgun_p1_m3", default_value="shotgun_p1_m3" },
	{ setting_id="shotgun_p2_m1", default_value="shotgun_p2_m1" },
	{ setting_id="stubrevolver_p1_m1", default_value="stub_revolver" },
	{ setting_id="stubrevolver_p1_m2", default_value="stub_revolver_p1_m2" },	-- uncommented for Mk XIV agri cowboy yeehaw
	-- { setting_id="stubrevolver_p1_m3", default_value="stub_revolver_p1_m3" },
	-- { setting_id="bot_zola_laspistol", default_value="weapon_laspistol" },
	-- { setting_id="bot_laspistol_killshot", default_value="weapon_laspistol" },
	-- { setting_id="bot_lasgun_killshot", default_value="weapon_lasgun_p1_m1" },
	-- { setting_id="bot_autogun_killshot", default_value="autogun_p3_m1_single" },
}
for i, sound_effects_widget in ipairs(mod.sound_effects_widgets) do
	mod.sound_effects_widgets[i].type = "dropdown"
	mod.sound_effects_widgets[i].options = table.clone(SOUND_EFFECTS_OPTIONS)
end
for i, single_shot_sound_effects_widgets in ipairs(mod.single_shot_sound_effects_widgets) do
	mod.single_shot_sound_effects_widgets[i].type = "dropdown"
	mod.single_shot_sound_effects_widgets[i].options = table.clone(SINGLE_SHOT_SOUND_EFFECTS_OPTIONS)
end

return {
	name = mod:localize("mod_title"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	allow_rehooking = true,
	options = {
		widgets = {
			{ setting_id="line_effects_id", type="group", sub_widgets=mod.line_effects_widgets },
			{ setting_id="sound_effects_id", type="group", sub_widgets=mod.sound_effects_widgets },
			{ setting_id="single_shot_sound_effects_id", type="group", sub_widgets=mod.single_shot_sound_effects_widgets },
		},
	},
}
