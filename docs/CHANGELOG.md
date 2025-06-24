# v1.6.1
2025-06-23

- Added support for Arbites weapons
    - Powermaul, including the ones with shield
    - Shotpistol
    - Executioner Shotgun
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