##-----------------------------------------------------------------------------
##
## Copyright 2024 Owlet VII
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

import os, sys, time, fnmatch
from shutil import copyfile
from zipfile import ZipFile, ZIP_DEFLATED

import omg

VERSION_FILENAME = 'version'

# if False, do a dry run with no actual file writing
should_extract = True

SRC_WAD_DIR = 'source_wads/'
DATA_DIR = 'data/'
TEMP_DIR = 'temp/'
DEST_DIR = TEMP_DIR + 'pk3/'
DEST_DIR_OGG = TEMP_DIR + 'pk3_ogg/'
DEST_FILENAME = 'doom_complete.pk3'
DEST_FILENAME_OGG = 'hulshult_ogg.pk3'
LOG_FILENAME = 'wadfusion.log'
RES_DIR = 'res/'
DATA_TABLES_FILE = 'wadfusion_data.py'
ML_ORDER_FILENAME = 'masterlevels_order_xaser.txt'
ML_MAPINFO_FILENAME = DEST_DIR + 'mapinfo/master_levels.txt'
DEST_DIR_OGG_MUS = DEST_DIR_OGG + 'music/'

# forward-declare all the stuff in DATA_TABLES_FILE for clarity
RES_FILES = []
RES_FILES_OGG = []
WADS = []
REPORT_WADS = []
COMMON_LUMPS = []
DOOM1_LUMPS = []
DOOM2_LUMPS = []
WAD_LUMP_LISTS = {}
WAD_MAP_PREFIXES = {}
MAP_NAME_GRAPHICS_DIRS = []
MASTER_LEVELS_PATCHES = {}
MASTER_LEVELS_SKIES = {}
MASTER_LEVELS_MUSIC = {}
MASTER_LEVELS_MAP07_SPECIAL = []
MASTER_LEVELS_AUTHOR_PREFIX = ''
MASTER_LEVELS_AUTHORS = {}
MASTER_LEVELS_MAPINFO_HEADER = []
SIGIL_ALT_FILENAMES = []
SIGIL2_ALT_FILENAMES = []
SIGIL2_MP3_ALT_FILENAMES = []
BFG_ONLY_LUMP = ''
EXTRAS_KEX_ONLY_LUMP = ''

logfile = None

exec(open(DATA_TABLES_FILE).read())

MASTER_LEVELS_MAP_PREFIX = WAD_MAP_PREFIXES.get('masterlevels', '')

# track # of maps extracted
num_maps = 0
num_errors = 0


def logg(line, error=False):
    global logfile, num_errors
    if not logfile:
        logfile = open(LOG_FILENAME, 'w')
    print(line)
    logfile.write(line + '\n')
    if error:
        num_errors += 1

def get_wad_filename(wad_name):
    # return filename of first case-insensitive match
    wad_name += '.wad'
    for filename in os.listdir(SRC_WAD_DIR):
        if wad_name.lower() == filename.lower():
            return SRC_WAD_DIR + filename
    return None

def get_master_levels_map_order():
    order = []
    if len(sys.argv) > 1:
        order_file = ' '.join(sys.argv[1:])
        if not os.path.exists(order_file):
            order_file = ML_ORDER_FILENAME
    else:
        order_file = ML_ORDER_FILENAME
    if not os.path.exists(order_file):
        return order_file, []
    logg('Using Master Levels ordering from %s' % order_file)
    for line in open(order_file).readlines():
        line = line.strip().lower()
        if line.startswith('//') or line == '':
            continue
        if not line in MASTER_LEVELS_MUSIC:
            logg('ERROR: Unrecognized Master Level %s' % line, error=True)
            continue
        order.append(line)
    return order_file, order

