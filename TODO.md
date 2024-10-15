# WadFusion TODO

## [Group episodes into "Which game?" and "Which campaign?" menus](https://github.com/Owlet7/wadfusion/issues/6)
[Planned menu structure](https://github.com/user-attachments/assets/7b7a4fdc-a4af-42fa-a612-817c53c126e4)

## Story screens

### Episode intros
- Draw the episode's `TITLEPIC` and play its intro music when starting a new game (should be skippable)
  - DOOM (unique `TITLEPIC` and `D_INTRO`)
  - The Ultimate DOOM (unique `TITLEPIC`, DOOM music)
  - DOOM II (unique `TITLEPIC` and `D_DM2TTL`)
  - Master Levels (unique `TITLEPIC` in KEX port, duplicate DOOM II's otherwise, DOOM II music)
    - Use said `TITLEPIC` for the Rejects episode intro backgrounds as well
    - Draw the Rejects episode graphic (e.g. "John Anderson's INFERNO")
  - TNT: Evilution (unique `TITLEPIC` and `D_INTRO` (`T_DM2TTL`) )
  - The Plutonia Experiment (unique `TITLEPIC`, DOOM II music (`P_DM2TTL`)
  - No Rest for the Living (unique `TITLEPIC` in Unity/KEX port, duplicate DOOM II's otherwise, DOOM II music)
  - SIGIL (unique `TITLEPIC` and `D_INTRO`)
  - SIGIL II (unique `TITLEPIC` and `D_INTRO`)
  - Legacy of Rust (unique `TITLEPIC` and `D_DM2TTL`)
- Extract widescreen versions from the Unity/KEX ports
- Include support for WidePix

### Intro intermissions
Show introduction story text after the `TITLEPIC` intros (should be possible to turn off in options)
- DOOM (taken from the original manual)
- DOOM II (taken from the original manual)
- Master Levels (and level intermissions) for the Rejects versions (taken from their original readme files)
  - Connect Rejects versions of the Master Levels episodes
- TNT: Evilution (taken from the original manual)
- The Plutonia Experiment (taken from the original manual)
- No Rest for the Living ([taken from Official Xbox Magazine](https://web.archive.org/web/20101126074132/http://www.oxmonline.com/article/previews/a-f/doom-ii))
  - "THE STORY CONTINUES… Back on Earth, after Hell’s forces have (seemingly) been vanquished..."
- SIGIL (taken from its readme file)
- SIGIL II (taken from its readme file)
- Legacy of Rust (taken from DOOM + DOOM II’s main menu)

### Ending intermissions
- Use original Shareware / Registered `CREDIT` graphic at the end of Knee-Deep in the Dead
- Extract and use The Ultimate DOOM's `CREDIT` graphic at the end of Thy Flesh Consumed
- Use SIGIL and SIGIL II's `CREDIT` at the end of their episodes
- Modify ending intermissions to return to the main menu
- Add Master Levels PSX end text to the Rejects version

## Bugs
- The drag on the lava floor in LR_MAP08 isn't strong enough
- Stop menu music from looping
  - Add unique looping TitleMusic?

## Feature creep territory
- Level select menu
  - Hide secret levels until they are discovered
  - Progression tracker
  - Per-skill stats tracker
  - Pistol start tracker
  - Fast monsters tracker
  - Use the game's `M_DOOM` graphic in the level select menu?
    - DOOM
	- DOOM II
	- TNT: Evilution
	- The Plutonia Experiment
	- Legacy of Rust
	- Master Levels (KEX version, duplicate DOOM II's otherwise)
	- No Rest for the Living (KEX version, duplicate DOOM II's otherwise)
	- SIGIL (KEX version, duplicate DOOM's otherwise)
	- SIGIL II (make one)
	- The Ultimate DOOM (make one)
- Rename difficulty levels for Master Levels - Cabal episode
  - Hey, not too rough -> Hurt me plenty
  - Hurt me plenty -> Ultra-violence
  - Ultra-violence -> Total carnage

## [Localisation](https://github.com/Owlet7/wadfusion/issues/13)
<details>
<summary>All languages supported by GZDoom</summary>

- [ ] Czech
- [ ] Danish
- [ ] German
- [ ] Spanish Castilian
- [ ] Spanish Latin American
- [ ] Esperanto (why is this a thing?)
- [ ] Finnish
- [ ] French
- [ ] Hungarian
- [ ] Italian
- [ ] Japanese
- [ ] Korean
- [ ] Dutch
- [ ] Norwegian
- [ ] Polish
- [ ] Portuguese
- [ ] Portuguese Brazilian
- [ ] Romanian
- [x] Russian
- [ ] Serbian
- [ ] Turkish

</details>

Additionally, the KEX port has Chinese language strings, but GZDoom doesn't have support for Chinese.
