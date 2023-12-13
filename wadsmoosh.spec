# -*- mode: python -*-

import sys
sys.modules['FixTk'] = None

block_cipher = None

a = Analysis(['wadsmoosh.py'],
             pathex=['e:\\wadsmoosh'],
             binaries=[],
             datas=[],
             hiddenimports=[],
             hookspath=[],
             runtime_hooks=[],
             # junk we don't need - omg requires hashlib tho!
             excludes=['FixTk', 'tcl', 'tk', '_tkinter', 'tkinter', 'Tkinter',
                'PIL', 'bz2', 'ctypes', 'lzma', 'socket', 'ssl'],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher)
pyz = PYZ(a.pure, a.zipped_data,
             cipher=block_cipher)
exe = EXE(pyz,
          a.scripts,
          exclude_binaries=True,
          name='wadsmoosh',
          debug=False,
          strip=False,
          upx=True,
          console=True )
coll = COLLECT(exe,
               a.binaries,
               a.zipfiles,
               a.datas,
               strip=False,
               upx=True,
               name='wadsmoosh')
