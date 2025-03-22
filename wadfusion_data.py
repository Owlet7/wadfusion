##-----------------------------------------------------------------------------
##
## Copyright 2024-2025 Owlet VII
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see http://www.gnu.org/licenses/
##
##-----------------------------------------------------------------------------
##

##
## This code is derived from WadSmoosh 1.41, which is covered by the following permissions:
##
##------------------------------------------------------------------------------------------
##
## The MIT License (MIT)
## 
## Copyright (c) 2016-2023 JP LeBreton
## 
## Permission is hereby granted, free of charge, to any person obtaining a copy
## of this software and associated documentation files (the "Software"), to deal
## in the Software without restriction, including without limitation the rights
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
## copies of the Software, and to permit persons to whom the Software is
## furnished to do so, subject to the following conditions:
## 
## The above copyright notice and this permission notice shall be included in
## all copies or substantial portions of the Software.
## 
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
## THE SOFTWARE.
##
##------------------------------------------------------------------------------------------
##

# data tables for WadFusion
# every line in this file must be valid Python!

# pre-authored resources to copy
RES_FILES = [
    'iwadinfo.txt', 'mapinfo.txt', 'sndinfo.txt',
    'language.csv', 'language.story.csv', 'endoom',
    'textures.common', 'textures.doom1', 'textures.doom2',
    'textures.masterlevels', 'textures.masterlevelsbonus',
    'textures.tnt', 'textures.plut', 'textures.id1',
    'in_epi1.txt', 'xwinter0.txt', 'xwinter1.txt',
    'animdefs.txt', 'graphics/CONBACK.lmp',
    'graphics/TITLEPIC.lmp', 'graphics/M_DOOM.lmp',
    'graphics/M_HELL.lmp', 'graphics/M_NOREST.lmp',
    'graphics/M_MASTER.lmp', 'graphics/M_MASTR1.lmp',
    'graphics/M_MASTR2.lmp', 'graphics/M_MASTR3.lmp',
    'graphics/M_MASTR4.lmp', 'graphics/M_MASTR5.lmp',
    'graphics/M_MASTR6.lmp', 'graphics/M_TNT.lmp',
    'graphics/M_PLUT.lmp', 'graphics/M_EPI5.lmp',
    'graphics/WILV03B.lmp', 'graphics/WILV07B.lmp',
    'graphics/WILV39.lmp', 'graphics/WILV50.lmp',
    'graphics/WILV51.lmp', 'graphics/WILV52.lmp',
    'graphics/WILV53.lmp', 'graphics/WILV54.lmp',
    'graphics/WILV55.lmp', 'graphics/WILV56.lmp',
    'graphics/WILV57.lmp', 'graphics/WILV58.lmp',
    'graphics/CWILV00.lmp', 'graphics/CWILV32.lmp',
    'graphics/NWILV00.lmp', 'graphics/NWILV01.lmp',
    'graphics/NWILV02.lmp', 'graphics/NWILV03.lmp',
    'graphics/NWILV04.lmp', 'graphics/NWILV05.lmp',
    'graphics/NWILV06.lmp', 'graphics/NWILV07.lmp',
    'graphics/NWILV08.lmp', 'graphics/PWILV01.lmp',
    'graphics/MWILV00.lmp', 'graphics/MWILV01.lmp',
    'graphics/MWILV02.lmp', 'graphics/MWILV03.lmp',
    'graphics/MWILV04.lmp', 'graphics/MWILV05.lmp',
    'graphics/MWILV06.lmp', 'graphics/MWILV07.lmp',
    'graphics/MWILV08.lmp', 'graphics/MWILV09.lmp',
    'graphics/MWILV10.lmp', 'graphics/MWILV11.lmp',
    'graphics/MWILV12.lmp', 'graphics/MWILV13.lmp',
    'graphics/MWILV14.lmp', 'graphics/MWILV15.lmp',
    'graphics/MWILV16.lmp', 'graphics/MWILV17.lmp',
    'graphics/MWILV18.lmp', 'graphics/MWILV19.lmp',
    'graphics/MWILV20.lmp', 'graphics/MWILV21.lmp',
    'graphics/MWILV22.lmp', 'graphics/MWILV23.lmp',
    'graphics/MWILV24.lmp', 'graphics/MWILV25.lmp',
    'graphics/MWILV26.lmp', 'graphics/MWILV27.lmp',
    'graphics/MWILV28.lmp', 'graphics/MWILV29.lmp',
    'graphics/MWILV30.lmp', 'graphics/MWILV31.lmp',
    'graphics/MWILV32.lmp', 'graphics/MWILV33.lmp',
    'graphics/MWILV34.lmp', 'graphics/MWILV35.lmp',
    'graphics/MWILV36.lmp', 'graphics/MWILV37.lmp',
    'graphics/MWILV38.lmp', 'graphics/MWILV39.lmp',
    'graphics/MWILV40.lmp', 'graphics/MWILV41.lmp',
    'graphics/MWILV42.lmp',
    'mapinfo/doom1_levels.txt', 'mapinfo/doom2_levels.txt',
    'mapinfo/master_levels.txt', 'mapinfo/nerve_levels.txt',
    'mapinfo/tnt_levels.txt', 'mapinfo/plutonia_levels.txt',
    'mapinfo/xbox_levels.txt', 'mapinfo/blackroom_levels.txt',
    'mapinfo/sigil_levels.txt', 'mapinfo/sigil2_levels.txt',
    'mapinfo/id1_levels.txt', 'mapinfo/iddm1_levels.txt',
    'mapinfo/clusters.txt', 'mapinfo/intermissions.txt',
    'mapinfo/episodes.txt', 'mapinfo/episodes_rejects.txt',
    'mapinfo/master_levels_rejects.txt',
    'mapinfo/master_levels_flynn.txt',
    'mapinfo/master_levels_anderson.txt',
    'mapinfo/master_levels_kvernmo.txt',
    'menudef.txt', 'menudef.credits', 'cvarinfo.txt', 'zscript.zs',
    'zscript/wf_handler.zs', 'zscript/wf_handler_static.zs',
    'zscript/wf_textswap.zs', 'zscript/wf_textswap_all.zs',
    'zscript/wf_textswap_d2sky.zs', 'zscript/wf_mapfixes.zs',
    'zscript/wf_music_sigil.zs', 'zscript/wf_music_idkfa.zs',
    'zscript/wf_sbar.zs', 'zscript/wf_sbar_alt.zs',
    'wadfused.txt'
]