def get_ml_mapinfo(wad_name, map_number):
    lines = []
    prefix = MASTER_LEVELS_MAP_PREFIX.upper()
    mapnum = str(map_number).rjust(2, '0')
    picnum = str(map_number - 1).rjust(2, '0')
    nextnum = str(map_number + 1).rjust(2, '0')
    lines.append('map %sMAP%s lookup "%s%s"' % (prefix, mapnum, prefix, wad_name.upper()))
    lines.append('{')
    next_map = '%sMAP%s' % (prefix, nextnum) if map_number < 20 else 'EndGameC'
    sky = MASTER_LEVELS_SKIES.get(wad_name, None) or 'RSKY1'
    music = MASTER_LEVELS_MUSIC[wad_name]
    author_lc = '%s_%s' % (MASTER_LEVELS_AUTHOR_PREFIX, MASTER_LEVELS_AUTHORS[wad_name])
    lines.append('    next = "%s"' % next_map)
    if wad_name == 'teeth':
        lines.append('    secretnext = "ML_MAP21"')
    lines.append('    sky1 = "%s"' % sky)
    lines.append('    music = "$MUSIC_%s"' % music)
    # (cluster # is defined in MASTER_LEVELS_MAPINFO_HEADER)
    lines.append('    Author = "$%s"' % author_lc)
    if wad_name in MASTER_LEVELS_MAP07_SPECIAL:
        lines.append('    map07special')
    # don't reset player for secret level
    if map_number != 21:
        lines.append('    ResetHealth')
        lines.append('    ResetInventory')
    lines.append('}')
    return lines

def extract_master_levels():
    # check if present first
    order_file, ml_map_order = get_master_levels_map_order()
    if len(ml_map_order) == 0:
        return
    first_ml_wad = get_wad_filename(ml_map_order[0])
    if not first_ml_wad:
        logg('ERROR: Master Levels not found.', error=True)
        copyfile(RES_DIR + 'mapinfo/master_levels.txt', DEST_DIR + 'mapinfo/master_levels.txt')
        return
    logg('Processing Master Levels...')
    mapinfo = open(ML_MAPINFO_FILENAME, 'w')
    mapinfo.write(MASTER_LEVELS_MAPINFO_HEADER % order_file)
    for i,wad_name in enumerate(ml_map_order):
        in_wad = omg.WAD()
        wad_filename = get_wad_filename(wad_name)
        if not wad_filename:
            logg("ERROR: Couldn't find %s" % wad_name, error=True)
            continue
        in_wad.from_file(wad_filename)
        out_wad_filename = DEST_DIR + 'maps/' + MASTER_LEVELS_MAP_PREFIX + 'map'
        # extra zero for <10 map numbers, eg map01
        out_wad_filename += str(i + 1).rjust(2, '0') + '.wad'
        logg('  Extracting %s to %s' % (wad_filename, out_wad_filename))
        # grab first map we find in each wad
        map_name = in_wad.maps.find('*')[0]
        extract_map(in_wad, map_name, out_wad_filename)
        # write data to mapinfo based on ordering
        mapinfo.writelines('\n'.join(get_ml_mapinfo(wad_name, i+1)))
        mapinfo.write('\n\n')
    # save teeth map32 to map21
    wad_filename = get_wad_filename('teeth')
    out_wad_filename = DEST_DIR + 'maps/' + MASTER_LEVELS_MAP_PREFIX + 'map21' + '.wad'
    logg('  Extracting %s map32 to %s' % (wad_filename, out_wad_filename))
    in_wad = omg.WAD()
    in_wad.from_file(wad_filename)
    extract_map(in_wad, in_wad.maps.find('*')[1], out_wad_filename)
    # write map21 mapinfo
    if ml_map_order.index('teeth') == 19:
        next_map = 'EndGameC'
    else:
        next_map = '%sMAP%s' % (MASTER_LEVELS_MAP_PREFIX.upper(),
                                ml_map_order.index('teeth') + 2)
    mapinfo.write(MASTER_LEVELS_SECRET_DEF % (next_map, MASTER_LEVELS_MUSIC['teeth2'],
                                              MASTER_LEVELS_AUTHOR_PREFIX, MASTER_LEVELS_AUTHORS['teeth2']))
    # finish mapinfo
    mapinfo.writelines([MASTER_LEVELS_CLUSTER_DEF])
    mapinfo.close()
    # extract sky lumps
    for wad_name,patch_replace in MASTER_LEVELS_PATCHES.items():
        wad = omg.WAD()
        wad_filename = get_wad_filename(wad_name)
        wad.from_file(wad_filename)
        # manor stores sky in patches namespace, combine and virgil don't
        if patch_replace[0] in wad.data:
            lump = wad.data[patch_replace[0]]
        else:
            lump = wad.patches[patch_replace[0]]
        out_filename = DEST_DIR + 'patches/' + patch_replace[1] + '.lmp'
        logg('  Extracting %s lump from %s as %s' % (patch_replace[0],
                                                   wad_filename,
                                                   patch_replace[1]))
        lump.to_file(out_filename)

