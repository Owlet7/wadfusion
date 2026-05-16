##-----------------------------------------------------------------------------
##
## Copyright 2024-2026 Owlet VII
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

import platform, os, sys, time, fnmatch, argparse
from shutil import copyfile, rmtree
from zipfile import ZipFile, ZIP_DEFLATED, ZIP_STORED
from os import path

import omg

VERSION = '1.6.0-dev'

# abspath is used for the sake of the Windows executable
DATA_DIR = path.abspath(path.join(path.dirname(__file__), 'data')) + '/'
RES_DIR = path.abspath(path.join(path.dirname(__file__), 'res')) + '/'
SRC_WAD_DIR = ['source_wads/']
DEST_DIR = 'temp/'
DEST_DIR_MUS = DEST_DIR + 'music/'
DEST_DIR_GRAPHICS = DEST_DIR + 'graphics/'
DEST_FILENAME = 'doom_fusion.ipk3'
LOG_FILENAME = 'wadfusion.log'

# forward-declare all the stuff in declare_data() for clarity
RES_FILES = []
WADS = []
REPORT_WADS = []
COMMON_LUMPS = []
DOOM1_LUMPS = []
DOOM2_LUMPS = []
ID1_LUMPS = []
WAD_LUMP_LISTS = {}
WAD_MAP_PREFIXES = {}
MASTER_LEVELS_ORDER = []
MASTER_LEVELS_REJECTS_ORDER = []
MASTER_LEVELS_PATCHES = {}
MASTER_LEVELS_TITAN_PATCHES = {}
MASTER_LEVELS_UDTWID_PATCHES = {}
REGISTERED_DOOM_ONLY_LUMP = ''
ULTIMATE_DOOM_ONLY_LUMP = ''
NERVE_UNITY_KEX_ONLY_LUMP = ''
PWAD_KEX_ONLY_LUMP = ''
EXTRAS_KEX_ONLY_LUMP = ''

SIGIL_FILENAMES = []
SIGIL_MP3_FILENAMES = []
SIGIL2_FILENAMES = []
SIGIL2_MP3_FILENAMES = []
SIGIL_WAD = ''
SIGIL_MP3_WAD = ''
SIGIL2_WAD = ''
SIGIL2_MP3_WAD = ''

logfile = None

# track # of maps extracted
num_maps = 0
num_eps = 0
num_errors = 0
src_wad_dirs_errors = 0

parser = argparse.ArgumentParser()
parser.add_argument('--version', action='version', version='WadFusion v%s' % VERSION)
parser.add_argument('-v', '--verbose', help='Print out all the logged information', action='store_true')
parser.add_argument('-w', '--wads', help='Search the specified directory path for WADs. Can be used multiple times', metavar='PATH', action='append')
parser.add_argument('-p', '--patch', help='Patch an existing IPK3 without extracting WADs', action='store_true')
parser.add_argument('-d', '--deflate', help='Use DEFLATE compression when generating the IPK3', action='store_true')
parser.add_argument('-e', '--extract-only', help='Skip copying pre-authored lumps and only extract WADs (for developers)', action='store_true')
args = parser.parse_args()

