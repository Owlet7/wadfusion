set ZIP_EXE="%ProgramW6432%\7-Zip\7z.exe"
set PROJ_NAME="wadfusion"
set GAME_NAME="doom_fusion"
set WIDEGFX="%GAME_NAME%_widescreen_gfx.pk3"

xcopy licenses\*wide*pix*.txt ultrawiderpix\
del /Q %WIDEGFX%
%ZIP_EXE% a -r -tzip -mx=9 -mm=Deflate %WIDEGFX% .\ultrawiderpix\*
del /Q ultrawiderpix\*.txt

rmdir /S /Q omg\__pycache__\
xcopy /E data\*.* dist\data\
xcopy /E omg\*.* dist\omg\
xcopy /E res\*.* dist\res\
xcopy README.md dist\
xcopy CHANGES.md dist\
xcopy %PROJ_NAME%.py dist\
xcopy %PROJ_NAME%_data.py dist\
xcopy source_wads\place_wads_here.txt dist\source_wads\
xcopy %WIDEGFX% dist\
%ZIP_EXE% a -r -tzip -mx=9 -mm=Deflate dist\licenses.zip .\licenses\*
del /Q %PROJ_NAME%_py.zip
%ZIP_EXE% a -r -tzip -mx=9 -mm=Deflate %PROJ_NAME%_py.zip .\dist\*
rmdir /S /Q dist\

python -m PyInstaller %PROJ_NAME%.spec
xcopy README.md dist\
xcopy CHANGES.md dist\
xcopy source_wads\place_wads_here.txt dist\source_wads\
xcopy %WIDEGFX% dist\
%ZIP_EXE% a -r -tzip -mx=9 -mm=Deflate dist\licenses.zip .\licenses\*
del /Q %PROJ_NAME%_win.zip
%ZIP_EXE% a -r -tzip -mx=9 -mm=Deflate %PROJ_NAME%_win.zip .\dist\*
rmdir /S /Q build\
rmdir /S /Q dist\