def move_ogg():
    # move Andrew Hulshult's tracks to separate dest dir and remove .mus file extension from .ogg music
    for filename in os.listdir(DEST_DIR + 'music/'):
        if fnmatch.fnmatch(filename, '*.ogg.mus'):
            os.replace(DEST_DIR + 'music/' + filename, DEST_DIR_OGG_MUS + filename)
            old_name = os.path.join(DEST_DIR_OGG_MUS, filename)
            new_name = old_name.replace('.ogg.mus', '.ogg')
            os.rename(old_name, new_name)
    # duplicate tracks
    copyfile(DEST_DIR_OGG_MUS + 'D_E1M6.ogg', DEST_DIR_OGG_MUS + 'D_E3M6.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_E1M7.ogg', DEST_DIR_OGG_MUS + 'D_E2M5.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_E1M7.ogg', DEST_DIR_OGG_MUS + 'D_E3M5.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_E1M8.ogg', DEST_DIR_OGG_MUS + 'D_E3M4.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_E1M9.ogg', DEST_DIR_OGG_MUS + 'D_E3M9.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_E2M3.ogg', DEST_DIR_OGG_MUS + 'D_INTER.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_E2M7.ogg', DEST_DIR_OGG_MUS + 'D_E3M7.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_E2M9.ogg', DEST_DIR_OGG_MUS + 'D_E3M1.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_RUNNIN.ogg', DEST_DIR_OGG_MUS + 'D_RUNNI2.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_STALKS.ogg', DEST_DIR_OGG_MUS + 'D_STLKS2.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_STALKS.ogg', DEST_DIR_OGG_MUS + 'D_STLKS3.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_COUNTD.ogg', DEST_DIR_OGG_MUS + 'D_COUNT2.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_DOOM.ogg', DEST_DIR_OGG_MUS + 'D_DOOM2.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_THE_DA.ogg', DEST_DIR_OGG_MUS + 'D_THEDA2.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_THE_DA.ogg', DEST_DIR_OGG_MUS + 'D_THEDA3.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_SHAWN.ogg', DEST_DIR_OGG_MUS + 'D_SHAWN2.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_SHAWN.ogg', DEST_DIR_OGG_MUS + 'D_SHAWN3.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_DDTBLU.ogg', DEST_DIR_OGG_MUS + 'D_DDTBL2.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_DDTBLU.ogg', DEST_DIR_OGG_MUS + 'D_DDTBL3.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_DEAD.ogg', DEST_DIR_OGG_MUS + 'D_DEAD2.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_ROMERO.ogg', DEST_DIR_OGG_MUS + 'D_ROMER2.ogg')
    copyfile(DEST_DIR_OGG_MUS + 'D_MESSAG.ogg', DEST_DIR_OGG_MUS + 'D_MESSG2.ogg')

def rename_mp3():
    # remove .mus file extension from Sigil's .mp3 music if it's present
    for filename in os.listdir(DEST_DIR + 'music/'):
        old_name = os.path.join(DEST_DIR + 'music/', filename)
        new_name = old_name.replace('.mp3.mus', '.mp3')
        os.rename(old_name, new_name)

def enable_sigil_shreds():
    logg('Enabling Sigil MP3 music...')
    # switches ws_sigil_shreds cvar default to true
    shreds_false = 'ws_sigil_shreds = false'
    shreds_true = 'ws_sigil_shreds = true'
    with open(DEST_DIR + 'cvarinfo.txt', 'r') as file:
        tmp_file = file.read()
        tmp_file = tmp_file.replace(shreds_false, shreds_true)
    with open(DEST_DIR + 'cvarinfo.txt', 'w') as file:
        file.write(tmp_file)

