local mod = get_mod("PewPew")

local minion_line_effects = require("scripts/settings/effects/minion_line_effects")

local table = table
local table_insert = table.insert
local pairs = pairs

-- ######################
-- Table Contains Value in Text Key
-- {
--	{ text = val },
--  { text = val },
-- }
-- ######################
function mod.table_contains_text(table, x)
    found = false
    for _, v in pairs(table) do
        if v.text == x then 
            found = true 
        end
    end
    return found
end
local table_contains_text = mod.table_contains_text

-- ######################
-- Add Effect from Original If Not Found
-- 
-- ######################
function mod.add_effect_from_original_if_not_found(effects_table_from_game, my_table_of_effects, table_of_keys_to_ignore)
	for line_effect_name, _ in pairs(effects_table_from_game) do
		-- not a line to skip AND not in table already
		if not (table_of_keys_to_ignore and table_contains_text(table_of_keys_to_ignore, line_effect_name)) and (not table_contains_text(my_table_of_effects, line_effect_name)) then
			mod:echo("line effect found: "..line_effect_name)
			table_insert(my_table_of_effects, { text=line_effect_name })
		end
	end
end
local add_effect_from_original_if_not_found = mod.add_effect_from_original_if_not_found

mod.ENEMY_LINE_EFFECTS = {
	{ text="renegade_lasbeam" },
	{ text="renegade_assault_lasbeam" },
	{ text="renegade_gunner_lasbeam" },
	{ text="renegade_sniper_lasbeam" },
	{ text="renegade_twin_captain_las_pistol_lasbeam" },
	{ text="cultist_autogun_bullet" },
	{ text="renegade_heavy_stubber_bullet" },
	{ text="renegade_pellet" },
	{ text="renegade_captain_pellet" },
	{ text="renegade_captain_boltshell" },
	{ text="renegade_captain_plasma_beam" },
}
add_effect_from_original_if_not_found(minion_line_effects, mod.ENEMY_LINE_EFFECTS)

mod.melee_sound_effects_names = {
	--{ text="bot_combataxe_linesman", },
	--{ text="bot_combatsword_linesman_p1", },
	--{ text="bot_combatsword_linesman_p2", },
	{ text="chainaxe_p1_m1", },
	{ text="chainaxe_p1_m2", },
	{ text="chainsword_2h_p1_m1", },
	{ text="chainsword_2h_p1_m2", },
	{ text="chainsword_p1_m1", },
	{ text="chainsword_p1_m2", },
	{ text="combataxe_p1_m1", },
	{ text="combataxe_p1_m2", },
	{ text="combataxe_p1_m3", },
	{ text="combataxe_p2_m1", },
	{ text="combataxe_p2_m2", },
	{ text="combataxe_p2_m3", },
	{ text="combataxe_p3_m1", },
	{ text="combataxe_p3_m2", },
	{ text="combataxe_p3_m3", },
	{ text="combatknife_p1_m1", },
	{ text="combatknife_p1_m2", },
	{ text="combatsword_p1_m1", },
	{ text="combatsword_p1_m2", },
	{ text="combatsword_p1_m3", },
	{ text="combatsword_p2_m1", },
	{ text="combatsword_p2_m2", },
	{ text="combatsword_p2_m3", },
	{ text="combatsword_p3_m1", },
	{ text="combatsword_p3_m2", },
	{ text="combatsword_p3_m3", },
	{ text="forcesword_2h_p1_m1", },
	{ text="forcesword_2h_p1_m2", },
	{ text="forcesword_p1_m1", },
	{ text="forcesword_p1_m2", },
	{ text="forcesword_p1_m3", },
	{ text="ogryn_club_p1_m1", },
	{ text="ogryn_club_p1_m2", },
	{ text="ogryn_club_p1_m3", },
	{ text="ogryn_club_p2_m1", },
	{ text="ogryn_club_p2_m2", },
	{ text="ogryn_club_p2_m3", },
	{ text="ogryn_combatblade_p1_m1", },
	{ text="ogryn_combatblade_p1_m2", },
	{ text="ogryn_combatblade_p1_m3", },
	--{ text="ogryn_gauntlet_p1_m1", },
	{ text="ogryn_pickaxe_2h_p1_m1", },
	{ text="ogryn_pickaxe_2h_p1_m2", },
	{ text="ogryn_pickaxe_2h_p1_m3", },
	{ text="ogryn_powermaul_p1_m1", },
	{ text="ogryn_powermaul_slabshield_p1_m1", },
	--{ text="ogryn_thumper_p1_m1", },
	--{ text="ogryn_thumper_p1_m2", },
	{ text="powermaul_2h_p1_m1", },
	{ text="powermaul_p1_m1", },
	{ text="powermaul_p1_m2", },
	{ text="powermaul_p2_m1", },
	--{ text="powermaul_p2_m2", },
	{ text="powermaul_shield_p1_m1", },
	{ text="powermaul_shield_p1_m2", },
	{ text="powersword_2h_p1_m1", },
	{ text="powersword_2h_p1_m2", },
	--{ text="powersword_2h_p1_m3", },
	{ text="powersword_p1_m1", },
	{ text="powersword_p1_m2", },
	--{ text="powersword_p1_m3", },
	{ text="powersword_p2_m1", },
	{ text="powersword_p2_m2", },
	{ text="thunderhammer_2h_p1_m1", },
	{ text="thunderhammer_2h_p1_m2", },
}