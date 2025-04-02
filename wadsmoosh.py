
import os, sys, time
from shutil import copyfile
from zipfile import ZipFile, ZIP_STORED, ZIP_DEFLATED

import omg

VERSION_FILENAME = 'version'

# if False, do a dry run with no actual file writing
should_extract = True
# if True apply light + fast compression; if False, simply store
should_deflate = False

SRC_WAD_DIR = 'source_wads/'
DATA_DIR = 'data/'
DEST_DIR = 'pk3/'
DEST_FILENAME = 'doom_complete.pk3'
LOG_FILENAME = 'wadsmoosh.log'
RES_DIR = 'res/'
DATA_TABLES_FILE = 'wadsmoosh_data.py'
ML_ORDER_FILENAME = 'masterlevels_order_xaser.txt'
ML_MAPINFO_FILENAME = DEST_DIR + 'mapinfo/masterlevels.txt'

# forward-declare all the stuff in DATA_TABLES_FILE for clarity
RES_FILES = []
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
BFG_ONLY_LUMP = ''

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

def add_secret_exit(map_name, line_id):
    # sets given line # in given map as a secret exit switch
    wad = omg.WAD()
    wad_filename = DEST_DIR + 'maps/%s.wad' % map_name
    wad.from_file(wad_filename)
    ed = omg.MapEditor(wad.maps[map_name])
    ed.linedefs[line_id].__dict__['action'] = 51
    wad.maps[map_name] = ed.to_lumps()
    wad.to_file(wad_filename)

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
        logg('  Adding secret exit to E1M1')
        add_secret_exit('E1M1', 268)
        logg('  Adding SEWERS.WAD as E1M10')
        add_secret_level('sewers', 'E3M1', 'E1M10')
    if get_wad_filename('doom2'):
        logg('  Adding secret exit to MAP02')
        add_secret_exit('MAP02', 283)
        logg('  Adding BETRAY.WAD as MAP33')
        add_secret_level('betray', 'MAP01', 'MAP33')

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
    # doom2 vs doom2bfg map31/32 names differ, different mapinfos with same name
    d2wad = omg.WAD()
    d2_wad_filename = get_wad_filename('doom2')
    # neither doom2: mapinfo still wants a file for the secret levels
    if not d2_wad_filename:
        copyfile(RES_DIR + 'mapinfo/doom2_nonbfg_levels.txt',
                 DEST_DIR + 'mapinfo/doom2_secret_levels.txt')
        return
    d2wad.from_file(d2_wad_filename)
    # bfg version?
    if d2wad.graphics.get(BFG_ONLY_LUMP, None):
        copyfile(RES_DIR + 'mapinfo/doom2_bfg_levels.txt',
                 DEST_DIR + 'mapinfo/doom2_secret_levels.txt')
    else:
        copyfile(RES_DIR + 'mapinfo/doom2_nonbfg_levels.txt',
                 DEST_DIR + 'mapinfo/doom2_secret_levels.txt')

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
    return found

def get_eps(wads_found):
    eps = []
    for wadname in wads_found:
        if wadname == 'doom':
            eps += ['Knee Deep in the Dead', 'The Shores of Hell', 'Inferno', 'Thy Flesh Consumed']
        elif wadname == 'doom2':
            eps += ['Hell on Earth']
        elif wadname == 'nerve' and 'doom2' in wads_found:
            eps += ['No Rest for the Living']
        elif wadname == 'attack' and 'doom2' in wads_found:
            eps += ['The Master Levels']
        elif wadname == 'tnt':
            eps += ['TNT: Evilution']
        elif wadname == 'plutonia':
            eps += ['The Plutonia Experiment']
        elif wadname == 'sigil' and 'doom' in wads_found:
            eps += ['Sigil']
        elif wadname == 'sigil2' and 'doom' in wads_found:
            eps += ['Sigil II']
    return eps

def main():
    start_time = time.time()
    version = open(VERSION_FILENAME).readlines()[0].strip()
    title_line = 'WadSmoosh v%s' % version
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
    if not os.path.exists(DEST_DIR):
        os.mkdir(DEST_DIR)
    for dirname in ['flats', 'graphics', 'music', 'maps', 'mapinfo',
                    'patches', 'sounds', 'sprites']:
        if not os.path.exists(DEST_DIR + dirname):
            os.mkdir(DEST_DIR + dirname)
    # copy pre-authored lumps eg mapinfo
    if should_extract:
        copy_resources()
    # if final doom present but not doom1/2, extract doom2 resources from it
    if get_wad_filename('tnt') and not get_wad_filename('doom2'):
        WAD_LUMP_LISTS['tnt'] += DOOM2_LUMPS
        # if doom 1 also isn't present (weird) extract all common resources
        if not get_wad_filename('doom'):
            WAD_LUMP_LISTS['tnt'] += COMMON_LUMPS
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
            logg('Skipping SIGIL.wad as doom.wad is not present', error=True)
            continue
        if iwad_name == 'sigil_shreds' and not get_wad_filename('sigil'):
            logg('Skipping SIGIL_SHREDS.wad as SIGIL.wad is not present', error=True)
            continue
        if iwad_name == 'sigil2' and not get_wad_filename('doom'):
            logg('Skipping sigil2.wad as doom.wad is not present', error=True)
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
    # only supported versions of these @ http://classicdoom.com/xboxspec.htm
    if get_wad_filename('sewers') and get_wad_filename('betray') and should_extract:
        add_xbox_levels()
    # copy custom GENMIDI, if user hasn't deleted it
    genmidi_filename = 'GENMIDI.lmp'
    if os.path.exists(RES_DIR + genmidi_filename):
        logg('Copying %s' % genmidi_filename)
        copyfile(RES_DIR + genmidi_filename, DEST_DIR + genmidi_filename)
    # create pk3
    logg('Compressing %s...' % DEST_FILENAME)
    pk3 = ZipFile(DEST_FILENAME, 'w', ZIP_DEFLATED if should_deflate else ZIP_STORED)
    for dir_name, x, filenames in os.walk(DEST_DIR):
        for filename in filenames:
            src_name = dir_name + '/' + filename
            # exclude pk3/ top dir from name within archive
            dest_name = src_name[len(DEST_DIR):]
            pk3.write(src_name, dest_name)
    pk3.close()
    logg('Done!')
    elapsed_time = time.time() - start_time
    ipk3_size =  os.path.getsize(DEST_FILENAME) / 1000000
    logg('Generated %s (%.1f MB) with %s maps in %s episodes in %.2f seconds.' % (DEST_FILENAME, ipk3_size, num_maps, num_eps, elapsed_time))
    if num_errors > 0:
        logg('%s errors found, see %s for details.' % (num_errors, LOG_FILENAME))
    input_func('Press Enter to exit.\n')
    logfile.close()

if __name__ == "__main__":
    main()