# list of files we can extract from
WADS = ['doom', 'doom2', 'masterlevels', 'tnt', 'plutonia',
        'sigil', 'sigil_shreds', 'sigil2', 'sigil2_mp3',
        'id1', 'id1-res', 'id24res', 'iddm1', 'extras',
        'doomunity', 'doom2unity', 'tntunity', 'plutoniaunity',
        'doomkex', 'doom2kex', 'tntkex', 'plutoniakex', 'nerve']

# wads to search for and report if found
REPORT_WADS = ['doom', 'sigil', 'sigil_shreds', 'sigil2', 'sigil2_mp3',
               'doom2', 'masterlevels',
               'attack', 'canyon', 'catwalk', 'fistula',
               'combine', 'subspace', 'paradox', 'subterra',
               'garrison', 'blacktwr', 'virgil', 'minos', 'nessus',
               'geryon', 'vesperas', 'manor', 'ttrap', 'teeth',
               'bloodsea', 'mephisto',
               'cpu', 'device_1', 'dmz', 'cdk_fury', 'e_inside',
               'hive', 'twm01', 'mines', 'anomaly', 'farside',
               'trouble', 'dante25', 'achron22', 'udtwid', 'caball',
               'nerve', 'id1', 'id1-res', 'id24res', 'iddm1',
               'tnt', 'plutonia',
               'sewers', 'betray', 'e1m4b', 'e1m8b', 'extras',
               'doomunity', 'doom2unity', 'tntunity', 'plutoniaunity',
               'doomkex', 'doom2kex', 'tntkex', 'plutoniakex']

# lists of lumps common to doom 1+2
COMMON_LUMPS = [
    'data_common', 'flats_common', 'graphics_common', 'patches_common',
    'sounds_common', 'sprites_common'
]

DOOM1_LUMPS = [
    'graphics_doom1', 'music_doom1', 'patches_doom1', 'sounds_doom1',
    # extract PNAMES and TEXTURE1 from both doom.wad and doom2.wad,
    # in case only one is present
    'txdefs_doom1'
]

DOOM2_LUMPS = [
    'flats_doom2', 'graphics_doom2', 'music_doom2', 'patches_doom2',
    'sounds_doom2', 'sprites_doom2', 'txdefs_doom2'
]

ID1_LUMPS = [
    'data_id1', 'flats_id1', 'graphics_id1', 'music_id1', 'patches_id1',
    'sounds_id1', 'sprites_id1'
]