def enable_sigil2_shreds():
    logg('Enabling Sigil II MP3 music...')
    # switches ws_sigil2_shreds cvar default to true
    shreds2_false = 'ws_sigil2_shreds = false'
    shreds2_true = 'ws_sigil2_shreds = true'
    with open(DEST_DIR + 'cvarinfo.txt', 'r') as file:
        tmp_file = file.read()
        tmp_file = tmp_file.replace(shreds2_false, shreds2_true)
    with open(DEST_DIR + 'cvarinfo.txt', 'w') as file:
        file.write(tmp_file)

def add_secret_level(map_src_filename, map_src_name, map_dest_name):
    global num_maps
    # copies given map file into dest dir and sets its map lump name
    src_filename = get_wad_filename(map_src_filename)
    dest_filename = DEST_DIR + 'maps/%s.wad' % map_dest_name
    copyfile(src_filename, dest_filename)
    wad = omg.WAD()
    wad.from_file(dest_filename)
    wad.maps.rename(map_src_name, map_dest_name)
    wad.to_file(dest_filename)
    num_maps += 1

def add_xbox_levels():
    # :P
    logg('Adding Xbox bonus levels...')
    if get_wad_filename('doom'):
        logg('  Adding SEWERS.WAD as E1M10')
        add_secret_level('sewers', 'E3M1', 'E1M10')
    if get_wad_filename('doom2'):
        logg('  Adding BETRAY.WAD as MAP33')
        add_secret_level('betray', 'MAP01', 'MAP33')

def enable_xbox_levels():
    # switches ws_xbox_secret_exits cvar default to true
    xbox_false = 'ws_xbox_secret_exits = false'
    xbox_true = 'ws_xbox_secret_exits = true'
    with open(DEST_DIR + 'cvarinfo.txt', 'r') as file:
        tmp_file = file.read()
        tmp_file = tmp_file.replace(xbox_false, xbox_true)
    with open(DEST_DIR + 'cvarinfo.txt', 'w') as file:
        file.write(tmp_file)

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
        logg('  Extracting map %s...' % map_name)
        out_wad_filename = DEST_DIR + 'maps/' + map_prefix + map_name + '.wad'
        extract_map(in_wad, map_name, out_wad_filename)
        #logg('  Saved map %s' % out_wad_filename)

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
            logg("ERROR: Couldn't identify type of lump list %s" % lump_list, error=True)
            continue
        # sigil sky lump isn't in patch namespace
        if lump_list == 'patches_sigil':
            lump_type = 'data'
        lump_table = getattr(wad, lump_type, None)
        if not lump_table:
            logg('  ERROR: Lump type %s not found' % lump_type, error=True)
            continue
        logg('  extracting %s...' % lump_list)
        # sigil sky is in data namespace but we want it in patches dir
        if wad_name == 'sigil' and lump_list == 'patches_sigil':
            lump_subdir = DEST_DIR + 'patches/'
        # sigil 1&2 screens aren't in graphics namespace but belong in that dir
        elif wad_name == 'sigil' and lump_type == 'data':
            lump_subdir = DEST_DIR + 'graphics/'
        elif wad_name == 'sigil2' and lump_type == 'data':
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
                logg("  ERROR: Couldn't find lump with name %s" % lump_name, error=True)
                continue
            lump = lump_table[lump_name]
            out_filename += '.lmp' if lump_type != 'music' else '.mus'
            logg('    Extracting %s' % lump_subdir + out_filename)
            lump.to_file(lump_subdir + out_filename)

def copy_resources():
    for src_file in RES_FILES:
        # don't copy texture lumps for files that aren't present
        if src_file.startswith('textures.doom1') and not get_wad_filename('doom'):
            continue
        elif src_file == 'textures.doom2' and not get_wad_filename('doom2'):
            # DO copy if final doom exists and doom2 doesn't
            if not get_wad_filename('tnt'):
                continue
        elif src_file == 'textures.tnt' and not get_wad_filename('tnt'):
            continue
        elif src_file == 'textures.plut' and not get_wad_filename('plutonia'):
            continue
        logg('Copying %s' % src_file)
        copyfile(RES_DIR + src_file, DEST_DIR + src_file)
