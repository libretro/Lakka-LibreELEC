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
ECHO. Are you running this USB Wizard for the first time 
ECHO. on Windows 7 or Windows Vista? [Y/N]
ECHO.
ECHO.

SET /P OS= --
IF "%OS%"=="n" GOTO INSTALL 
IF "%OS%"=="N" GOTO INSTALL 

:NOTES
CLS
ECHO.
ECHO ******************************************************
ECHO. 
ECHO.
ECHO Due to UAC in Windows 7 / Windows Vista we need to run
ECHO syslinux.exe as 'Administrator'
ECHO.
ECHO After pressing any key the folder containing syslinux.exe
ECHO will pop up automatically.
ECHO.
ECHO 1. Right click on syslinux.exe
ECHO 2. Click on 'Properties' 
ECHO 3. Change to the 'Compatibility' tab
ECHO 4. Check the 'Run this program as an administrator' checkbox
ECHO.
ECHO Click Ok and run 'create_installstick.bat' again,
ECHO answering 'N' to the first prompt
ECHO.
ECHO.
ECHO ******************************************************
ECHO.
pause
cmd /k "start %CD%\3rdparty\syslinux\win32"
GOTO END

:INSTALL
3rdparty\md5sum\md5sum.exe -c --status %CD%\target\SYSTEM.md5
IF ERRORLEVEL 1 GOTO BADMD5
3rdparty\md5sum\md5sum.exe -c --status %CD%\target\KERNEL.md5
IF ERRORLEVEL 1 GOTO BADMD5
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
if %DRIVE%!==! goto INSTALL
format %DRIVE% /V:INSTALL /Q /FS:FAT32
3rdparty\syslinux\win32\syslinux.exe -f -m -a %DRIVE%
copy target\* %DRIVE%
copy sample.conf\syslinux_installer.cfg %DRIVE%\syslinux.cfg
GOTO END

:BADMD5
CLS
ECHO.
ECHO.
ECHO  ***** OpenELEC.tv failed md5 check - Installation will quit *****
ECHO.
ECHO.
ECHO.
ECHO          Your original download was probably corrupt.
ECHO          Please visit www.openelec.tv and get another copy
ECHO.
ECHO.
PAUSE

:END
SET DRIVE=
SET OS=