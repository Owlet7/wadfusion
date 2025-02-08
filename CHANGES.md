# WadFusion Changelog

## Unreleased Changes
[**Full Changelog**](https://github.com/Owlet7/wadfusion/compare/v1.3.0...HEAD)
- Removed Legacy of Rust weapons code—it is now included in GZDoom.
  - **GZDoom must be updated to version 4.15.0!**

## [WadFusion 1.3.0](https://github.com/Owlet7/wadfusion/releases/tag/v1.3.0) — [29 January 2025](https://github.com/Owlet7/wadfusion/tree/v1.3.0)
[**Full Changelog**](https://github.com/Owlet7/wadfusion/compare/v1.2.1...v1.3.0)
- Added compatibility option to force texture substitutions on all levels.
  - Enabling this option disables the regular texture substitution.
  - This feature was added for compatibility with mods that target Final DOOM,
    DOOM 1, or Legacy of Rust.
  - Each texture substitution can be toggled individually, in case a mod needs
    to replace some of them.
- Added compatibility option to disable WadFusion scripts that handle music
  changing and map transitions.
- Moved all compatibility options to a sub-menu.
- Created an autoload sub-category for DOOM Fusion. If you wish to add files to
  be autoloaded only with DOOM Fusion, they can be added under a section titled
  `[doom.id.wadsmoosh.fusion.Autoload]`.
  - Existing saves need to be moved from the `doom.id.wadsmoosh` subfolder to
    the new `doom.id.wadsmoosh.fusion` subfolder.
- Updated localisations (Polish by @justtoask).
- Corrected a typo in E6M3's level title, again.

## [WadFusion 1.2.1](https://github.com/Owlet7/wadfusion/releases/tag/v1.2.1) — [06 December 2024](https://github.com/Owlet7/wadfusion/tree/v1.2.1)
[**Full Changelog**](https://github.com/Owlet7/wadfusion/compare/v1.2.0...v1.2.1)
- Added Final DOOM map fixes from the id Anthology / GOG / KEX versions.
  - Removed redundant duplicate secrets from tnt.wad MAP10.
  - Added deathmatch spawns to plutonia.wad MAP12 and MAP23.
  - These fixes are only applied to the original version of Final DOOM.
- Removed forced pistol start from THE_EVIL (ML_MAP43).
- Added Polish localisation. Thanks to @justtoask for the translation.
- Updated Russian localisation.
- Corrected a typo in E6M3's level title.
- Moved WidePix readme to the licenses folder.

## [WadFusion 1.2.0](https://github.com/Owlet7/wadfusion/releases/tag/v1.2.0) — [19 October 2024](https://github.com/Owlet7/wadfusion/tree/v1.2.0)
[**Full Changelog**](https://github.com/Owlet7/wadfusion/compare/v1.1.1...v1.2.0)
- Renamed the IPK3 that WadFusion generates to `doom_fusion.ipk3`. Renamed the
  resulting game to "DOOM Fusion".
- Added support for E1M8B and E1M4B, John Romero's levels that were made as a
  warm-up exercise for the cancelled game Blackroom. Enabling them in the
  options will replace the corresponding level in the Knee-Deep in the Dead
  episode. Thanks to @domyoji81 for implementing the feature.
- Fixed Legacy of Rust flame projectiles going through teleporters.
- If included, Andrew Hulshult's IDKFA soundtrack won't be enabled by default
  anymore. Enable it in the WadFusion options if you wish to use it!
- Will no longer attempt extracting widescreen status bars from the Unity
  versions of Final DOOM, as they don't have them. Will only do so with the KEX
  versions.
- Updated ENDOOM screen with Legacy of Rust credits.

## [WadFusion 1.1.1](https://github.com/Owlet7/wadfusion/releases/tag/v1.1.1) — [09 October 2024](https://github.com/Owlet7/wadfusion/tree/v1.1.1)
[**Full Changelog**](https://github.com/Owlet7/wadfusion/compare/v1.1.0...v1.1.1)
- Enabled the "Master Levels texture substitutions" option in WadFusion Options.
- Added SIGIL localisations from the DOOM + DOOM II port.

## [WadFusion 1.1.0](https://github.com/Owlet7/wadfusion/releases/tag/v1.1.0) — [08 October 2024](https://github.com/Owlet7/wadfusion/tree/v1.1.0)
[**Full Changelog**](https://github.com/Owlet7/wadfusion/compare/v1.0.1...v1.1.0)
- Added support for the Master Levels rejects.
  - Christen Klie's rejected levels (device_1.wad, cpu.wad, dmz.wad,
    e_inside.wad, cdk_fury.wad, hive.wad).
  - Tom Mustaine's rejected Doom2 Map14 Homage (twm01.wad).
  - Jim Flynn's Titan series of maps (mines.wad, anomaly.wad, farside.wad,
    trouble.wad).
  - The rest of John Anderson's Inferno series (dante25.wad, achron22.wad).
    Ultimate Doom the Way id Did's E4M8 substitutes the final map (udtwid.wad).
  - The rejected levels from Sverre André Kvernmo's Cabal series (caball.wad).
- Added optional kill count fix — enemies that are revived (e.g. by an
  Arch-Vile, or on Nightmare skill) or summoned (e.g. by the Icon of Sin) won't
  count towards the level's statistics and end of level tally.
- DOOM + DOOM II Update 1 support.
- Added CONBACK graphic.
- Corrected typo in "Mephisto's Maosoleum".
- Added localisations for the Master Levels ending from the KEX port.
- Will now extract widescreen status bar from Unity/KEX versions of Final DOOM.
- Will now check if doom2.wad is present before copying LoR scripts.
- Simplified Xbox map extraction.
- iddm1.wad will no longer count towards the number of extracted episodes, since
  it won't show up in the in-game menu.
- The timer will now start only after the user presses Y to proceed.
- Moved story text to language.story.csv file.
- Updated Omgifol library to version 0.5.1.
- Dropped Python 2 support.
- Updated the Windows executable to Python 3.13.0.

## [WadFusion 1.0.1](https://github.com/Owlet7/wadfusion/releases/tag/v1.0.1) — [30 September 2024](https://github.com/Owlet7/wadfusion/tree/v1.0.1)
[**Full Changelog**](https://github.com/Owlet7/wadfusion/compare/v1.0.0...v1.0.1)
- Enabled Remix soundtrack in TNT Evilution.
- Fixed map names in LoR intermission scripts.
- Improved LoR HUD logic.
- Removed redundant localisation strings.

## [WadFusion 1.0.0](https://github.com/Owlet7/wadfusion/releases/tag/v1.0.0) — [22 September 2024](https://github.com/Owlet7/wadfusion/tree/v1.0.0)
[**Full Changelog**](https://github.com/Owlet7/wadfusion/compare/963b5f47e631494e0b55930ace8f286ccd377574...v1.0.0)
- Now that WadSmoosh has ended its development, forked and rebranded the project
  under a new name — WadFusion.
- Updated the project's license to the GNU GPLv3 or later.
- Added support for Legacy of Rust.
  - Can extract from id1.wad and iddm1.wad. id1.wad requires also having
    id1-res.wad and id24res.wad.
  - Ported the new Incinerator and Calamity Blade weapons to ZScript versions
    that don't replace the Plasma Rifle and BFG 9000.
  - New status bar with support for Fuel ammo. Can be toggled to always display
    it, or only in Legacy of Rust episodes.
  - Implemented support for Andrew Hulshult's alternate "IDKFA" soundtrack,
    which can be extracted if the KEX extras.wad is present, and can be toggled
    from the options menu.
- Added support for extracting masterlevels.wad from the KEX release.
  - Added intermission text for entering the teeth.wad secret level.
  - Replaced the sky texture in bloodsea.wad and mephisto.wad to RSKY3, to match
    the Hell setting and the rest of the Cabal campaign.
  - Changed the D_RUNNIN music used in these Master Levels to the tracks chosen
    in the KEX version — canyon.wad, catwalk.wad, fistula.wad, combine.wad,
    subspace.wad, paradox.wad, subterra.wad, garrison.wad, manor.wad, ttrap.wad.
    If Doom 1 isn't present, WadFusion will duplicate D_RUNNIN in place of its
    used tracks.
  - Reverted the music used in mephisto.wad back to D_SHAWN.
  - Removed support for custom level orders.
- Sigil's MP3 soundtrack now gets extracted alongside the MIDI soundtrack. Its
  soundtrack now gets loaded by an EventHandler, rather than being defined in
  MAPINFO. Sigil and Sigil II can have their soundtracks toggled separately from
  the options menu. Sigil II's MP3 version is now only used for music
  extraction, all the other data gets extracted from the MIDI version only.
- Made the entrances to the Xbox secret levels toggleable through the use of a
  LevelPostProcessor script, instead of modifying the WADs.
- Extended GZDoom's fixes for MAP33 to the other versions of the map.
- Removed Ultra-Violence+ skill. It was redundant, since GZDoom already has a
  gameplay option that accomplishes the same thing.
- Fixed "VM execution aborted: tried to read from address zero" error related to
  Sigil II's Spiderdemon buff.
- Resolved all remaining texture conflicts between Doom, Doom II, and Final
  Doom.
- Corrected minor errors in several texture definitions.
- Removed redundant AASTINKY and AASHITTY texture definitions which overrode the
  null texture definitions. This caused some linedefs to become visible when
  they weren't intended to be.
- Renamed TNT and Master Levels sky textures for better consistency.
- Changed the sky texture in E1M10 to SKY3, which was the originally intended
  texture.
- Reverted the sky texture in NV_MAP04 back to RSKY1. The use of RSKY3 for that
  map in the Unity / KEX versions is almost certainly erroneous.
- Replaced the TITLEPIC with an ultrawide one based on WidePix, to fit in with
  GZDoom's widescreen support.
- When using the Unity / KEX version WADs for widescreen asset extraction, they
  now have to be named doomunity.wad / doomkex.wad,
  doom2unity.wad / doom2kex.wad, etc. instead of doomu.wad, doom2u.wad, etc.
  This change was made because these are the file names that GZDoom uses, and to
  avoid confusion with The Ultimate Doom.
- WadFusion will now always attempt to extract NRFTL's INTERPIC when nerve.wad
  is included.
- Added titlepatches for levels that didn't have them, or had ones that used
  wrong fonts (e.g. NRFTL, Sigil II).
- Refactored the language lump into a CSV file, for better localisation support.
- Added Russian localisation.
- Redid credits menus with localisation support. Thanks to Shockwave_S08 for
  help with Legacy of Rust credits implementation and suggestions.
- Added credit to David Blanshine for E1M10 co-authorship.
- Added credit to Bob Mustaine for paradox.wad co-authorship.
- Renamed John "Dr. Sleep" Anderson to just John Anderson, as that's how he was
  credited in the original game.
- Renamed Jim Mentzer to David J. Hill. Mentzer is Hill's alias, according to
  the Doom Wiki.
- Changed all instances of "Doom" to "DOOM", "Sigil" to "SIGIL", etc.
- Reverted changes to the "Which episode?" menu. Trying to fit everything on one
  screen with the regular big Doom font is a losing battle.
- Renamed "The Master Levels" to "Master Levels" in the "Which episode?" menu.
- Added an option to swap health and armour in the fullscreen HUD.
- Added a horizontal offset option for the fullscreen HUD, for ultrawide
  displays.
- The status bar icons in extras.wad will now be imported for custom status bars
  to use.
- WadFusion will now remove temp files after it finishes executing its script.
- Increased ZScript version to 4.13.0, to force bug fixes related to Legacy of
  Rust. This version of GZDoom is currently only available as development
  builds.
- Known bug: The drag on the lava floor in LR_MAP08 isn't strong enough.

<details>
<summary>WadSmoosh versions</summary>

## WadSmoosh 1.41 — 31 December 2023
- fixed SW*BRN1 -> SW*BRWN1 doom1 switch texture replacement

## WadSmoosh 1.4 — 26 December 2023
- Sigil II support, thanks to jdbrown
- Force graphical (larger) names in episode list
- Properly handle Ultimate Doom texture substitutions

## WadSmoosh 1.31 — 16 August 2023
- Add the "Ultra-Violence+" skill level from the Unity ports, which adds Fast
  Monsters and the multiplayer-only weapon spawns to Ultra Violence difficulty
  for additional challenge.
- Plutonia credits update thanks to Shockwave_S08: Dario and Milo Casali are
  credited individually for the levels they were each the primary author of,
  since more detailed credit information has come to light.

## WadSmoosh 1.3 — 03 November 2020
- Recognize the Unity-based official Doom port IWADs same as the BFG Edition
  IWADs. The recently released GZDoom 4.5 properly supports the widescreen title
  and intermission screen assets added to these IWADs back in September.
  - Please note that running any earlier version of GZDoom with a
    doom_complete.pk3 generated with these widescreen assets may produce visual
    errors.
  - Also note that GZDoom 4.5 includes its own optional pack of widescreen
    assets by Nash Muhandes in a file called game_widescreen_gfx.pk3, intended
    for free use without needing to own the Unity WADs. You don't need to do
    anything with WadSmoosh to use these new assets, just include that optional
    pk3 as you would any mod when loading GZDoom.
- Add support for smooshing the Unity IWADs as "addons", ripping only the
  widescreen assets but keeping everything else from the original IWADs (NIN
  secret in E4M1, etc). To use this feature rename your Unity port doom.wad and
  doom2.wad to doomu.wad and doom2u.wad, respectively, when you place them in
  source_wads/ alongside your original doom.wad and doom2.wad. If you only have
  the Unity IWADs, leave them with their original names and WadSmoosh will treat
  them as Ultimate Doom and Doom II, respectively.
  - Add same support for the widescreen assets in nerve.wad, tnt.wad, and
    plutonia.wad. Rename these to nerveu.wad, tntu.wad, and plutoniau.wad
    respectively.
- New widescreen title screen graphic.
- Add new par times for E1M8, E2M8, and E3M8 from the recent Unity port update.
- Bump ZScript version number required to 4.1.0 to reflect the built-in
  functions used. This requirement has been the case since the WadSmoosh 1.2
  release, this change just makes it give a more comprehensible error message.

## WadSmoosh 1.26 — 13 September 2020
- Fix issue caused by 1.25's "don't extract PNAMES and TEXTUREx lumps" change
  that broke MAP07 and Plutonia MAP30. After some investigation and technical
  advice, reverting to the previous behavior of extracting PNAMES and TEXTURE1.

## WadSmoosh 1.25 — 01 September 2020
- Ultimate Doom + SIGIL should use FLOOR7_2 as the screen border graphic, all
  other episodes should use GRNROCK.
- Fix REQUIEM.WAD SKY3 not appearing correctly; some subtle adjustments to
  Doom 2 sky detection logic.
- No longer necessary to extract TEXTURE1 and PNAMES lumps from doom2.wad.

## WadSmoosh 1.24 — 06 August 2020
- Fixed texture replacements in Final Doom not working after level transitions.
  (Case sensitivity issue with MapNames)
- Added clarification to readme about customizing Master Levels order.
- Xbox port secret levels now contribute to level count given at smoosh
  completion.

## WadSmoosh 1.23 — 04 August 2020
- Fixed incorrect finale music for TNT and Plutonia.

## WadSmoosh 1.22 — 01 August 2020
- No Rest For The Living maps 04-08 should use hell sky (RSKY3) as per recent
  change to the official Unity port.

## WadSmoosh 1.21 — 25 July 2020
- Safely clean up anything in pk3/ working subdirectory from any previous runs.
  Only remove files that WadSmoosh has placed there. This prevents any issues
  that could result from a previous run's files getting included into a new PK3.
- Added a note in the WadSmoosh Options menu about each compat option requiring
  a level restart.
- Include a new custom GENMIDI lump that replicates Doom II's OPL instrument
  sounds but better preserves the Doom1-specific guitar sound (specifically,
  General MIDI instrument #31, "Distortion Guitar") heard in tracks such as
  D_E1M1 and D_E1M8. If you are one of the very few people who feels strongly
  about this, simply delete the file GENMIDI.lmp from the "res/" subdirectory
  and re-run WadSmoosh, and you'll get the previous behavior.

## WadSmoosh 1.2 — 17 July 2020
- Fixed various issues with the ways certain user WADs defined custom skies for
  Doom 2 levels. New, simpler ZScript-based detection and substitution logic
  replaces the old ACS-based method.
- Properly detect SIGIL under any of its released names, eg SIGIL_V1_0,
  SIGIL_V1_1, SIGIL_V1_2, SIGIL_V1_21. Creates a copy in source_wads/ with the
  expected name of "sigil.wad".
- Fixed episode listing appearing in the smaller GZDoom built-in font instead of
  main Doom menu font. Thanks TwelveEyes.
- When playing a map with a Doom 1 style ExMx name, swap in alternate versions
  of BRNPOIS and NUKEPOIS that are the correct sizes, in case any user made
  levels depend on that difference.
- Changed the included graphics (eg menu title, episode names) from 32-bit to
  8-bit so they work correctly with palette mods.
- Windows EXE uses latest 32-bit Python 3.7.8.

## WadSmoosh 1.16 — 14 March 2020
- TNT Evilution: Fixed a linecode typo for Ty Halderman's name.
- Added SIGIL 1.2 par times.

## WadSmoosh 1.15 — 17 February 2020
- This release fixes a switch texture error in SW1STARG, used once each in TNT
  MAP15 and Plutonia MAP04. Before this fix those switches functioned, they just
  looked out of place if you knew what the vanilla IWADs looked like. 

## WadSmoosh 1.14 — 05 January 2020
- Correctly extract the new exit graphic in SIGIL 1.2
- Replaced the custom-made map author lumps with text data that uses GZDoom's
  semi-recently-added author name display functionality.

## WadSmoosh 1.13 — 04 August 2019
- Fixed MAP02 par time

## WadSmoosh 1.12 — 14 July 2019
- Fixed Plutonia's animated waterfall textures sometimes not animating.

## WadSmoosh 1.11 — 02 July 2019
- Master Levels: fixed incorrect text and music at end of episode (cluster
  number collision with Sigil)
- Master Levels: fixed skies for fistula and blacktwr
- Xbox secret levels: par times for sewers (2:30) and betray (2:00)
- Xbox secret levels: sewers exits to e1m2 instead of e1m1

## WadSmoosh 1.1 — 01 June 2019
- Full SIGIL support! Provide your own SIGIL.wad and (optionally)
  SIGIL_SHREDS.wad and it will be included in the episode list. Please note
  that the MP3 music in SIGIL_SHREDS.wad will add about 160MB to your PK3 IWAD.
- Fixed Python 2 support
- Added credits for SIGIL and omgifol python library
- Updated ENDOOM lump to mention Sigil
- On successful completion, log some information about the PK3 and wait
  for an Enter keypress before quitting (and thus closing the window, if
  you're not running from the command line).

## WadSmoosh 1.0 — 19 May 2019
- builds now have version numbers, let's call this 1.0
- added Theresa Chasar co-credit for E4M5, ATTACK.WAD and CANYON.WAD
- added map credit name lumps for Betray and Sewers (Xbox secret levels)
- full menu-based credits for all supported games thanks to Shockwave_S08
- small file size optimizations for PNG images
- better terminal output: announce wads found, episodes that will be in PK3,
  prompt for Y before continuing

## WadSmoosh — 07 May 2019
- Fixed Master Levels MAP21 (Bad Dream) credit image not appearing.
- Used PNGcrush to reduce size (25kb) of included graphic lumps.

## WadSmoosh — 05 May 2019
- Windows exe now uses Python 3.7.3
- "Xaser ordering" for Master Levels is now the default
- Small change to work a bit better with GZDoom4's recent localization efforts
- Map credit images for intermission screen

## WadSmoosh — 11 May 2018
- separate Final Doom intermission music

## WadSmoosh — 29 April 2018
- Fixed missing par times for Thy Flesh Consumed
- Don't show par times for E1M10 and MAP33
- Fixed incorrect music for E1M10
- If user provides BFG Edition Doom2.wad, use the level names from that
  ("IDFKA", "Keen") instead of the original names

## WadSmoosh Initial Release — 11 August 2016
</details>
