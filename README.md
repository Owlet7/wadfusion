# WadFusion — simple IWAD merge utility

WadFusion merges your provided DOOM, DOOM II, Master Levels, Final DOOM, No Rest for the Living, SIGIL, SIGIL II, and Legacy of Rust data into a single IPK3 file that can be played in GZDoom, with each game as its own entry in the episode list. This makes it very convenient to play all of classic DOOM's official releases without re-launching the game with different settings.

It's fine if you don't have all of the DOOM games, e.g. you have DOOM II but not Final DOOM — WadFusion will package up everything it can find.

If you're not a DOOM expert and just bought these games from [GOG](https://www.gog.com/en/game/doom_doom_ii), or [Steam](https://store.steampowered.com/app/2280/), etc., see the **Absolute Beginner's Guide** section below.

## Usage

Simply copy all of your WADs into the `source_wads` subfolder, then run WadFusion. A log will appear showing progress and any errors that arise.

If you're on Windows, click `wadfusion.exe`.

If you're on macOS or GNU/Linux, run the `wadfusion.sh` shell script — Python 2 and 3 are both supported now.

WadFusion will create a new file called `doom_complete.pk3`, with all the game content in it. GZDoom 2.4 and later will recognize the `doom_complete.pk3` file as a valid IPK3 without any name change needed.

In rare cases, you may need to uncheck the `source_wads` folder's read-only status.

## Supported WADs

WadFusion is not a general-purpose tool for merging DOOM WADs; it is for *merging official content* only — it was created out of a desire for a "complete" version of retail DOOM and DOOM II. Please do not ask if WadFusion will support any specific WAD. If you want to add your own content to a custom IWAD, please either modify [WadFusion's source code](https://github.com/Owlet7/wadfusion) yourself, or simply edit the `doom_complete.pk3` file that WadFusion generated. Please do not ask us for support when doing either, try consulting the [ZDoom Wiki](https://zdoom.org/wiki/Main_Page) instead.

Here is the official list of WADs that WadFusion will recognize:
- DOOM (original registered version of `doom.wad`, containing only episodes 1-3)
- The Ultimate DOOM (retail version of `doom.wad`, containing episodes 1-4)
- DOOM II (`doom2.wad`)
- Master Levels for DOOM II (the original 20 WAD files, or `masterlevels.wad` from the [KEX-based re-release](https://doomwiki.org/wiki/Doom_%2B_Doom_II))
- Final DOOM (`tnt.wad` and `plutonia.wad`)
- No Rest for the Living (`nerve.wad`)
- SIGIL (`sigil.wad` and its optional music addon `sigil_shreds.wad`)
- SIGIL II (`sigil2.wad` and optionally its MP3 soundtrack version `sigil2_mp3.wad`)
- Legacy of Rust (`id1.wad`, `id1-res.wad`, `id24res.wad`, and `iddm1.wad` from the [KEX-based re-release](https://doomwiki.org/wiki/Doom_%2B_Doom_II))
- `sewers.wad` and `betray.wad` (the [two secret levels](https://classicdoom.com/xboxspec.htm) from the [original Xbox port of DOOM](https://doomwiki.org/wiki/Xbox))
- `extras.wad` (from the [Unity](https://doomwiki.org/wiki/Doom_Classic_Unity_port) or [KEX-based](https://doomwiki.org/wiki/Doom_%2B_Doom_II) re-releases)

WadFusion requires `id1-res.wad` and `id24res.wad` for Legacy of Rust.

If WADs from the Unity or KEX-based re-releases are also included (must be named `doomunity.wad`, `doom2unity.wad`, `tntunity.wad`, `plutoniaunity.wad` or `doomkex.wad`, `doom2kex.wad`, `tntkex.wad`, `plutoniakex.wad`), WadFusion will extract widescreen assets from them. The versions of `nerve.wad` in these releases include a unique intermission screen. These versions can also be used as the main WADs for extraction, but do keep in mind that they are censored.

If `extras.wad` from the Unity or KEX-based re-releases is included, WadFusion will extract the official "secret revealed" sound, and some status bar icons that can be used by custom HUDs. If the version from the KEX-based re-release is used, WadFusion will also extract Andrew Hulshult's "IDKFA" covers of the DOOM and DOOM II soundtracks, which can be toggled from the WadFusion options mod menu in GZDoom.

None of the "official add-on" content from the Unity or KEX-based re-releases of DOOM and DOOM II is supported.

For SIGIL and SIGIL II, all the filenames for different releases of those WADs are also recognized; you shouldn't have to rename your original files. If `sigil_shreds.wad` is included, or if both versions of SIGIL II are included, WadFusion will extract both soundtracks, which can be toggled from the WadFusion options mod menu in GZDoom.

## Absolute Beginner's Guide

1. [Download WadFusion](https://github.com/Owlet7/wadfusion/releases/latest/download/wadfusion_win.zip) and extract it to a folder.
2. Find the folder(s) where GOG / Steam installed your game(s). For Steam, this will be something like `C:\Program Files (x86)\Steam\steamapps\common\Ultimate Doom\base`.
3. Copy any files you find with a `.WAD` extension to the `source_wads` subfolder where you extracted WadFusion.
4. Double-click `wadfusion.exe`. A terminal window will pop up, showing which WAD files were found, and which episodes can be extracted. Press Y and then Enter to proceed. The terminal window will show progress as it generates the IPK3.
5. When it finishes, press Enter to close the window. You should now have a file in the WadFusion folder called `doom_complete.pk3`.
6. Download [GZDoom](https://zdoom.org/downloads) and extract it to a folder.
7. Copy the `doom_complete.pk3` file to GZDoom's folder.
8. Launch GZDoom and play!

If you have any issues, the [How_to_download_and_run_Doom](https://doomwiki.org/wiki/How_to_download_and_run_Doom) page on the [Doom Wiki](https://doomwiki.org) might be helpful.

## Acknowledgements

[WadSmoosh](https://jp.itch.io/wadsmoosh) was originally created by JP LeBreton. WadFusion is based on its [source code](https://heptapod.host/jp-lebreton/wadsmoosh).
