set ZIP_EXE="%ProgramW6432%\7-Zip\7z.exe"
set PINST_EXE="pyinstaller.exe"
set PROJ_NAME="wadfusion"
set GAME_NAME="doom_fusion"

%PINST_EXE% %PROJ_NAME%.spec
xcopy /E data\*.* dist\data\
xcopy /E res\*.* dist\res\
xcopy README.md dist\
xcopy CHANGES.md dist\
xcopy source_wads\delete_me.txt dist\source_wads\
%ZIP_EXE% a -r -tzip -mx=9 -mm=Deflate dist\licenses.zip .\licenses\*
del /Q %PROJ_NAME%_win.zip
%ZIP_EXE% a -r -tzip -mx=9 -mm=Deflate %PROJ_NAME%_win.zip .\dist\*
xcopy licenses\*wide*pix*.txt ultrawiderpix\
del /Q %GAME_NAME%_widescreen_gfx.pk3
%ZIP_EXE% a -r -tzip -mx=9 -mm=Deflate %GAME_NAME%_widescreen_gfx.pk3 .\ultrawiderpix\*
del /Q ultrawiderpix\*.txt
rmdir /S /Q build\
rmdir /S /Q dist\
