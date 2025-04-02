set ZIP_EXE="%ProgramW6432%\7-Zip\7z.exe"
set PROJ_NAME="wadsmoosh"

python -m PyInstaller -F wadsmoosh.py
pause
xcopy /E data\*.* dist\data\
xcopy /E res\*.* dist\res\
xcopy omg\*.* dist\omg\
xcopy /E source_wads\delete_me.txt dist\source_wads\
xcopy %PROJ_NAME%.py dist\
xcopy %PROJ_NAME%_data.py dist\
xcopy wadsmoo.sh dist\
xcopy version dist\
xcopy *.txt dist\
xcopy README.md dist\
%ZIP_EXE% a -r %PROJ_NAME%_win.zip .\dist\*
