set ZIP_EXE="%ProgramW6432%\7-Zip\7z.exe"
set PINST_EXE="pyinstaller.exe"
set PROJ_NAME="wadfusion"

%PINST_EXE% %PROJ_NAME%.spec
pause
xcopy /E data\*.* dist\data\
xcopy /E res\*.* dist\res\
xcopy README.md dist\
xcopy changelog.txt dist\
xcopy source_wads\delete_me.txt dist\source_wads\
%ZIP_EXE% a -r dist\licenses.zip .\licenses\*
%ZIP_EXE% a -r %PROJ_NAME%_win.zip .\dist\*
