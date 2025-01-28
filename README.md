# WadFusion — simple IWAD merge utility

WadFusion merges your provided DOOM, DOOM II, Master Levels, Final DOOM, No Rest for the Living, SIGIL, SIGIL II, and Legacy of Rust data into a single IPK3 file that can be played in [GZDoom](https://zdoom.org/index), with each game as its own entry in the episode list. This makes it very convenient to play all of classic DOOM's official releases without re-launching the game with different settings.

It's fine if you don't have all of the DOOM games, e.g. you have DOOM II but not Final DOOM—WadFusion will package up everything it can find.

If you just bought these games from [GOG](https://www.gog.com/en/game/doom_doom_ii), or [Steam](https://store.steampowered.com/app/2280/), etc., and you aren't familiar with GZDoom and DOOM modding, see the [**Absolute Beginner's Guide**](#absolute-beginners-guide) section below.

### Note: WadFusion requires GZDoom v4.13.0 or newer, it will not work with other engines.

## Usage

Simply copy all of your WADs into the `source_wads` subfolder, then run WadFusion. A log will appear showing progress and any errors that arise.

If you're on Windows, run `wadfusion.exe`.

If you're on macOS or GNU/Linux, run the `wadfusion.py` Python 3 script.

WadFusion will create a new file called `doom_fusion.ipk3`, with all the game content in it. It should be selectable as a game in GZDoom.

In rare cases, you may need to uncheck the `source_wads` folder's read-only status.

## Supported WADs

WadFusion is not a general-purpose tool for merging DOOM WADs; it is for *merging official content* only—it was created out of a desire for a "complete" version of retail DOOM and DOOM II. Please do not ask if WadFusion will support any specific WAD. **This includes any content from the 5th generation console ports.** If you want to add your own content to a custom IPK3, either modify WadFusion's code yourself, or simply edit the IPK3 that WadFusion generates. Please try consulting the [ZDoom Wiki](https://zdoom.org/wiki/Main_Page) first before asking for help. If you've created an addon for WadFusion, feel free to share it with the community on the [Discussions](https://github.com/Owlet7/wadfusion/discussions/categories/show-and-tell) section.

Here is the official list of WADs that WadFusion will recognize:
- DOOM (original registered version of `doom.wad`, containing only episodes 1-3)
- The Ultimate DOOM (retail version of `doom.wad`, containing episodes 1-4)
- DOOM II (`doom2.wad`)
- Master Levels for DOOM II (the original 20 WAD files, or `masterlevels.wad` from the [KEX-based re-release](https://doomwiki.org/wiki/Doom_%2B_Doom_II))
- Master Levels Rejects ([see below](#master-levels-rejects) for a full list of supported WADs)
- Final DOOM (`tnt.wad` and `plutonia.wad`)
- No Rest for the Living (`nerve.wad`)
- SIGIL (`sigil.wad` and its optional music addon `sigil_shreds.wad`)
- SIGIL II (`sigil2.wad` and optionally its MP3 soundtrack version `sigil2_mp3.wad`)
- Legacy of Rust (`id1.wad`, `id1-res.wad`, `id24res.wad`, and `iddm1.wad` from the [KEX-based re-release](https://doomwiki.org/wiki/Doom_%2B_Doom_II))
- `sewers.wad` and `betray.wad` (the [two secret levels](https://classicdoom.com/xboxspec.htm) from the [original Xbox port of DOOM](https://doomwiki.org/wiki/Xbox))
- `e1m8b.wad` and `e1m4b.wad` (John Romero's map remakes, [Tech Gone Bad](https://www.doomworld.com/idgames/levels/doom/Ports/d-f/e1m8b) and [Phobos Mission Control](https://www.doomworld.com/idgames/levels/doom/Ports/d-f/e1m4b))
- `extras.wad` (from the [Unity](https://doomwiki.org/wiki/Doom_Classic_Unity_port) or [KEX-based](https://doomwiki.org/wiki/Doom_%2B_Doom_II) re-releases)

WadFusion requires `id1-res.wad` and `id24res.wad` for Legacy of Rust.

If IWADs from the Unity or KEX-based re-releases are also included (must be named `doomunity.wad`, `doom2unity.wad`, `tntunity.wad`, `plutoniaunity.wad` or `doomkex.wad`, `doom2kex.wad`, `tntkex.wad`, `plutoniakex.wad`), WadFusion will extract widescreen assets from them. These versions can also be used as the main WADs for extraction, but do keep in mind that they are censored.

The versions of `nerve.wad` in these re-releases include a unique intermission screen, but renaming them isn't necessary—WadFusion will recognize them, and they aren't censored the way the IWADs are.

If `extras.wad` from the re-releases is included, WadFusion will extract the official "secret revealed" sound, and some status bar icons that can be used by custom HUDs. If the version from the KEX-based re-release is used, WadFusion will also extract Andrew Hulshult's "IDKFA" covers of the DOOM and DOOM II soundtracks, which can be toggled from the WadFusion options mod menu in GZDoom.

None of the "official add-on" content from the Unity or KEX-based re-releases of DOOM and DOOM II is supported.

For SIGIL and SIGIL II, all the filenames for different releases of those WADs are also recognized; you shouldn't have to rename your original files. If `sigil_shreds.wad` is included, or if both versions of SIGIL II are included, WadFusion will extract both soundtracks, which can be toggled from the WadFusion options mod menu in GZDoom.

[Tech Gone Bad](https://doomwiki.org/wiki/Tech_Gone_Bad) and [Phobos Mission Control](https://doomwiki.org/wiki/Phobos_Mission_Control) are levels that were made as a warm-up exercise for John Romero's cancelled game, Blackroom. If they're included, enabling them in the WadFusion options mod menu in GZDoom will replace E1M8 or E1M4 in the Knee-Deep in the Dead episode.

## Master Levels Rejects

For the Master Levels Rejects to be integrated, *all* of the following WADs must be included:
- Master Levels for DOOM II (the original 20 WAD files, or `masterlevels.wad` from the [KEX-based re-release](https://doomwiki.org/wiki/Doom_%2B_Doom_II))
- DOOM II (`doom2.wad`)
- The Ultimate DOOM (`doom.wad`)
- [The C.P.U.](https://www.doomworld.com/idgames/levels/doom2/a-c/cpu) (`cpu.wad`)
- [Device One](https://www.doomworld.com/idgames/levels/doom2/d-f/device_1) (`device_1.wad`)
- [The D.M.Z.](https://www.doomworld.com/idgames/levels/doom2/d-f/dmz) (`dmz.wad`)
- [The Fury](https://www.doomworld.com/idgames/levels/doom2/a-c/cdk_fury) (`cdk_fury.wad`)
- [The Enemy Inside](https://www.doomworld.com/idgames/levels/doom2/d-f/e_inside) (`e_inside.wad`)
- [The Hive](https://www.doomworld.com/idgames/levels/doom2/g-i/hive) (`hive.wad`)
- [Doom2 Map14 Homage](https://www.doomworld.com/idgames/levels/doom2/s-u/twm01) (`twm01.wad`)
- [Mines of Titan](https://www.doomworld.com/idgames/levels/doom2/m-o/mines2) (`mines.wad`)
- [The Titan Anomaly](https://www.doomworld.com/idgames/levels/doom2/a-c/anomaly) (`anomaly.wad`)
- [The Farside of Titan](https://www.doomworld.com/idgames/levels/doom2/d-f/farside) (`farside.wad`)
- [Trouble on Titan](https://www.doomworld.com/idgames/levels/doom2/s-u/trouble) (`trouble.wad`)
- [Dante's Gate](https://www.doomworld.com/idgames/levels/doom2/d-f/dante25) (`dante25.wad`)
- [Crossing Acheron](https://www.doomworld.com/idgames/levels/doom2/a-c/achron22) (`achron22.wad`)
- [Caball](https://doomshack.org/uploads/caball.zip) (`caball.wad`)
- [Ultimate Doom The Way id Did](https://www.doomworld.com/idgames/levels/doom/s-u/udtwid) (`udtwid.wad`)

## Absolute Beginner's Guide

1. [Download WadFusion](https://github.com/Owlet7/wadfusion/releases/latest/download/wadfusion_win.zip) and extract it to a folder.
2. Find the folder(s) where GOG / Steam installed your game(s).
   - For Steam, this will be something like `C:\Program Files (x86)\Steam\steamapps\common\Ultimate Doom\base`.
3. Copy any files you find with a `.WAD` extension to the `source_wads` subfolder where you extracted WadFusion.
4. Double-click `wadfusion.exe`. A terminal window will pop up, showing which WAD files were found, and which episodes can be extracted. Press Y and then Enter to proceed. The terminal window will show progress as it generates the IPK3.
5. When it finishes, press Enter to close the window. You should now have a file in the WadFusion folder called `doom_fusion.ipk3`.
6. Download the latest [GZDoom development build](https://devbuilds.drdteam.org/gzdoom/) and extract it to a folder.
7. Copy the `doom_fusion.ipk3` file to GZDoom's folder.
8. Launch GZDoom and play!

## Acknowledgements

[WadSmoosh](https://jp.itch.io/wadsmoosh) was originally created by JP LeBreton. WadFusion is based on its [source code](https://heptapod.host/jp-lebreton/wadsmoosh).

WadFusion uses the [Omgifol Python library](https://github.com/devinacker/omgifol) by Fredrik Johansson and Devin Acker.
