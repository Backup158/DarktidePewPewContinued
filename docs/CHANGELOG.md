# v1.9.1
2025-12-02

- Fixed:
    - Missing needle trail line effect
    - Incorrect values for dual autopistol sounds
    - Missing localizations for mod options
    - Missing mod option to change dual autopistol sounds
    - Wrong name for missile launcher

# v1.9.0
2025-12-02

No Man's Land: Hive Scum

- Added sounds for Hive Scum weapons
    - Branx MkIII Dual Autopistols
    - Branx MkVIII Dual Stub Pistols
    - Branx MKII Needle Pistol
    - Branx MKVI Needle Pistol
    - Chirurgeon's Mk IV Bone Saw
    - Enginseer's Mk VI Crowbar
    - Improvised Mk I Shivs
    - Improvised Mk III Shivs
    - Missile Launcher
- Added Line Effects from Hive Scum
    - `heavy_stubpistol_bullet`: Stub Pistol bullet
    - `needle_trail`: Needle Pistol

# v1.8.0
2025-09-30

- Added option to have "empty" line trails
    - technically it's 0.001 but effectively that's empty (crashes if you set effect to nil lol)
    - does NOT remove impacts and muzzle flash
    - Adds a new check in `change_line_effects`
        - changes the width, then exits
        - checks for option manually
- Added options for `pellet_trail_shock`
    - player line effect from arbites i think exaction mk 3 exterminator shotgun
    - the electro shotgun special
- Renamed some line effects
- Refactored (dev talk)
    - Player line effect search
        - automatically grabs player line effects
        - adds to table if not already in there
            - if it's something i intentionally left out don't insert
            - heavy stubpistol bullet
        - still have the manual entries to keep it sorted
            - in lua, only array tables (keys are integers) are guaranteed to be in order
            - automatic sorting (alphabetical) doesn't put it in an order i'd like, and i'm not making my own sorting rules
    - Moved some functions into different files to remove duplication of code
    - Added local references to global variables for better performance


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