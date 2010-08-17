@ECHO OFF
CLS
ECHO.
ECHO              OpenELEC.tv USB Installer
ECHO.
ECHO.
ECHO ******************************************************
ECHO. 
ECHO This will wipe any data off your chosen drive
ECHO Please read the instructions and use very carefully...
ECHO.
ECHO ******************************************************
ECHO.
ECHO.
ECHO Enter USB Drive letter
ECHO eg. d:
ECHO.
SET /P DRIVE= -- 
format %DRIVE% /V:INSTALL /Q /FS:FAT32
3rdparty\syslinux\win32\syslinux.exe -f -m -a %DRIVE%
copy target\* %DRIVE%
copy sample.conf\syslinux_installer.cfg %DRIVE%\syslinux.cfg
SET DRIVE=