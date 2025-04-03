# PewPewPew
[Original PewPew mod](https://www.nexusmods.com/warhammer40kdarktide/mods/174)

This mod is a replacer plugin for the old PewPew. I have kept the core functionality the same and simply added missing options from game updates.

New Features

    Support for:
        Kantrael Mk X Heavy Laspistol (Traitor's Curse)
        Agripinaa Mk XIV Quickdraw Stub Revolver (Traitor's Curse)
        Godwyn-Branx Mk IV Bolt Pistol (Secrets of the Machine God)
        Crucis Mk XI Double-Barrelled Shotgun (Secrets of the Machine God)
        Krourk Mk IIa/Gorgonum Mk IIIa/Achlys Mk II Ogryn Heavy Stubber (Grim Protocols)
    Looping sounds from Force Greatswords (Grim Protocols)
    Localization
        Updated to use names from Unlocked and Loaded (If you don't like this, I made a mod for that﻿﻿)
        Renamed options to be read from a player's perspective instead of through the code's perspective
        e.g. lasbeam bfg --> Lasbeam: Helbore (Fully Charged)


# Installation
Install like any other mod. Load order doesn't matter.

If you have an existing copy of PewPew, overwrite it with this one. Your settings will not be affected since they're stored elsewhere. I didn't internally rename anything, so they should transfer.

# Known Issues/Quirks
**Why do beam trails stick to the gun even during recoil animations?**

I think that's just how the visual effects are drawn since the original weapons don't have much recoil. Don't know if there's anything I can do about that. If you don't know what I mean, look at what happens if you hipfire a boltpistol using a plasma beam.

**Why don't the trails don't line up with my gun when I move and shoot?**

This is Vanilla Darktide behavior. This effect is most noticeable with trails such as the Shotgun Slug and Plasma Beam. These are slow, single-shot weapons, so you don't normally notice this in gameplay; however, putting these effects on automatic firearms makes it very apparent.

**Why can't I change shotgun trails?**

TL;DR the way shotgun vfx are coded, the trails are not something editable by this mod

PewPew operates by grabbing line_effects from a file that contains all player-related line_effects. In each weapon template (which I don't think is editable since it contains values such as ammo used per shot), the weapon calls a line_effect. This is why when you change 'Autogun Bullet' it applies to a bunch of weapons; they all call autogun_bullet from line_effect. However, shotguns just don't have this. pellet_trail isn't used anywhere in the code besides where it's defined. Shotguns still have regular bullet fx that show up when every gun is shoot, but they lack the line_effect specifically. Could be because of how Darktide handles multiple pellets, but that's just speculation.

**What the hell is Psyker 'Smite" supposed to be? Why are there two Smites?**

Internally, Brain Burst/Rupture is called Smite; the Smite blitz is called Chain Lightning. When it comes to the sound, psyker_smite_fire is supposed to happen during BB and Force Staff primary fire. When it actually plays seems to be iffy, so I left the second one as 'Smite' to differentiate them. This is under investigation. 
