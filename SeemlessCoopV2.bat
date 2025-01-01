@echo off


:: COPY YOUR PATH HERE
SET DEST_PATH=C:\Program Files (x86)\Steam\steamapps\common\ELDEN RING\Game

:: Rename the settings file
ren "%DEST_PATH%\SeamlessCoop\ersc_settings.ini" _ersc_settings.ini

:: Download the latest version of ersc.zip
curl -LO https://github.com/LukeYui/EldenRingSeamlessCoopRelease/releases/latest/download/ersc.zip

:: Extract the ZIP file to the destination path
powershell -Command "Expand-Archive ersc.zip -DestinationPath '%DEST_PATH%' -Force"


:: Check if there is settings file from before and not a fresh install
IF EXIST "%DEST_PATH%\SeamlessCoop\_ersc_settings.ini" (

:: Delete the fresh settings file
del "%DEST_PATH%\SeamlessCoop\ersc_settings.ini"

:: Restore the already existing settings file
ren "%DEST_PATH%\SeamlessCoop\_ersc_settings.ini" ersc_settings.ini
)

:: Clean up the downloaded ZIP file
del ersc.zip

:: Define variables
set "shortcutName=Elden Ring co-op.lnk"
set "shortcutPath=%UserProfile%\Desktop\%shortcutName%"
set "exePath=%DEST_PATH%\ersc_launcher.exe"
set "startInPath=%DEST_PATH%"

:: Use PowerShell to create the shortcut
powershell -NoProfile -Command "& { $Shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut('%shortcutPath%'); $Shortcut.TargetPath = '%exePath%'; $Shortcut.WorkingDirectory = '%startInPath%'; $Shortcut.Save(); }"

echo Shortcut template created on your desktop: %shortcutPath%