#    # doom2 vs doom2bfg map31/32 names differ, different mapinfos with same name
#    d2wad = omg.WAD()
#    d2_wad_filename = get_wad_filename('doom2')
#    # neither doom2: mapinfo still wants a file for the secret levels
#    if not d2_wad_filename:
#        copyfile(RES_DIR + 'mapinfo/doom2_nonbfg_levels.txt',
#                 DEST_DIR + 'mapinfo/doom2_secret_levels.txt')
#        return
#    d2wad.from_file(d2_wad_filename)
#    # bfg version?
#    if d2wad.graphics.get(BFG_ONLY_LUMP, None):
#        copyfile(RES_DIR + 'mapinfo/doom2_bfg_levels.txt',
#                 DEST_DIR + 'mapinfo/doom2_secret_levels.txt')
#    else:
#        copyfile(RES_DIR + 'mapinfo/doom2_nonbfg_levels.txt',
#                 DEST_DIR + 'mapinfo/doom2_secret_levels.txt')

def copy_resources_id1():
    # copy id1 scripts if id1 is present
    copyfile(RES_DIR + 'zscript/ws_id1weap.zs', DEST_DIR + 'zscript/ws_id1weap.zs')
    copyfile(RES_DIR + 'zscript/ws_sbar.id1.zs', DEST_DIR + 'zscript/ws_sbar.zs')
    # uncomment scripts
    id1_off = '//#include \"zscript/ws_id1weap.zs\"\n//#include \"zscript/ws_sbar.zs\"'
    id1_on = '#include \"zscript/ws_id1weap.zs\"\n#include \"zscript/ws_sbar.zs\"'
    with open(DEST_DIR + 'zscript.zs', 'r') as file:
        tmp_file = file.read()
        tmp_file = tmp_file.replace(id1_off, id1_on)
    with open(DEST_DIR + 'zscript.zs', 'w') as file:
        file.write(tmp_file)
    # add event handler
    id1_off = '//, \"Id1WeaponHandler\"\n\tStatusBarClass = \"WadFusionStatusBar\"'
    id1_on = ', \"Id1WeaponHandler\"\n\tStatusBarClass = \"WadFusionStatusBarId24\"'
    with open(DEST_DIR + 'mapinfo.txt', 'r') as file:
        tmp_file = file.read()
        tmp_file = tmp_file.replace(id1_off, id1_on)
    with open(DEST_DIR + 'mapinfo.txt', 'w') as file:
        file.write(tmp_file)

def copy_resources_ogg():
    # unity vs kex extras.wad differ, kex has Andrew Hulshult soundtrack
    if get_wad_filename('extras'):
        extras_wad = omg.WAD()
        extras_wad_filename = get_wad_filename('extras')
        extras_wad.from_file(extras_wad_filename)
        if extras_wad.colormaps.get(EXTRAS_KEX_ONLY_LUMP, None):
            for src_file in RES_FILES_OGG:
                logg('Copying %s' % src_file)
                copyfile(RES_DIR + src_file, DEST_DIR_OGG + src_file)
            # move Andrew Hulshult's tracks to pk3_ogg
            move_ogg()
            # rename '.ogg' from filenames of pre-authored lumps
            for src_file in os.listdir(DEST_DIR_OGG + 'mapinfo/'):
                if fnmatch.fnmatch(src_file, '*.ogg.txt'):
                    old_name = os.path.join(DEST_DIR_OGG + 'mapinfo/', src_file)
                    new_name = old_name.replace('.ogg.txt', '.txt')
                    os.rename(old_name, new_name)

def get_report_found():
    found = []
    for wadname in REPORT_WADS:
        if get_wad_filename(wadname):
            found.append(wadname)
    # look for sigil by other names
    if 'doom' in found and not 'sigil' in found:
        for alt_name in SIGIL_ALT_FILENAMES:
            sigil_alt = get_wad_filename(alt_name)
            # rather than handle variable filename for it, just create
            # a copy in source_wads/ with the expected name
            if sigil_alt:
                copyfile(sigil_alt, SRC_WAD_DIR + 'sigil.wad')
                found.insert(1, 'sigil')
                break
    # same with sigil2
    # (TODO maybe some way to generalize this for future releases?)
    if 'doom' in found and not 'sigil2' in found:
        for alt_name in SIGIL2_ALT_FILENAMES:
            sigil2_alt = get_wad_filename(alt_name)
            if sigil2_alt:
                copyfile(sigil2_alt, SRC_WAD_DIR + 'sigil2.wad')
                found.insert(2, 'sigil2')
                break
    # ... and sigil2 mp3 soundtrack version
    if 'sigil2' in found and not 'sigil2_mp3' in found:
        for alt_name in SIGIL2_MP3_ALT_FILENAMES:
            sigil2_mp3_alt = get_wad_filename(alt_name)
            if sigil2_mp3_alt:
                copyfile(sigil2_mp3_alt, SRC_WAD_DIR + 'sigil2_mp3.wad')
                found.insert(3, 'sigil2_mp3')
                break
    return found

