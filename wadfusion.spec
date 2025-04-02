# -*- mode: python ; coding: utf-8 -*-


import sys
sys.modules['FixTk'] = None

block_cipher = None

a = Analysis(
    ['wadfusion.py'],
    pathex=[],
    binaries=[],
    datas= [ ( 'wadfusion_data.py', '.' ), ( 'data', 'data' ), ( 'res', 'res' ) ],
    hiddenimports=[],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    # junk we don't need - omg requires hashlib tho!
    excludes=['FixTk', 'tcl', 'tk', '_tkinter', 'tkinter', 'Tkinter',
              'PIL', 'bz2', 'lzma', 'socket', 'ssl'],
    noarchive=False,
    optimize=0,
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher
)
pyz = PYZ(a.pure, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='wadfusion',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)