# lists of lumps to extract from each IWAD
WAD_LUMP_LISTS = {
    'doom': COMMON_LUMPS + DOOM1_LUMPS,
    'doom2': COMMON_LUMPS + DOOM2_LUMPS,
    'masterlevels': ['patches_masterlevels', 'graphics_masterlevels'],
    'tnt': ['graphics_tnt', 'music_tnt', 'patches_tnt'],
    'plutonia': ['graphics_plutonia', 'music_plutonia', 'patches_plutonia'],
    'sigil': ['graphics_sigil', 'music_sigil', 'patches_sigil', 'data_sigil'],
    'sigil_shreds': ['music_sigil_shreds'],
    'sigil2': ['graphics_sigil2', 'music_sigil2', 'patches_sigil2', 'data_sigil2', 'flats_sigil2'],
    'sigil2_mp3': ['music_sigil2_shreds'],
    'id1': ID1_LUMPS,
    'id1-res': ['data_id1-res'],
    'id24res': ['graphics_id24res'],
    'iddm1': [],
    # widescreen assets from unity and kex ports
    'doomunity': ['graphics_doom1_unity'],
    'doom2unity': ['graphics_doom2_unity'],
    'tntunity': ['graphics_tnt_unity'],
    'plutoniaunity': ['graphics_plutonia_unity'],
    'doomkex': ['graphics_doom1_unity'],
    'doom2kex': ['graphics_doom2_unity'],
    'tntkex': ['graphics_tnt_kex'],
    'plutoniakex': ['graphics_plutonia_kex'],
    'nerve': [],
    # extras.wad assets from unity and kex ports
    'extras': ['data_extras', 'sounds_extras']
}

# prefixes for filenames of maps extracted from IWADs
WAD_MAP_PREFIXES = {
    'doom': '',
    'doom2': '',
    'tnt': 'TN_',
    'plutonia': 'PL_',
    'nerve': 'NV_',
    # master levels not processed like other wads, bespoke prefix lookup
    'masterlevels': 'ML_',
    'sigil': '',
    'sigil2': '',
    'id1': 'LR_',
    'iddm1': 'DM_'
}

MASTER_LEVELS_ORDER = [
    'attack',
    'canyon',
    'catwalk',
    'fistula',
    'combine',
    'subspace',
    'paradox',
    'subterra',
    'garrison',
    'blacktwr',
    'virgil',
    'minos',
    'nessus',
    'geryon',
    'vesperas',
    'manor',
    'ttrap',
    'teeth',
    'bloodsea',
    'mephisto'
]

MASTER_LEVELS_REJECTS_ORDER = [
    'cpu',
    'device_1',
    'dmz',
    'cdk_fury',
    'e_inside',
    'hive',
    'twm01',
    'mines',
    'anomaly',
    'farside',
    'trouble',
    'dante25',
    'achron22'
]

# texture patches to extract from specific master levels PWADs
MASTER_LEVELS_PATCHES = {
    'combine': ('RSKY1', 'MSKY1'),
    'virgil': ('RSKY1', 'MSKY2'),
    'manor': ('STARS', 'STARS')
}

MASTER_LEVELS_TITAN_PATCHES = {
    'mines': ('TWF', 'WF1', 'WF2', 'WF3', 'WF4', 'WF5', 'WF6', 'WF7', 'WF8'),
    'anomaly': ('BLACK', 'S_DOOM09', 'S_DOOM10', 'S_DOOM11', 'S_DOOM12', 'S_DOOM13', 'S_DOOM14', 'S_DOOM15', 'S_DOOM16'),
    'trouble': ('FIRELV', 'SAVED', 'STARS1', 'STARSAT', 'TROU00', 'TROU01', 'TROU06', 'TROU07', 'TROU13')
}

MASTER_LEVELS_UDTWID_PATCHES = {
    'udtwid': ('SKY4', 'MSKY7')
}

# help the initial source wad reporting find sigil by any of its released names
SIGIL_ALT_FILENAMES = ['sigil_v1_0', 'sigil_v1_1', 'sigil_v1_2', 'sigil_v1_21']
# same for sigil2 - version with MIDI music
SIGIL2_ALT_FILENAMES = ['sigil_ii_v1_0']
# sigil2 version with MP3 music (no sigil_shreds equivalent; MP3 music just an alternate wad)
SIGIL2_MP3_ALT_FILENAMES = ['sigil_ii_mp3_v1_0']

# lump whose presence distinguishes shareware vs registered & Ultimate Doom
REGISTERED_DOOM_ONLY_LUMP = 'SKULA1'

# lump whose presence distinguishes registered vs Ultimate Doom
ULTIMATE_DOOM_ONLY_LUMP = 'M_EPI4'

# lump whose presence distinguishes Unity & KEX vs original nerve.wad
NERVE_UNITY_KEX_ONLY_LUMP = 'INTERPIC'

# lump whose presence distinguishes Unity vs KEX extras.wad
EXTRAS_KEX_ONLY_LUMP = 'WATERMAP'