def clear_pk3():
    # clear out pk3 dir from previous runs
    files_tidied = 0
    for dirname,extensions in TIDY_DIR_EXTENSIONS.items():
        if not os.path.exists(DEST_DIR + dirname):
            continue
        for filename in os.listdir(DEST_DIR + dirname):
            for ext in extensions:
                if filename.endswith(ext):
                    filename = DEST_DIR + dirname + filename
                    if os.path.exists(filename):
                        os.remove(filename)
                        files_tidied += 1
    # clear out pk3_ogg dir from previous runs
    for dirname,extensions in TIDY_DIR_OGG.items():
        if not os.path.exists(DEST_DIR_OGG + dirname):
            continue
        for filename in os.listdir(DEST_DIR_OGG + dirname):
            for ext in extensions:
                if filename.endswith(ext):
                    filename = DEST_DIR_OGG + dirname + filename
                    if os.path.exists(filename):
                        os.remove(filename)
                        files_tidied += 1
    # clear out files in pk3 base dir too
    for filename in RES_FILES:
        # don't touch subdirs
        if filename != os.path.basename(filename):
            continue
        filename = DEST_DIR + filename
        if os.path.exists(filename):
            os.remove(filename)
            files_tidied += 1
    if files_tidied > 0:
        logg('Removed %s files from a previous run.' % files_tidied)

def get_eps(wads_found):
    eps = []
    for wadname in wads_found:
        if wadname == 'doom':
            eps += ['Knee Deep in the Dead', 'The Shores of Hell', 'Inferno', 'Thy Flesh Consumed']
        elif wadname == 'doom2':
            eps += ['Hell on Earth']
        elif wadname == 'attack' and 'doom2' in wads_found:
            eps += ['Master Levels']
        elif wadname == 'nerve' and 'doom2' in wads_found:
            eps += ['No Rest for the Living']
        elif wadname == 'tnt':
            eps += ['TNT: Evilution']
        elif wadname == 'plutonia':
            eps += ['The Plutonia Experiment']
        elif wadname == 'sigil' and 'doom' in wads_found:
            eps += ['Sigil']
        elif wadname == 'sigil2' and 'doom' in wads_found:
            eps += ['Sigil II']
        elif wadname == 'id1' and 'doom2' in wads_found and 'id1-res' in wads_found and 'id24res' in wads_found:
            eps += ['The Vulcan Abyss', 'Counterfeit Eden']
        elif wadname == 'iddm1' and 'doom2' in wads_found:
            eps += ['id Deathmatch Pack #1']
    return eps

def pk3_compress():
    logg('Compressing %s...' % DEST_FILENAME)
    pk3 = ZipFile(DEST_FILENAME, 'w', ZIP_DEFLATED)
    for dir_name, x, filenames in os.walk(DEST_DIR):
        for filename in filenames:
            src_name = dir_name + '/' + filename
            # exclude pk3/ top dir from name within archive
            dest_name = src_name[len(DEST_DIR):]
            pk3.write(src_name, dest_name)
    pk3.close()

def pk3_ogg_compress():
    # unity vs kex extras.wad differ, kex has Andrew Hulshult soundtrack
    start_time = time.time()
    extras_wad = omg.WAD()
    extras_wad_filename = get_wad_filename('extras')
    extras_wad.from_file(extras_wad_filename)
    if extras_wad.colormaps.get(EXTRAS_KEX_ONLY_LUMP, None):
        logg('Compressing %s...' % DEST_FILENAME_OGG)
        pk3_ogg = ZipFile(DEST_FILENAME_OGG, 'w', ZIP_DEFLATED)
        for dir_name, x, filenames in os.walk(DEST_DIR_OGG):
            for filename in filenames:
                src_name = dir_name + '/' + filename
                # exclude pk3_ogg/ top dir from name within archive
                dest_name = src_name[len(DEST_DIR_OGG):]
                pk3_ogg.write(src_name, dest_name)
        pk3_ogg.close()
    else:
        return
    elapsed_time_ogg = time.time() - start_time
    ipk3_ogg_size =  os.path.getsize(DEST_FILENAME_OGG) / 1000000
    logg('Generated %s (%.1f MB) in %.2f seconds.' % (DEST_FILENAME_OGG, ipk3_ogg_size, elapsed_time_ogg))

