# v1.7.0: Bound by Duty
2025-09-25

- Added new weapons
    - Power Falchions
        - `powersword_p2_m1`
        - `powersword_p2_m2`
    - Godwyn-Branx Mk VI Bolt Pistol (`boltpistol_p1_m2`)
    - Locke Mk III Spearhead Boltgun (`bolter_p1_m2`)
- Made mod version a global so other mods can check for it (not like anyone's doing that)

# v1.6.3
2025-07-23

- Removed extraneous option for Exterminator Shotgun sounds
    - `shotgun_p4_m2` is the Mk VIII
    - It uses the same sound as the `shotgun_p4_m1` so having it as an option just made the gun silent
    - e.g. Putting the Exaction Mk VIII Exterminator Shotgun sound on an Agripinaa Mk VII Combat Shotgun makes the Combat Shotgun silent
- Added silent weapon sounds
    - To single shot, ranged shooting,

# v1.6.2
2025-06-25

- Refactored localizations to avoid needing the cursed as hard-coded tables (thanks to Norkkom for mentioning the WeaponTemplates in public)

# v1.6.1
2025-06-23

- Added support for Arbites weapons
    - Arbites Shock Maul (powermaul), including the ones with shield
    - Subductor Shotpistol and Riot Shield
    - Exaction Shotgun
- Removed melee sound swaps for passive audio
    - This was moved to the looping audio table, which I can't access easily

# v1.6.0
2025-06-21

- Started keeping a changelog
- Created function for basic localizations for weapon labels to be done through a loop
- **ADDED FEATURE TO SWAP MELEE WEAPON SOUNDS**
    - Does not support gauntlet punch and rumbler/kickback smacks bc i'm too lazy to make exceptions
    - Swaps swings for lights and heavies, hits\*, push attacks, and special/idle sounds
        - \* Many of the hit sounds are the same across weapons, and i don't think it even swaps correctly
        - Chainsword special activation is not stored here, so you won't get that to work