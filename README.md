# WadFusion - simple IWAD merge utility

WadFusion merges your provided DOOM, DOOM II, Master Levels, Final DOOM, No Rest for the Living, SIGIL, SIGIL II, and Legacy of Rust data into a single IWAD file that can be played in GZDoom, with each game as its own entry in the episode list. This makes it very convenient to play all of classic DOOM's official releases without relaunching the game with different settings.

It's fine if you don't have all of the DOOM games, eg you have DOOM II but not Final DOOM - WadFusion will package up everything it can find.

If you're not a DOOM expert and just bought these games off [Steam](http://store.steampowered.com/sub/18397/) etc, see the **Absolute Beginner's Guide** section below.

## Usage

Simply copy all your WADs into the `source_wads/` subfolder, then run WadFusion. A log will appear showing progress and any errors that arise.

If you're in Windows, click `wadfusion.exe`.

If you're in macOS or Linux, run the `wadfusion.sh` shell script - Python 2 and 3 are both supported now.

WadFusion will create a new file called `doom_complete.pk3` with all the game content in it. GZDoom 2.4 and later will recognize the `doom_complete.pk3` file as a valid IWAD without any name change needed.

In rare cases, you may need to uncheck the `source_wads/` folder's read-only status.

Advanced users can edit `wadfusion_data.py` to customize how and what WadFusion extracts. This file is Python code, read by the main program at runtime, so no recompile is required. You can also customize the ordering of the Master Levels by running WadFusion from the command line with a text file defining the ordering as an extra parameter. The ["Xaser ordering"](https://forum.zdoom.org/viewtopic.php?p=634600#p634600) is the default, but `masterlevels_order.txt` provides the mostly-alphabetical "PSN ordering", and more info on this customization option is included in comments at the top of that file. This is the only configuration option that WadFusion supports, and in general I'm opposed to adding more such options without turning WadFusion into a full-on GUI program.

## Supported WADs

WadFusion is not a general-purpose tool for merging DOOM WADs; it is for *merging retail content* only - it was created out of a desire for a "complete" retail version of DOOM and DOOM II, and only exists as a program because the IWAD file that it generates cannot be distributed legally. Please do not ask if WadFusion will support any specific WAD. If you want to add your own content to a custom IWAD, please either modify [WadFusion's source code](https://github.com/Owlet7/wadfusion) yourself, or simply edit the `doom_complete.pk3` file WadFusion generated on your computer by opening it in a ZIP archive management program. Please do not ask me for support when doing either.

Here is the official list of WADs that WadFusion will recognize:
- The Ultimate DOOM (`doom.wad`)
- DOOM (original registered version of `doom.wad`, containing only episodes 1-3)
- DOOM II (`doom2.wad`)
- Master Levels for DOOM II (the original 20 WAD files, or `masterlevels.wad` from the KEX-based re-release DOOM + DOOM II)
- Final DOOM (`tnt.wad` and `plutonia.wad`)
- No Rest for the Living (`nerve.wad`)
- SIGIL (`sigil.wad` and its optional music addon `sigil_shreds.wad`)
- SIGIL II (`sigil2.wad` and optionally its MP3 soundtrack version `sigil2_mp3.wad`)
- Legacy of Rust (`id1.wad`, `id1-res.wad`, `id24res.wad`, and `iddm1.wad` from the KEX-based re-release DOOM + DOOM II)
- `sewers.wad` and `betray.wad` (the [two secret levels](https://classicdoom.com/xboxspec.htm) from the [original Xbox port of DOOM](https://doomwiki.org/wiki/Xbox))
- `extras.wad` (from the [Unity](https://doomwiki.org/wiki/Doom_Classic_Unity_port) or [KEX-based](https://doomwiki.org/wiki/Doom_%2B_Doom_II) re-releases)

WadFusion requires `id1-res.wad` and `id24res.wad` for Legacy of Rust.

If WADs from the Unity or KEX-based re-releases are also included (must be named `doomunity.wad`, `doom2unity.wad`, `tntunity.wad`, `plutoniaunity.wad` or `doomkex.wad`, `doom2kex.wad`, `tntkex.wad`, `plutoniakex.wad`), WadFusion will extract widescreen assets from them. The versions of `nerve.wad` in these releases include a unique intermission screen. These versions can also be used as the main WADs for extraction, but do keep in mind that they are censored.

If `extras.wad` from the Unity or KEX-based re-releases is included, WadFusion will extract the official "secret revealed" sound, and some status bar icons that can be used by custom HUDs. If the version from the KEX-based re-release is used, WadFusion will also create a new file called `hulshult_ogg.pk3`, containing Andrew Hulshult's covers of the DOOM and DOOM II soundtracks.

None of the "official add-on" content from the Unity or KEX-based re-releases of DOOM and DOOM II is supported.

For Sigil and Sigil II, all the filenames for different releases of those WADs are also recognized; you shouldn't have to rename your original files. If `sigil_shreds.wad` is included, or if both versions of Sigil II are included, WadFusion will extract both soundtracks, which can be toggled from the WadFusion options mod menu in GZDoom.

## Absolute Beginner's Guide

1. [Download WadFusion](https://github.com/Owlet7/wadfusion/releases/latest/download/wadfusion_win.zip) and extract it to a folder.
2. Find the folder(s) where Steam/GoG installed your game(s). For Steam, this will be something like `<Steam folder>\SteamApps\Common\<game name>\base`.
3. Copy any files you find with a `.WAD` extension to the `source_wads/` subfolder where you extracted WadFusion.
4. Double-click `wadfusion.exe`. A console window will pop up to show progress.
5. When it closes, you should have a file in the WadFusion folder called `doom_complete.pk3`.
6. Download [GZDoom](http://gzdoom.drdteam.org) and extract it to a folder.
7. Copy the `doom_complete.pk3` file to GZDoom's folder.
8. Launch GZDoom and play!

If you have any issues, the [How_to_download_and_run_Doom](http://doomwiki.org/wiki/How_to_download_and_run_Doom) page on the [Doom wiki](http://doomwiki.org) might be helpful.

## Acknowledgements
[WadSmoosh](https://jp.itch.io/wadsmoosh) was originally created by JP LeBreton. WadFusion is based on its [source code](https://heptapod.host/jp-lebreton/wadsmoosh).