def main():
    version = open(VERSION_FILENAME).readlines()[0].strip()
    title_line = 'WadFusion v%s' % version
    logg(title_line + '\n' + '-' * len(title_line))
    found = get_report_found()
    input_func = raw_input if sys.version_info.major < 3 else input
    # bail if no wads in SRC_WAD_DIR
    if len(found) == 0:
        logg('No source WADs found!\nPlease place your WAD files into %s.' % os.path.realpath(SRC_WAD_DIR))
        logfile.close()
        input_func('Press Enter to exit.\n')
        return
    # clear out pk3 dir from previous runs
    clear_pk3()
    logg('Found in %s:\n  ' % SRC_WAD_DIR + ', '.join(found))
    print('A new PK3 format IWAD will be generated with the following episodes:')
    for num_eps,ep_name in enumerate(get_eps(found)):
        print('- %s' % ep_name)
    num_eps += 1
    i = input_func('Press Y and then Enter to proceed, anything else to cancel: ')
    if i.lower() != 'y':
        logg('Canceled.')
        logfile.close()
        return
    # make dirs if they don't exist
    if not os.path.exists(TEMP_DIR):
        os.mkdir(TEMP_DIR)
    if not os.path.exists(DEST_DIR):
        os.mkdir(DEST_DIR)
    for dirname in ['flats', 'graphics', 'music', 'maps', 'mapinfo',
                    'patches', 'sounds', 'sprites', 'zscript']:
        if not os.path.exists(DEST_DIR + dirname):
            os.mkdir(DEST_DIR + dirname)
    # make dirs for Andrew Hulshult's ogg music if they don't exist
    if get_wad_filename('extras'):
        extras_wad = omg.WAD()
        extras_wad_filename = get_wad_filename('extras')
        extras_wad.from_file(extras_wad_filename)
        # create folders only if the music is present
        if extras_wad.colormaps.get(EXTRAS_KEX_ONLY_LUMP, None):
            if not os.path.exists(DEST_DIR_OGG):
                os.mkdir(DEST_DIR_OGG)
            for dirname in ['music', 'mapinfo']:
                if not os.path.exists(DEST_DIR_OGG + dirname):
                    os.mkdir(DEST_DIR_OGG + dirname)
    # if final doom present but not doom1/2, extract doom2 resources from it
    if get_wad_filename('tnt') and not get_wad_filename('doom2'):
        WAD_LUMP_LISTS['tnt'] += DOOM2_LUMPS
        # if doom 1 also isn't present (weird) extract all common resources
        if not get_wad_filename('doom'):
            WAD_LUMP_LISTS['tnt'] += COMMON_LUMPS
    # if id1 present but not doom1, extract doom1 resources from it
    if get_wad_filename('id1') and not get_wad_filename('doom'):
        WAD_LUMP_LISTS['id1'] += ['patches_doom1']
    # if iddm1 present but not id1, extract id1 resources from it
    if get_wad_filename('iddm1') and not get_wad_filename('id1'):
        WAD_LUMP_LISTS['iddm1'] += ID1_LUMPS
    # if iddm1 present but not doom1, extract doom1 music from it
    if get_wad_filename('iddm1') and not get_wad_filename('doom'):
        WAD_LUMP_LISTS['iddm1'] += ['music_doom1', 'patches_doom1']
    # if iddm1 present but not tnt, extract tnt music from it
    if get_wad_filename('iddm1') and not get_wad_filename('tnt'):
        WAD_LUMP_LISTS['iddm1'] += ['music_iddm1']
    # extract lumps and maps from wads
    for iwad_name in WADS:
        wad_filename = get_wad_filename(iwad_name)
        if not wad_filename:
            logg('WAD %s not found' % iwad_name)
            continue
        if iwad_name == 'nerve' and not get_wad_filename('doom2'):
            logg('Skipping nerve.wad as doom2.wad is not present', error=True)
            continue
        if iwad_name == 'sigil' and not get_wad_filename('doom'):
            logg('Skipping sigil.wad as doom.wad is not present', error=True)
            continue
        if iwad_name == 'sigil_shreds' and not get_wad_filename('sigil'):
            logg('Skipping sigil_shreds.wad as sigil.wad is not present', error=True)
            continue
        if iwad_name == 'sigil2' and not get_wad_filename('doom'):
            logg('Skipping sigil2.wad as doom.wad is not present', error=True)
            continue
        if iwad_name == 'sigil2_mp3' and not get_wad_filename('sigil2'):
            logg('Skipping sigil2_mp3.wad as sigil2.wad is not present', error=True)
            continue
        if iwad_name == 'id1' and not get_wad_filename('doom2'):
            logg('Skipping id1.wad as doom2.wad is not present', error=True)
            continue
        if iwad_name == 'id1' and not get_wad_filename('id1-res'):
            logg('Skipping id1.wad as id1-res.wad is not present', error=True)
            continue
        if iwad_name == 'id1' and not get_wad_filename('id24res'):
            logg('Skipping id1.wad as id24res.wad is not present', error=True)
            continue
        if iwad_name == 'iddm1'and not get_wad_filename('doom2'):
            logg('Skipping iddm1.wad as doom2.wad is not present', error=True)
            continue
        logg('Processing WAD %s...' % iwad_name)
        if should_extract:
            extract_lumps(iwad_name)
            prefix = WAD_MAP_PREFIXES.get(iwad_name, None)
            # check None, not empty string!
            if prefix is not None:
                extract_iwad_maps(iwad_name, prefix)
    if get_wad_filename('doom2'):
        if should_extract:
            extract_master_levels()
    else:
        logg('Skipping Master Levels as doom2.wad is not present', error=True)
        copyfile(RES_DIR + 'mapinfo/master_levels.txt', DEST_DIR + 'mapinfo/master_levels.txt')
    # copy pre-authored lumps eg mapinfo
    if should_extract:
        copy_resources()
    # copy id1 scripts if id1 is present
    if get_wad_filename('id1') and get_wad_filename('id1-res') and get_wad_filename('id24res') and should_extract:
        copy_resources_id1()
    # copy pre-authored lumps for Andrew Hulshult's soundtrack supported
    if should_extract:
        copy_resources_ogg()
    # rename file extensions of Sigil mp3 music
    if should_extract:
        rename_mp3()
    # enable Sigil mp3 music options
    if get_wad_filename('sigil_shreds') and get_wad_filename('sigil') and should_extract:
        enable_sigil_shreds()
    if get_wad_filename('sigil2_mp3') and get_wad_filename('sigil2') and should_extract:
        enable_sigil2_shreds()
    # only supported versions of these @ http://classicdoom.com/xboxspec.htm
    if get_wad_filename('sewers') and get_wad_filename('betray') and should_extract:
        add_xbox_levels()
        enable_xbox_levels()
    # copy custom GENMIDI, if user hasn't deleted it
    genmidi_filename = 'GENMIDI.lmp'
    if os.path.exists(RES_DIR + genmidi_filename):
        logg('Copying %s' % genmidi_filename)
        copyfile(RES_DIR + genmidi_filename, DEST_DIR + genmidi_filename)
    # create pk3
    start_time = time.time()
    pk3_compress()
    elapsed_time = time.time() - start_time
    ipk3_size =  os.path.getsize(DEST_FILENAME) / 1000000
    logg('Generated %s (%.1f MB) with %s maps in %s episodes in %.2f seconds.' % (DEST_FILENAME, ipk3_size, num_maps, num_eps, elapsed_time))
    # create pk3_ogg
    if get_wad_filename('extras'):
        pk3_ogg_compress()
    logg('Done!')
    if num_errors > 0:
        logg('%s errors found, see %s for details.' % (num_errors, LOG_FILENAME))
    input_func('Press Enter to exit.\n')
    clear_pk3()
    logfile.close()

if __name__ == "__main__":
    main()