# data tables
def declare_data():
    global RES_FILES, WADS, REPORT_WADS, COMMON_LUMPS, DOOM1_LUMPS, DOOM2_LUMPS, ID1_LUMPS, \
           WAD_LUMP_LISTS, WAD_MAP_PREFIXES, MASTER_LEVELS_ORDER, \
           MASTER_LEVELS_REJECTS_ORDER, MASTER_LEVELS_PATCHES, MASTER_LEVELS_TITAN_PATCHES, \
           MASTER_LEVELS_UDTWID_PATCHES, REGISTERED_DOOM_ONLY_LUMP, \
           ULTIMATE_DOOM_ONLY_LUMP, NERVE_UNITY_KEX_ONLY_LUMP, PWAD_KEX_ONLY_LUMP, \
           EXTRAS_KEX_ONLY_LUMP
    
    # pre-authored resources to copy
    RES_FILES = [
        'iwadinfo.txt', 'mapinfo.txt', 'zscript.zs',
        'cvarinfo.txt', 'menudef.txt', 'menudef.credits',
        'language.menus.csv', 'language.credits.csv',
        'language.levels.csv', 'language.story.csv',
        'textures.txt', 'animdefs.txt', 'sndinfo.txt',
        'in_epi1.txt', 'xwinter0.txt', 'xwinter1.txt',
        'graphics/STAMMO24.lmp', 'graphics/STARMS24.lmp',
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
        'graphics/DWILV00.lmp', 'graphics/DWILV01.lmp',
        'graphics/DWILV02.lmp', 'graphics/DWILV03.lmp',
        'graphics/DWILV04.lmp', 'graphics/DWILV05.lmp',
        'graphics/DWILV06.lmp', 'graphics/DWILV07.lmp',
        'graphics/DWILV08.lmp', 'graphics/DWILV09.lmp',
        'graphics/DWILV10.lmp', 'graphics/DWILV11.lmp',
        'graphics/DWILV12.lmp', 'graphics/DWILV13.lmp',
        'graphics/DWILV14.lmp', 'graphics/DWILV15.lmp',
        'graphics/DWILV16.lmp', 'graphics/DWILV17.lmp',
        'graphics/DWILV18.lmp', 'graphics/DWILV19.lmp',
        'graphics/DWILV20.lmp', 'graphics/DWILV21.lmp',
        'graphics/DWILV22.lmp', 'graphics/DWILV23.lmp',
        'graphics/DWILV24.lmp', 'graphics/DWILV25.lmp',
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
        'texdefs/fusion.txt',
        'texdefs/common.txt',
        'texdefs/doom1.txt',
        'texdefs/doom2.txt',
        'texdefs/tnt.txt',
        'texdefs/plutonia.txt',
        'texdefs/id1.txt',
        'texdefs/masterlevels.txt',
        'texdefs/masterlevelsrejects.txt',
        'mapinfo/doomednums.txt',
        'mapinfo/episodes.txt',
        'mapinfo/clusters.txt',
        'mapinfo/intermissions.txt',
        'mapinfo/intermissions_intros.txt',
        'mapinfo/intermissions_masterlevels.txt',
        'mapinfo/intermissions_fullrun.txt',
        'mapinfo/maps_doom1.txt',
        'mapinfo/maps_doomu.txt',
        'mapinfo/maps_doom2.txt',
        'mapinfo/maps_masterlevels.txt',
        'mapinfo/maps_masterlevels_rejects.txt',
        'mapinfo/maps_masterlevels_flynn.txt',
        'mapinfo/maps_masterlevels_anderson.txt',
        'mapinfo/maps_masterlevels_kvernmo.txt',
        'mapinfo/maps_masterlevels_story.txt',
        'mapinfo/maps_nerve.txt',
        'mapinfo/maps_tnt.txt',
        'mapinfo/maps_plutonia.txt',
        'mapinfo/maps_xbox.txt',
        'mapinfo/maps_blackroom.txt',
        'mapinfo/maps_sigil.txt',
        'mapinfo/maps_sigil2.txt',
        'mapinfo/maps_id1.txt',
        'mapinfo/maps_iddm1.txt',
        'maps/WF_NEWGAME.wad',
        'maps/WF_STORY.wad',
        'maps/WF_STORY_ML_MAP29.wad',
        'maps/WF_STORY_ML_MAP30.wad',
        'maps/WF_STORY_ML_MAP31.wad',
        'maps/WF_STORY_ML_MAP32.wad',
        'maps/WF_STORY_ML_MAP16.wad',
        'maps/WF_STORY_ML_MAP17.wad',
        'maps/WF_STORY_ML_MAP33.wad',
        'maps/WF_STORY_ML_MAP34.wad',
        'maps/WF_STORY_ML_MAP11.wad',
        'maps/WF_STORY_ML_MAP12.wad',
        'maps/WF_STORY_ML_MAP13.wad',
        'maps/WF_STORY_ML_MAP15.wad',
        'maps/WF_STORY_ML_MAP19.wad',
        'maps/WF_STORY_ML_MAP37.wad',
        'maps/WF_STORY_ML_MAP38.wad',
        'maps/WF_STORY_ML_MAP20.wad',
        'maps/WF_STORY_ML_MAP18.wad',
        'maps/WF_STORY_ML_MAP41.wad',
        'maps/WF_STORY_ML_MAP42.wad',
        'maps/WF_STORY_ML_MAP10.wad',
        'maps/WF_STORY_ML_MAP43.wad',
        'zscript/wf_handler.zs',
        'zscript/wf_handler_static.zs',
        'zscript/wf_tex_swap.zs',
        'zscript/wf_tex_swap_all.zs',
        'zscript/wf_mus_swap.zs',
        'zscript/wf_mus_idkfa.zs',
        'zscript/wf_mus_sigil.zs',
        'zscript/wf_sbar.zs',
        'zscript/wf_sbar_alt.zs',
        'zscript/wf_masterlevels.zs',
        'zscript/wf_fullrun.zs',
        'zscript/wf_newgame.zs',
        'zscript/wf_story.zs',
        'zscript/wf_map_fixes.zs',
        'zscript/wf_defaults.zs',
        'endoom.bin', 'wadfused.txt'
    ]
    
    # list of files we can extract from
    WADS = [
        'doom', 'doomu', 'doom2', 'tnt', 'plutonia',
        SIGIL_WAD, SIGIL_MP3_WAD, SIGIL2_WAD, SIGIL2_MP3_WAD,
        'id1', 'iddm1', 'extras',
        'doomunity', 'doom2unity', 'tntunity', 'plutoniaunity',
        'doomkex', 'doom2kex', 'tntkex', 'plutoniakex',
        'masterlevels', 'nerve'
    ]
    
    # wads to search for and report if found
    REPORT_WADS = [
        'doom', 'doomu',
        SIGIL_WAD, SIGIL_MP3_WAD, SIGIL2_WAD, SIGIL2_MP3_WAD,
        'doom2', 'masterlevels',
        'attack', 'canyon', 'catwalk', 'fistula',
        'combine', 'subspace', 'paradox', 'subterra',
        'garrison', 'blacktwr', 'virgil', 'minos', 'nessus',
        'geryon', 'vesperas', 'manor', 'ttrap', 'teeth',
        'bloodsea', 'mephisto',
        'cpu', 'device_1', 'dmz', 'cdk_fury', 'e_inside',
        'hive', 'twm01', 'mines', 'anomaly', 'farside',
        'trouble', 'dante25', 'achron22', 'udtwid', 'caball',
        'nerve', 'id1', 'iddm1', 'tnt', 'plutonia',
        'sewers', 'betray', 'e1m4b', 'e1m8b', 'extras',
        'doomunity', 'doom2unity', 'tntunity', 'plutoniaunity',
        'doomkex', 'doom2kex', 'tntkex', 'plutoniakex'
    ]
    
    # lists of lumps common to doom 1+2
    COMMON_LUMPS = [
        'data_common', 'flats_common', 'graphics_common', 'patches_common',
        'sounds_common', 'sprites_common', 'txdefs_common'
    ]
    
    DOOM1_LUMPS = [
        'graphics_doom1', 'music_doom1', 'patches_doom1'
    ]
    
    DOOM2_LUMPS = [
        'flats_doom2', 'graphics_doom2', 'music_doom2', 'patches_doom2',
        'sounds_doom2', 'sprites_doom2'
    ]
    
    ID1_LUMPS = [
        'data_id1', 'flats_id1', 'graphics_id1', 'music_id1', 'patches_id1',
        'sounds_id1', 'sprites_id1'
    ]
    
    # lists of lumps to extract from each IWAD
    WAD_LUMP_LISTS = {
        'doom': COMMON_LUMPS + DOOM1_LUMPS + ['graphics_doom1_registered'],
        'doomu': COMMON_LUMPS + DOOM1_LUMPS + ['graphics_doom1_retail', 'patches_doom1_retail'],
        'doom2': COMMON_LUMPS + DOOM2_LUMPS,
        'masterlevels': ['patches_masterlevels', 'graphics_masterlevels'],
        'tnt': ['graphics_tnt', 'music_tnt', 'patches_tnt'],
        'plutonia': ['graphics_plutonia', 'music_plutonia', 'patches_plutonia'],
        SIGIL_WAD: ['graphics_sigil', 'music_sigil', 'patches_sigil', 'data_sigil'],
        SIGIL_MP3_WAD: ['music_sigil_shreds'],
        SIGIL2_WAD: ['graphics_sigil2', 'music_sigil2', 'patches_sigil2', 'data_sigil2', 'flats_sigil2'],
        SIGIL2_MP3_WAD: ['music_sigil2_shreds'],
        'id1': ID1_LUMPS,
        'iddm1': [],
        # widescreen assets from unity and kex ports
        'doomunity': ['graphics_doom1_unity'],
        'doom2unity': ['graphics_doom2_unity'],
        'tntunity': ['graphics_tnt_unity'],
        'plutoniaunity': ['graphics_plutonia_unity'],
        'doomkex': ['graphics_doom1_unity'],
        'doom2kex': ['graphics_doom2_unity'],
        'tntkex': ['graphics_tnt_unity', 'graphics_tnt_kex'],
        'plutoniakex': ['graphics_plutonia_unity', 'graphics_plutonia_kex'],
        'nerve': [],
        # extras.wad assets from unity and kex ports
        'extras': ['data_extras', 'sounds_extras']
    }
    
    # prefixes for filenames of maps extracted from IWADs
    WAD_MAP_PREFIXES = {
        'doom': '',
        'doomu': '',
        'doom2': '',
        'tnt': 'TN_',
        'plutonia': 'PL_',
        'nerve': 'NV_',
        # master levels not processed like other wads, bespoke prefix lookup
        'masterlevels': 'ML_',
        SIGIL_WAD: '',
        SIGIL2_WAD: '',
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
    
    # lump whose presence distinguishes shareware vs registered & Ultimate Doom
    REGISTERED_DOOM_ONLY_LUMP = 'SKULA1'
    
    # lump whose presence distinguishes registered vs Ultimate Doom
    ULTIMATE_DOOM_ONLY_LUMP = 'M_EPI4'
    
    # lump whose presence distinguishes Unity & KEX vs original nerve.wad
    NERVE_UNITY_KEX_ONLY_LUMP = 'INTERPIC'
    
    # lump whose presence distinguishes KEX vs original nerve.wad, sigil.wad, and sigil2.wad
    PWAD_KEX_ONLY_LUMP = 'M_DOOM'
    
    # lump whose presence distinguishes Unity vs KEX extras.wad
    EXTRAS_KEX_ONLY_LUMP = 'WATERMAP'

def declare_data_sigil():
    global SIGIL_FILENAMES, SIGIL_MP3_FILENAMES, SIGIL2_FILENAMES, SIGIL2_MP3_FILENAMES
    # help the initial source wad reporting find sigil by any of its released names
    SIGIL_FILENAMES = ['sigil', 'sigil_v1_23', 'sigil_v1_21', 'sigil_v1_2', 'sigil_v1_1', 'sigil_v1_0']
    # sigil version with MP3 music
    SIGIL_MP3_FILENAMES = ['sigil_shreds', 'sigil_v1_23_reg']
    # same for sigil2 - version with MIDI music
    SIGIL2_FILENAMES = ['sigil2', 'sigil_ii_v1_0']
    # sigil2 version with MP3 music (no sigil_shreds equivalent; MP3 music just an alternate wad)
    SIGIL2_MP3_FILENAMES = ['sigil2_mp3', 'sigil_ii_mp3_v1_0']

def should_deflate():
    if args.deflate:
        return True
    return False

def should_patch():
    if args.patch:
        # bail if no ipk3 was found
        if not os.path.isfile(DEST_FILENAME):
            logg('No IPK3 found to patch!\n')
            return False
        return True
    return False

def skip_resources():
    if args.extract_only:
        logs('Skipping pre-authored lumps!')
        return True
    return False

def logg(line, error=False):
    global logfile, num_errors
    if not logfile:
        logfile = open(LOG_FILENAME, 'w', encoding='utf-8')
    print(line)
    logfile.write(line + '\n')
    if error:
        num_errors += 1

def logs(line, error=False):
    global logfile, num_errors
    if not logfile:
        logfile = open(LOG_FILENAME, 'w', encoding='utf-8')
    if args.verbose:
        print(line)
    logfile.write(line + '\n')
    if error:
        num_errors += 1

def get_wad_filename(wad_name):
    # return filename of first case-insensitive match
    wad_name += '.wad'
    for i in SRC_WAD_DIR:
        if path.exists(i):
            if not i.endswith('/'):
                i += '/'
            for filename in os.listdir(i):
                if wad_name.lower() == filename.lower():
                    return i + filename
    return None

def set_sigil_filenames():
    global SIGIL_WAD, SIGIL_MP3_WAD, SIGIL2_WAD, SIGIL2_MP3_WAD
    for i in SIGIL_FILENAMES:
        if get_wad_filename(i):
            SIGIL_WAD = i
            break
    for i in SIGIL_MP3_FILENAMES:
        if get_wad_filename(i):
            SIGIL_MP3_WAD = i
            break
    for i in SIGIL2_FILENAMES:
        if get_wad_filename(i):
            SIGIL2_WAD = i
            break
    for i in SIGIL2_MP3_FILENAMES:
        if get_wad_filename(i):
            SIGIL2_MP3_WAD = i
            break

def doom_is_registered():
    d1_wad = omg.WAD()
    if get_wad_filename('doom'):
      d1_wad.from_file(get_wad_filename('doom'))
    if d1_wad.sprites.get(REGISTERED_DOOM_ONLY_LUMP, None):
        return True

def doom_is_retail():
    d1_wad = omg.WAD()
    if get_wad_filename('doom'):
      d1_wad.from_file(get_wad_filename('doom'))
    if d1_wad.graphics.get(ULTIMATE_DOOM_ONLY_LUMP, None):
        return True

def doomu_is_retail():
    ud_wad = omg.WAD()
    if get_wad_filename('doomu'):
      ud_wad.from_file(get_wad_filename('doomu'))
    if ud_wad.graphics.get(ULTIMATE_DOOM_ONLY_LUMP, None):
        return True

def nerve_is_unity():
    nerve_wad = omg.WAD()
    if get_wad_filename('nerve'):
      nerve_wad.from_file(get_wad_filename('nerve'))
    if nerve_wad.graphics.get(NERVE_UNITY_KEX_ONLY_LUMP, None):
        return True

def pwad_is_kex(wad_name):
    in_wad = omg.WAD()
    if get_wad_filename(wad_name):
      in_wad.from_file(get_wad_filename(wad_name))
    if in_wad.graphics.get(PWAD_KEX_ONLY_LUMP, None):
        return True

def extras_is_kex():
    extras_wad = omg.WAD()
    if get_wad_filename('extras'):
      extras_wad.from_file(get_wad_filename('extras'))
    if extras_wad.colormaps.get(EXTRAS_KEX_ONLY_LUMP, None):
        return True

def masterlevels_is_complete():
    if not get_wad_filename('doom2'):
        return
    for i, wad_name in enumerate(MASTER_LEVELS_ORDER):
        in_wad = omg.WAD()
        wad_filename = get_wad_filename(wad_name)
        if not wad_filename:
            return
    return True

def masterlevelsrejects_is_complete():
    if not get_wad_filename('doom2'):
        return
    if not get_wad_filename('masterlevels'):
        if not masterlevels_is_complete():
            return
    for i, wad_name in enumerate(MASTER_LEVELS_REJECTS_ORDER):
        in_wad = omg.WAD()
        wad_filename = get_wad_filename(wad_name)
        if not wad_filename:
            return
    if not get_wad_filename('udtwid'):
        return
    if not get_wad_filename('caball'):
        return
    if not doom_is_retail():
        if not doomu_is_retail():
            return
    return True

def masterlevels_is_complete_verbose():
    if not get_wad_filename('doom2'):
        logg('  ERROR: Skipping Master Levels as doom2.wad is not present', error=True)
        return
    for i, wad_name in enumerate(MASTER_LEVELS_ORDER):
        in_wad = omg.WAD()
        wad_filename = get_wad_filename(wad_name)
        if not wad_filename:
            logg('  ERROR: Skipping Master Levels as %s.wad is not present' % wad_name, error=True)
            return
    return True

def masterlevelsrejects_is_complete_verbose():
    if not get_wad_filename('doom2'):
        logg('  ERROR: Skipping Master Levels Rejects as doom2.wad is not present', error=True)
        return
    if not get_wad_filename('masterlevels'):
        for i, wad_name in enumerate(MASTER_LEVELS_ORDER):
            in_wad = omg.WAD()
            wad_filename = get_wad_filename(wad_name)
            if not wad_filename:
                logg('  ERROR: Skipping Master Levels Rejects as %s.wad is not present' % wad_name, error=True)
                return
    for i, wad_name in enumerate(MASTER_LEVELS_REJECTS_ORDER):
        in_wad = omg.WAD()
        wad_filename = get_wad_filename(wad_name)
        if not wad_filename:
            logg('  ERROR: Skipping Master Levels Rejects as %s.wad is not present' % wad_name, error=True)
            return
    if not get_wad_filename('udtwid'):
        logg('  ERROR: Skipping Master Levels Rejects as udtwid.wad is not present', error=True)
        return
    if not get_wad_filename('caball'):
        logg('  ERROR: Skipping Master Levels Rejects as caball.wad is not present', error=True)
        return
    if not doom_is_retail():
        if not doomu_is_retail():
            logg('  ERROR: Skipping Master Levels Rejects as retail doom.wad is not present', error=True)
            return
    return True

def add_to_wad_lump_lists():
    # if final doom present but not doom1/2, extract doom2 resources from it
    if (get_wad_filename('tnt') or get_wad_filename('plutonia')) and not get_wad_filename('doom2'):
        if get_wad_filename('tnt') and not get_wad_filename('plutonia'):
            logg('  ERROR: Extracting doom2.wad resources from tnt.wad as doom2.wad is not present', error=True)
            WAD_LUMP_LISTS['tnt'] += DOOM2_LUMPS
        else:
            logg('  ERROR: Extracting doom2.wad resources from plutonia.wad as doom2.wad is not present', error=True)
            WAD_LUMP_LISTS['plutonia'] += DOOM2_LUMPS
        # if doom 1 also isn't present (weird) extract all common resources
        if not doom_is_registered():
            if not doomu_is_retail():
                if get_wad_filename('tnt') and not get_wad_filename('plutonia'):
                    logg('  ERROR: Extracting common resources from tnt.wad as registered or retail doom.wad and doom2.wad are not present', error=True)
                    WAD_LUMP_LISTS['tnt'] += COMMON_LUMPS
                else:
                    logg('  ERROR: Extracting common resources from plutonia.wad as registered or retail doom.wad and doom2.wad are not present', error=True)
                    WAD_LUMP_LISTS['plutonia'] += COMMON_LUMPS
    # if doom1 is the original registered version, extract HELP2 graphic from it
    if doom_is_registered() and not doom_is_retail():
        logs('  Extracting HELP2 graphic from doom.wad')
        WAD_LUMP_LISTS['doom'] += ['data_doom1_registered']
    # if doom1 is the retail version with episode 4, extract its resources from it
    if doom_is_retail():
        logs('  Extracting retail resources from doom.wad')
        WAD_LUMP_LISTS['doom'] += ['graphics_doom1_retail', 'patches_doom1_retail']
    # if the original registered version of Doom1 isn't present, duplicate doomu resources
    if doomu_is_retail() and not doom_is_registered():
        logs('  Duplicating resources from doomu.wad in place of doom.wad')
        WAD_LUMP_LISTS['doomu'] += ['graphics_doom1_registered']
    # if id1 present but not doom1, extract doom1 resources from it
    if get_wad_filename('id1'):
        if not doom_is_registered():
            if not doomu_is_retail():
                logg('  ERROR: Extracting doom.wad resources from id1.wad as registered or retail doom.wad is not present', error=True)
                WAD_LUMP_LISTS['id1'] += ['patches_doom1']
    # if iddm1 present but not id1, extract id1 resources from it
    if get_wad_filename('iddm1') and not get_wad_filename('id1'):
        logg('  ERROR: Extracting id1.wad resources from iddm1.wad as id1.wad is not present', error=True)
        WAD_LUMP_LISTS['iddm1'] += ID1_LUMPS
    # if iddm1 present but not doom1, extract doom1 music from it
    if get_wad_filename('iddm1'):
        if not doom_is_registered():
            if not doomu_is_retail():
                logg('  ERROR: Extracting doom.wad resources from iddm1.wad as registered or retail doom.wad is not present', error=True)
                WAD_LUMP_LISTS['iddm1'] += ['music_doom1', 'patches_doom1']
    # if iddm1 present but not tnt, extract tnt music from it
    if get_wad_filename('iddm1') and not get_wad_filename('tnt'):
        logg('  ERROR: Extracting tnt.wad resources from iddm1.wad as tnt.wad is not present', error=True)
        WAD_LUMP_LISTS['iddm1'] += ['music_iddm1']
    # if nerve is the unity or kex version
    if nerve_is_unity():
        logs('  Extracting Unity or KEX resources from nerve.wad')
        WAD_LUMP_LISTS['nerve'] += ['graphics_nerve_unity']
        if pwad_is_kex('nerve'):
            logs('  Extracting KEX resources from nerve.wad')
            WAD_LUMP_LISTS['nerve'] += ['graphics_nerve_kex']
    if pwad_is_kex(SIGIL_WAD):
        logs('  Extracting KEX resources from ' + SIGIL_WAD + '.wad')
        WAD_LUMP_LISTS[SIGIL_WAD] += ['graphics_sigil_kex']
    if pwad_is_kex(SIGIL2_WAD):
        logs('  Extracting KEX resources from ' + SIGIL2_WAD + '.wad')
        WAD_LUMP_LISTS[SIGIL2_WAD] += ['graphics_sigil2_kex']
    # if extras is the kex version
    if extras_is_kex():
        logs('  Extracting KEX resources from extras.wad')
        WAD_LUMP_LISTS['extras'] += ['colormaps_extras', 'graphics_extras', 'music_extras']

def extract_master_levels():
    logs('Processing Master Levels...')
    for i, wad_name in enumerate(MASTER_LEVELS_ORDER):
        in_wad = omg.WAD()
        wad_filename = get_wad_filename(wad_name)
        in_wad.from_file(wad_filename)
        out_wad_filename = DEST_DIR + 'maps/' + WAD_MAP_PREFIXES.get('masterlevels', '') + 'MAP'
        # extra zero for <10 map numbers, e.g. map01
        out_wad_filename += str(i + 1).rjust(2, '0') + '.wad'
        logs('  Extracting %s to %s' % (wad_filename, out_wad_filename))
        # grab first map we find in each wad
        map_name = in_wad.maps.find('*')[0]
        extract_map(in_wad, map_name, out_wad_filename)
    # save teeth map32 to map21
    wad_filename = get_wad_filename('teeth')
    out_wad_filename = DEST_DIR + 'maps/' + WAD_MAP_PREFIXES.get('masterlevels', '') + 'MAP21.wad'
    logs('  Extracting %s map32 to %s' % (wad_filename, out_wad_filename))
    in_wad = omg.WAD()
    in_wad.from_file(wad_filename)
    extract_map(in_wad, in_wad.maps.find('*')[1], out_wad_filename)
    # extract sky lumps
    for wad_name, patch_replace in MASTER_LEVELS_PATCHES.items():
        wad = omg.WAD()
        wad_filename = get_wad_filename(wad_name)
        wad.from_file(wad_filename)
        # manor stores sky in patches namespace, combine and virgil don't
        if patch_replace[0] in wad.data:
            lump = wad.data[patch_replace[0]]
        else:
            lump = wad.patches[patch_replace[0]]
        out_filename = DEST_DIR + 'patches/' + patch_replace[1] + '.lmp'
        logs('  Extracting %s lump from %s as %s' % (patch_replace[0],
                                                   wad_filename,
                                                   patch_replace[1]))
        lump.to_file(out_filename)

def copy_master_levels_doom1_music():
    logs('Duplicating D_RUNNIN.mus to use in the Master Levels in place of Doom1 music...')
    copyfile(DEST_DIR_MUS + 'D_RUNNIN.mus', DEST_DIR_MUS + 'D_E2M2.mus')
    copyfile(DEST_DIR_MUS + 'D_RUNNIN.mus', DEST_DIR_MUS + 'D_E1M6.mus')
    copyfile(DEST_DIR_MUS + 'D_RUNNIN.mus', DEST_DIR_MUS + 'D_E3M3.mus')
    copyfile(DEST_DIR_MUS + 'D_RUNNIN.mus', DEST_DIR_MUS + 'D_E1M7.mus')

def extract_master_levels_rejects():
    global num_maps
    logs('Processing Master Levels Rejects...')
    for i, wad_name in enumerate(MASTER_LEVELS_REJECTS_ORDER):
        in_wad = omg.WAD()
        wad_filename = get_wad_filename(wad_name)
        in_wad.from_file(wad_filename)
        out_wad_filename = DEST_DIR + 'maps/' + WAD_MAP_PREFIXES.get('masterlevels', '') + 'MAP'
        out_wad_filename += str(i + 22) + '.wad'
        logs('  Extracting %s to %s' % (wad_filename, out_wad_filename))
        # grab first map we find in each wad
        map_name = in_wad.maps.find('*')[0]
        extract_map(in_wad, map_name, out_wad_filename)
    # copy E4M7 to use as John Anderson's 8th Canto
    out_wad_filename = DEST_DIR + 'maps/' + 'ML_MAP35.wad'
    e4m7_filename = DEST_DIR + 'maps/' + 'E4M7.wad'
    logs('  Copying %s to %s' % (e4m7_filename, out_wad_filename))
    copyfile(e4m7_filename, out_wad_filename)
    num_maps += 1
    # copy UDTWiD E4M8 into dest dir and set its map lump name
    in_wad = omg.WAD()
    wad_filename = get_wad_filename('udtwid')
    in_wad.from_file(wad_filename)
    out_wad_filename = DEST_DIR + 'maps/' + 'ML_MAP36.wad'
    logs('  Extracting %s map E4M8 to %s' % (wad_filename, out_wad_filename))
    map_name = in_wad.maps.find('E4M8')[0]
    extract_map(in_wad, map_name, out_wad_filename)
    # copy cabal maps
    i = 0
    in_wad = omg.WAD()
    wad_filename = get_wad_filename('caball')
    in_wad.from_file(wad_filename)
    for map_name in in_wad.maps.find('*'):
        out_wad_filename = DEST_DIR + 'maps/' + WAD_MAP_PREFIXES.get('masterlevels', '') + 'MAP'
        out_wad_filename += str(i + 37) + '.wad'
        logs('  Extracting %s map %s to %s' % (wad_filename, map_name, out_wad_filename))
        extract_map(in_wad, map_name, out_wad_filename)
        i += 1
    # extract Titan lumps
    for wad_name, patch_extract in MASTER_LEVELS_TITAN_PATCHES.items():
        wad = omg.WAD()
        wad_filename = get_wad_filename(wad_name)
        wad.from_file(wad_filename)
        for i in patch_extract:
            lump = wad.patches[i]
            out_filename = DEST_DIR + 'patches/' + i + '.lmp'
            logs('  Extracting %s lump from %s' % (i, wad_filename))
            lump.to_file(out_filename)
    # extract UDTWiD lumps
    wad = omg.WAD()
    wad_filename = get_wad_filename('udtwid')
    wad.from_file(wad_filename)
    lump = wad.patches['DRSLEEP']
    out_filename = DEST_DIR + 'patches/DRSLEEP.lmp'
    logs('  Extracting DRSLEEP lump from %s' % wad_filename)
    lump.to_file(out_filename)
    for wad_name, patch_replace in MASTER_LEVELS_UDTWID_PATCHES.items():
        wad = omg.WAD()
        wad_filename = get_wad_filename(wad_name)
        wad.from_file(wad_filename)
        lump = wad.patches[patch_replace[0]]
        out_filename = DEST_DIR + 'patches/' + patch_replace[1] + '.lmp'
        logs('  Extracting %s lump from %s as %s' % (patch_replace[0],
                                                   wad_filename,
                                                   patch_replace[1]))
        lump.to_file(out_filename)

def move_help2():
    # the HELP2 graphics lump gets extracted to the base directory first
    logs('Moving HELP2 lump if present...')
    old_name = DEST_DIR + 'HELP2.lmp'
    new_name = DEST_DIR_GRAPHICS + 'HELP2.lmp'
    if path.exists(old_name):
        logs('  Moving %s lump to %s' % (old_name, new_name))
        os.rename(old_name, new_name)

def rename_ogg():
    # remove .lmp file extension from Andrew Hulshult's IDKFA .ogg music if it's present
    logs('Renaming OGG music lumps if present...')
    # the music gets extracted to the graphics folder first
    for filename in os.listdir(DEST_DIR_GRAPHICS):
        if fnmatch.fnmatch(filename, '*.ogg.lmp'):
            old_name = path.join(DEST_DIR_GRAPHICS, filename)
            new_name = old_name.replace('.ogg.lmp', '.ogg')
            # set the destination for the music files to the music folder
            new_name = new_name.replace('graphics', 'music')
            logs('  Moving %s lump to %s' % (old_name, new_name))
            os.rename(old_name, new_name)

def rename_mp3():
    # remove .mus file extension from Sigil's .mp3 music if it's present
    logs('Renaming MP3 music lumps if present...')
    for filename in os.listdir(DEST_DIR_MUS):
        if fnmatch.fnmatch(filename, '*.mp3.mus'):
            old_name = path.join(DEST_DIR_MUS, filename)
            new_name = old_name.replace('.mp3.mus', '.mp3')
            logs('  Moving %s lump to %s' % (old_name, new_name))
            os.rename(old_name, new_name)

def add_xbox_levels():
    global num_maps
    logs('Adding Xbox bonus levels...')
    if (doom_is_registered() or doomu_is_retail()) and get_wad_filename('sewers'):
        logs('  Adding SEWERS.WAD as E1M10')
        copyfile(get_wad_filename('sewers'), DEST_DIR + 'maps/E1M10.wad')
        num_maps += 1
    if get_wad_filename('doom2') and get_wad_filename('betray'):
        logs('  Adding BETRAY.WAD as MAP33')
        copyfile(get_wad_filename('betray'), DEST_DIR + 'maps/MAP33.wad')
        num_maps += 1

def add_blackroom_levels():
    global num_maps
    logs('Adding Blackroom warm-up levels...')
    if (doom_is_registered() or doomu_is_retail()) and get_wad_filename('e1m4b'):
        logs('  Adding E1M4B.WAD as E1M4B')
        copyfile(get_wad_filename('e1m4b'), DEST_DIR + 'maps/E1M4B.wad')
        num_maps += 1    
    if (doom_is_registered() or doomu_is_retail()) and get_wad_filename('e1m8b'):
        logs('  Adding E1M8B.WAD as E1M8B')
        copyfile(get_wad_filename('e1m8b'), DEST_DIR + 'maps/E1M8B.wad')
        num_maps += 1

def extract_map(in_wad, map_name, out_filename):
    global num_maps
    out_wad = omg.WAD()
    out_wad.maps[map_name] = in_wad.maps[map_name]
    out_wad.to_file(out_filename)
    num_maps += 1

def extract_iwad_maps(wad_name, map_prefix):
    in_wad = omg.WAD()
    wad_filename = get_wad_filename(wad_name)
    in_wad.from_file(wad_filename)
    for map_name in in_wad.maps.find('*'):
        logs('  Extracting map %s...' % map_name)
        out_wad_filename = DEST_DIR + 'maps/' + map_prefix + map_name + '.wad'
        extract_map(in_wad, map_name, out_wad_filename)
        #logs('  Saved map %s' % out_wad_filename)

def extract_lumps(wad_name):
    if not wad_name in WAD_LUMP_LISTS:
        return
    wad = omg.WAD()
    wad_filename = get_wad_filename(wad_name)
    wad.from_file(wad_filename)
    for lump_list in WAD_LUMP_LISTS[wad_name]:
        # derive subdir from name of lump list
        try:
            lump_type = lump_list[:lump_list.index('_')]
        except ValueError:
            logg('  ERROR: Couldn\'t identify type of lump list %s' % lump_list, error=True)
            continue
        # sigil sky lump isn't in patch namespace
        if lump_list == 'patches_sigil':
            lump_type = 'data'
        # the IDKFA soundtrack isn't in music namespace
        if lump_list == 'music_extras':
            lump_type = 'data'
        lump_table = getattr(wad, lump_type, None)
        if not lump_table:
            logg('  ERROR: Lump type %s not found' % lump_type, error=True)
            continue
        logs('  extracting %s...' % lump_list)
        # sigil sky is in data namespace but we want it in patches dir
        if wad_name == SIGIL_WAD and lump_list == 'patches_sigil':
            lump_subdir = DEST_DIR + 'patches/'
        # sigil 1&2 screens aren't in graphics namespace but belong in that dir
        elif wad_name == SIGIL_WAD and lump_type == 'data':
            lump_subdir = DEST_DIR + 'graphics/'
        elif wad_name == SIGIL2_WAD and lump_type == 'data':
            lump_subdir = DEST_DIR + 'graphics/'
        # legacy of rust statusbar icons and map title patches aren't in graphics namespace but belong in that dir
        elif wad_name == 'id1' and lump_type == 'data':
            lump_subdir = DEST_DIR + 'graphics/'
        # extras.wad statusbar icons aren't in graphics namespace but belong in that dir
        elif wad_name == 'extras' and lump_type == 'data':
            lump_subdir = DEST_DIR + 'graphics/'
        # write PLAYPAL, TEXTURE1 etc to pk3 root
        elif lump_type in ['data', 'txdefs']:
            lump_subdir = DEST_DIR
        else:
            lump_subdir = DEST_DIR + lump_type + '/'
        # process each item in lump list
        for line in open(DATA_DIR + lump_list).readlines():
            line = line.strip()
            # ignore comments
            if line.startswith('//'):
                continue
            # no colon: extracted lump uses name from list
            if line.find(':') == -1:
                out_filename = line
                lump_name = line
            # colon: use filename to right of colon
            else:
                # split then strip
                lump_name, out_filename = line.split(':')
                lump_name = lump_name.strip()
                out_filename = out_filename.strip()
            if not lump_name in lump_table:
                logg('  ERROR: Couldn\'t find lump with name %s' % lump_name, error=True)
                continue
            lump = lump_table[lump_name]
            out_filename += '.lmp' if lump_type != 'music' else '.mus'
            logs('    Extracting %s' % lump_subdir + out_filename)
            lump.to_file(lump_subdir + out_filename)

def extract_iwads():
    for iwad_name in WADS:
        wad_filename = get_wad_filename(iwad_name)
        if not wad_filename:
            logs('WAD %s not found' % iwad_name)
            continue
        if iwad_name == 'masterlevels' and not get_wad_filename('doom2'):
            logg('  ERROR: Skipping masterlevels.wad as doom2.wad is not present', error=True)
            continue
        if iwad_name == 'nerve' and not get_wad_filename('doom2'):
            logg('  ERROR: Skipping nerve.wad as doom2.wad is not present', error=True)
            continue
        if iwad_name == SIGIL_WAD:
            if not doom_is_registered():
                if not doomu_is_retail():
                    logg('  ERROR: Skipping ' + SIGIL_WAD + '.wad as registered or retail doom.wad is not present', error=True)
                    continue
        if iwad_name == SIGIL_MP3_WAD and not get_wad_filename(SIGIL_WAD):
            logg('  ERROR: Skipping ' + SIGIL_MP3_WAD + '.wad as sigil.wad is not present', error=True)
            continue
        if iwad_name == SIGIL_MP3_WAD:
            if not doom_is_registered():
                if not doomu_is_retail():
                    logg('  ERROR: Skipping ' + SIGIL_MP3_WAD + '.wad as registered or retail doom.wad is not present', error=True)
                    continue
        if iwad_name == SIGIL2_WAD:
            if not doom_is_registered():
                if not doomu_is_retail():
                    logg('  ERROR: Skipping ' + SIGIL2_WAD + '.wad as registered or retail doom.wad is not present', error=True)
                    continue
        if iwad_name == SIGIL2_MP3_WAD and not get_wad_filename(SIGIL2_WAD):
            logg('  ERROR: Skipping ' + SIGIL2_MP3_WAD + '.wad as sigil2.wad is not present', error=True)
            continue
        if iwad_name == SIGIL2_MP3_WAD:
            if not doom_is_registered():
                if not doomu_is_retail():
                    logg('  ERROR: Skipping ' + SIGIL2_MP3_WAD + '.wad as registered or retail doom.wad is not present', error=True)
                    continue
        if iwad_name == 'id1' and not get_wad_filename('doom2'):
            logg('  ERROR: Skipping id1.wad as doom2.wad is not present', error=True)
            continue
        if iwad_name == 'iddm1' and not get_wad_filename('doom2'):
            logg('  ERROR: Skipping iddm1.wad as doom2.wad is not present', error=True)
            continue
        if iwad_name == 'doom' and not doom_is_registered():
            logg('  ERROR: Skipping doom.wad as it appears to be the shareware version', error=True)
            continue
        if iwad_name == 'doomu' and not doomu_is_retail():
            logg('  ERROR: Skipping doomu.wad as it appears to not be the retail version', error=True)
            continue
        if iwad_name == 'doomu' and doom_is_retail():
            logg('  ERROR: Skipping doomu.wad as doom.wad appears to also be the retail version', error=True)
            continue
        logs('Processing WAD %s...' % iwad_name)
        extract_lumps(iwad_name)
        prefix = WAD_MAP_PREFIXES.get(iwad_name, None)
        # check None, not empty string!
        if prefix is not None:
            extract_iwad_maps(iwad_name, prefix)

def make_dirs():
    if not path.exists(DEST_DIR):
        os.mkdir(DEST_DIR)
    for dirname in ['colormaps', 'flats', 'graphics', 'mapinfo', 'maps',
                    'music', 'patches', 'sounds', 'sprites', 'texdefs', 'zscript']:
        if not path.exists(DEST_DIR + dirname):
            os.mkdir(DEST_DIR + dirname)

def add_newgame():
    global RES_FILES
    if doom_is_registered() or doom_is_retail() or doomu_is_retail():
        RES_FILES += ['maps/WF_NEWGAME_E1M1.wad', 'maps/WF_NEWGAME_E2M1.wad', 'maps/WF_NEWGAME_E3M1.wad']
    if doom_is_retail() or doomu_is_retail():
        RES_FILES += ['maps/WF_NEWGAME_E4M1.wad']
    if get_wad_filename(SIGIL_WAD):
        RES_FILES += ['maps/WF_NEWGAME_E5M1.wad']
    if get_wad_filename(SIGIL2_WAD):
        RES_FILES += ['maps/WF_NEWGAME_E6M1.wad']
    if get_wad_filename('doom2'):
        RES_FILES += ['maps/WF_NEWGAME_MAP01.wad']
    if masterlevels_is_complete() or (get_wad_filename('masterlevels') and get_wad_filename('doom2')):
        RES_FILES += ['maps/WF_NEWGAME_ML_MAP01.wad']
    if get_wad_filename('nerve'):
        RES_FILES += ['maps/WF_NEWGAME_NV_MAP01.wad']
    if get_wad_filename('tnt'):
        RES_FILES += ['maps/WF_NEWGAME_TN_MAP01.wad']
    if get_wad_filename('plutonia'):
        RES_FILES += ['maps/WF_NEWGAME_PL_MAP01.wad']
    if get_wad_filename('id1'):
        RES_FILES += ['maps/WF_NEWGAME_LR_MAP01.wad', 'maps/WF_NEWGAME_LR_MAP08.wad']

def add_textures():
    texfile = open(DEST_DIR + 'textures.txt', 'a')
    if doom_is_registered() or doom_is_retail() or doomu_is_retail() or ((get_wad_filename('id1') or get_wad_filename('iddm1')) and get_wad_filename('doom 2')):
        texfile.write('#include "texdefs/doom1.txt"\n')
    if get_wad_filename('doom2') or get_wad_filename('tnt') or get_wad_filename('plutonia'):
        texfile.write('#include "texdefs/doom2.txt"\n')
    if get_wad_filename('tnt'):
        texfile.write('#include "texdefs/tnt.txt"\n')
    if get_wad_filename('plutonia'):
        texfile.write('#include "texdefs/plutonia.txt"\n')
    if (get_wad_filename('id1') or get_wad_filename('iddm1')) and get_wad_filename('doom2'):
        texfile.write('#include "texdefs/id1.txt"\n')
    if masterlevels_is_complete() or (get_wad_filename('masterlevels') and get_wad_filename('doom2')):
        texfile.write('#include "texdefs/masterlevels.txt"\n')
    if masterlevelsrejects_is_complete():
        texfile.write('#include "texdefs/masterlevelsrejects.txt"\n')

def map_exists(map_name):
    map_name += '.wad'
    for filename in os.listdir(DEST_DIR + 'maps/'):
        if map_name.lower() == filename.lower():
            return True
    return False

def add_newgame_patch():
    global RES_FILES
    if map_exists('e1m1'):
        RES_FILES += ['maps/WF_NEWGAME_E1M1.wad', 'maps/WF_NEWGAME_E2M1.wad', 'maps/WF_NEWGAME_E3M1.wad']
    if map_exists('e4m1'):
        RES_FILES += ['maps/WF_NEWGAME_E4M1.wad']
    if map_exists('e5m1'):
        RES_FILES += ['maps/WF_NEWGAME_E5M1.wad']
    if map_exists('e6m1'):
        RES_FILES += ['maps/WF_NEWGAME_E6M1.wad']
    if map_exists('map01'):
        RES_FILES += ['maps/WF_NEWGAME_MAP01.wad']
    if map_exists('ml_map01'):
        RES_FILES += ['maps/WF_NEWGAME_ML_MAP01.wad']
    if map_exists('nv_map01'):
        RES_FILES += ['maps/WF_NEWGAME_NV_MAP01.wad']
    if map_exists('tn_map01'):
        RES_FILES += ['maps/WF_NEWGAME_TN_MAP01.wad']
    if map_exists('pl_map01'):
        RES_FILES += ['maps/WF_NEWGAME_PL_MAP01.wad']
    if map_exists('lr_map01'):
        RES_FILES += ['maps/WF_NEWGAME_LR_MAP01.wad', 'maps/WF_NEWGAME_LR_MAP08.wad']

def add_textures_patch():
    texfile = open(DEST_DIR + 'textures.txt', 'a')
    if map_exists('e1m1') or map_exists('lr_map01') or map_exists('dm_map01'):
        texfile.write('#include "texdefs/doom1.txt"\n')
    if map_exists('map01') or map_exists('tn_map01') or map_exists('pl_map01'):
        texfile.write('#include "texdefs/doom2.txt"\n')
    if map_exists('tn_map01'):
        texfile.write('#include "texdefs/tnt.txt"\n')
    if map_exists('pl_map01'):
        texfile.write('#include "texdefs/plutonia.txt"\n')
    if map_exists('lr_map01') or map_exists('dm_map01'):
        texfile.write('#include "texdefs/id1.txt"\n')
    if map_exists('ml_map01'):
        texfile.write('#include "texdefs/masterlevels.txt"\n')
    if map_exists('ml_map22'):
        texfile.write('#include "texdefs/masterlevelsrejects.txt"\n')

def copy_resources():
    for src_file in RES_FILES:
        logs('Copying %s' % src_file)
        copyfile(RES_DIR + src_file, DEST_DIR + src_file)
    # add texture definition includes only for present wads
    if not should_patch():
        add_textures()
    else:
        add_textures_patch()

def copy_id1_doom1_skies():
    logs('Duplicating doom1 sky patches to suppress errors with id1...')
    copyfile(DEST_DIR + 'patches/SKYE1.lmp', DEST_DIR + 'patches/SKY1.lmp')
    copyfile(DEST_DIR + 'patches/SKYE2.lmp', DEST_DIR + 'patches/SKY2.lmp')
    copyfile(DEST_DIR + 'patches/SKYE3.lmp', DEST_DIR + 'patches/SKY3.lmp')
    copyfile(DEST_DIR + 'patches/SKYE4.lmp', DEST_DIR + 'patches/SKY4.lmp')

def extract():
    # extract lumps and maps from wads
    extract_iwads()
    if get_wad_filename('attack') and not get_wad_filename('masterlevels'):
        if masterlevels_is_complete_verbose():
            extract_master_levels()
            if not doom_is_registered():
                if not doomu_is_retail():
                    copy_master_levels_doom1_music()
    elif get_wad_filename('masterlevels'):
        if not doom_is_registered():
            if not doomu_is_retail():
                copy_master_levels_doom1_music()
    if get_wad_filename('cpu'):
        if masterlevelsrejects_is_complete_verbose():
            extract_master_levels_rejects()
    # copy pre-authored lumps e.g. mapinfo
    if not skip_resources():
        copy_resources()
    else:
        logs('Copying iwadinfo.txt')
        copyfile(RES_DIR + 'iwadinfo.txt', DEST_DIR + 'iwadinfo.txt')
        logs('Copying textures.txt')
        copyfile(RES_DIR + 'textures.txt', DEST_DIR + 'textures.txt')
        add_textures()
    # duplicate doom1 sky patches to suppress errors with id1
    if get_wad_filename('id1') and get_wad_filename('doom2'):
        if not doom_is_registered():
            if not doomu_is_retail():
                copy_id1_doom1_skies()
    # move the HELP2 graphics lump from the base directory to the graphics folder
    move_help2()
    # rename file extensions of Sigil mp3 music
    rename_mp3()
    # rename file extensions of Andrew Hulshult's IDKFA soundtrack ogg music
    rename_ogg()
    # only supported versions of these @ http://classicdoom.com/xboxspec.htm
    if get_wad_filename('sewers') or get_wad_filename('betray'):
        add_xbox_levels()
    # add romero's blackroom warm-up levels if present
    if get_wad_filename('e1m4b') or get_wad_filename('e1m8b'):
        add_blackroom_levels()
    # copy custom GENMIDI, if user hasn't deleted it
    genmidi_filename = 'GENMIDI.lmp'
    if path.exists(RES_DIR + genmidi_filename):
        logs('Copying %s' % genmidi_filename)
        copyfile(RES_DIR + genmidi_filename, DEST_DIR + genmidi_filename)

def source_wads_dirs():
    global SRC_WAD_DIR, src_wad_dirs_errors
    if args.wads:
        SRC_WAD_DIR += args.wads
    src_wad_dirs_num = len(SRC_WAD_DIR)
    for i, j in enumerate(SRC_WAD_DIR):
        if path.exists(j):
            if i > 0:
                logs('Searching for WADs in "' + path.realpath(j) + '".')
        if not path.exists(j):
            logg('The specified WADs directory "' + path.realpath(j) + '" does not exist!')
            src_wad_dirs_errors += 1
            if src_wad_dirs_errors == src_wad_dirs_num:
                input('Press Enter to exit.\n')
                logfile.close()
                return
        if not j.endswith('/'):
            j += '/'

def get_report_found():
    found = []
    for wadname in REPORT_WADS:
        if get_wad_filename(wadname):
            found.append(wadname)
    return found

def clear_temp():
    # clear out temp dir from previous runs
    if path.exists(DEST_DIR):
        rmtree(DEST_DIR)
        logs('Removed temp directory from a previous run.\n')

def get_eps(wads_found):
    eps = []
    extra = ''
    for wadname in wads_found:
        if wadname == 'doom' and not doomu_is_retail():
            if doom_is_registered():
                if 'sewers' in wads_found:
                    extra += ' + E1M10'
                if 'e1m8b' in wads_found:
                    extra += ' + E1M8B'
                if 'e1m4b' in wads_found:
                    extra += ' + E1M4B'
                eps += ['Knee Deep in the Dead' + extra]
                eps += ['The Shores of Hell', 'Inferno']
                if doom_is_retail():
                    eps += ['Thy Flesh Consumed']
                extra = ''
        if wadname == 'doomu' and doomu_is_retail():
            if 'sewers' in wads_found:
                extra += ' + E1M10'
            if 'e1m8b' in wads_found:
                extra += ' + E1M8B'
            if 'e1m4b' in wads_found:
                extra += ' + E1M4B'
            eps += ['Knee Deep in the Dead' + extra]
            eps += ['The Shores of Hell', 'Inferno', 'Thy Flesh Consumed']
            extra = ''
        elif wadname == 'doom2':
            if 'betray' in wads_found:
                extra += ' + MAP33'
            eps += ['Hell on Earth' + extra]
            extra = ''
        elif wadname == 'attack' and masterlevels_is_complete() and not 'masterlevels' in wads_found:
            if masterlevelsrejects_is_complete():
                extra += ' + Rejects'
            eps += ['Master Levels' + extra]
            extra = ''
        elif wadname == 'masterlevels' and 'doom2' in wads_found:
            if masterlevelsrejects_is_complete():
                extra += ' + Rejects'
            eps += ['Master Levels' + extra]
            extra = ''
        elif wadname == 'nerve' and 'doom2' in wads_found:
            eps += ['No Rest for the Living']
        elif wadname == 'tnt':
            eps += ['TNT: Evilution']
        elif wadname == 'plutonia':
            eps += ['The Plutonia Experiment']
        elif wadname == SIGIL_WAD:
            if doom_is_registered() or doomu_is_retail():
                if SIGIL_MP3_WAD in wads_found:
                    extra += ' + Buckethead Soundtrack'
                eps += ['SIGIL' + extra]
                extra = ''
        elif wadname == SIGIL2_WAD:
            if doom_is_registered() or doomu_is_retail():
                if SIGIL2_MP3_WAD in wads_found:
                    extra += ' + THORR Soundtrack'
                eps += ['SIGIL II' + extra]
                extra = ''
        elif wadname == 'id1' and 'doom2' in wads_found:
            eps += ['The Vulcan Abyss', 'Counterfeit Eden']
        elif wadname == 'iddm1' and 'doom2' in wads_found:
            eps += ['id Deathmatch Pack #1']
    return eps

def pk3_compress():
    logg('Compressing %s...' % DEST_FILENAME)
    pk3 = ZipFile(DEST_FILENAME, 'w', ZIP_DEFLATED if should_deflate() else ZIP_STORED, compresslevel=9)
    for dir_name, x, filenames in os.walk(DEST_DIR):
        for filename in filenames:
            src_name = dir_name + '/' + filename
            # exclude pk3/ top dir from name within archive
            dest_name = src_name[len(DEST_DIR):]
            pk3.write(src_name, dest_name)
    pk3.close()

def pk3_patch():
    logs('Initialized in patch mode.')
    i = input('Press Y and then Enter to patch an existing IPK3, anything else to cancel: ')
    if i.lower() != 'y':
        logg('Canceled.')
        logfile.close()
        return
    start_time = time.time()
    logg('\nProcessing %s...' % DEST_FILENAME)
    pk3 = ZipFile(DEST_FILENAME, 'r')
    pk3.extractall(DEST_DIR)
    pk3.close()
    make_dirs()
    add_newgame_patch()
    copy_resources()
    pk3_compress()
    elapsed_time = time.time() - start_time
    ipk3_size = path.getsize(DEST_FILENAME) / 1048576
    logg('Patched %s (%.2f MiB) in %.2f seconds.' % (DEST_FILENAME, ipk3_size, elapsed_time))
    logg('Done!')
    if num_errors > 0:
        logg('%s errors found, see %s for details.' % (num_errors, LOG_FILENAME))
    input('Press Enter to exit.\n')
    clear_temp()
    logfile.close()

def main():
    global SRC_WAD_DIR, num_maps, num_eps
    # log python and os version
    logs(sys.version)
    logs(platform.system() + ' ' + os.name + ' ' + sys.platform + ' ' + platform.release())
    logs(platform.version())
    logs(platform.platform() + '\n')
    # log used command line arguments
    args_str = ''
    for i in sys.argv[1:]:
        args_str += i + ' '
    if args_str != '':
        logs('Command line arguments used: ' + args_str + '\n')
    # clear out pk3 dir from previous runs
    clear_temp()
    title_line = 'WadFusion v%s' % VERSION
    logg(title_line + '\n' + '-' * len(title_line) + '\n')
    # source_wads/ directory stuff
    source_wads_dirs()
    # support for all the various filenames used by sigil releases
    declare_data_sigil()
    set_sigil_filenames()
    # initialize data tables
    declare_data()
    # patch an existing ipk3 if --patch argument is used
    if should_patch():
        pk3_patch()
        return
    # add newgame maps only for present wads
    add_newgame()
    found = get_report_found()
    # bail if no wads in SRC_WAD_DIR
    if len(found) == 0:
        logg('No source WADs found!\nPlease place your WAD files into "%s".' % path.realpath(SRC_WAD_DIR[0]))
        input('Press Enter to exit.\n')
        logfile.close()
        return
    logs('WADs found:\n' + ', '.join(found) + '\n')
    # bail if no iwads in SRC_WAD_DIR
    if not get_wad_filename('doom') and not get_wad_filename('doomu') and not get_wad_filename('doom2') and not get_wad_filename('tnt') and not get_wad_filename('plutonia'):
        logg('No source IWADs found!\nPlease place your IWAD files into "%s".' % path.realpath(SRC_WAD_DIR[0]))
        input('Press Enter to exit.\n')
        logfile.close()
        return
    if args.wads and src_wad_dirs_errors > 0:
        logg('')
    logg('A new IPK3 will be generated with the following episodes:')
    for num_eps, ep_name in enumerate(get_eps(found)):
        logg('- %s' % ep_name)
    num_eps += 1
    if get_wad_filename('extras'):
        extra = ''
        if extras_is_kex():
            extra += ' + IDKFA Soundtrack'
        logg('  + Extras WAD' + extra)
    # deduct iddm1 from the episode tally, since it won't show up in the menu
    if get_wad_filename('iddm1') and get_wad_filename('doom2'):
        num_eps -= 1
    i = input('\nPress Y and then Enter to proceed, anything else to cancel: ')
    if i.lower() != 'y':
        logg('Canceled.')
        logfile.close()
        return
    start_time = time.time()
    logg('\nProcessing WADs...')
    # add additional lumps to the pre-defined lump lists
    add_to_wad_lump_lists()
    # make dirs if they don't exist
    make_dirs()
    # extract and copy all lumps from wads and res folder
    extract()
    # deduct doom.wad maps if doomu.wad is also present
    if doom_is_registered() and doomu_is_retail():
        if not doom_is_retail():
            num_maps -= 27
    # create pk3
    pk3_compress()
    elapsed_time = time.time() - start_time
    ipk3_size = path.getsize(DEST_FILENAME) / 1048576
    logg('Generated %s (%.2f MiB) with %s maps in %s episodes in %.2f seconds.' % (DEST_FILENAME, ipk3_size, num_maps, num_eps, elapsed_time))
    logg('Done!')
    if num_errors > 0:
        logg('%s errors found, see %s for details.' % (num_errors, LOG_FILENAME))
    input('Press Enter to exit.\n')
    clear_temp()
    logfile.close()

if __name__ == "__main__":
    main()
