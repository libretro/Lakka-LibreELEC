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
ECHO.
ECHO.
ECHO ******************************************************
ECHO.
ECHO Press any key to open the syslinux directory
ECHO.
pause >NUL
explorer "%CD%\3rdparty\syslinux\win32"
ECHO When finished changing the administrator rights,
ECHO please press any key to continue with the installation
pause >NUL
GOTO :INSTALL 

:INSTALL
3rdparty\md5sum\md5sum.exe -c "%CD%\target\SYSTEM.md5"
IF ERRORLEVEL 1 GOTO BADMD5
3rdparty\md5sum\md5sum.exe -c "%CD%\target\KERNEL.md5"
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
format %DRIVE% /V:OPENELEC /Q /FS:FAT32
3rdparty\syslinux\win32\syslinux.exe -f -m -a %DRIVE%
ECHO Copying necessary files to %DRIVE%
copy target\* %DRIVE%
copy Autorun.inf %DRIVE%
copy CHANGELOG %DRIVE%
copy INSTALL %DRIVE%
copy README %DRIVE%
copy RELEASE %DRIVE%
copy openelec.ico %DRIVE%
FOR /F "tokens=5" %%G IN ('vol %DRIVE% ^|find "-"') DO SET DRIVEUUID=%%G
echo DEFAULT linux > %DRIVE%\syslinux.cfg
echo PROMPT 0 >> %DRIVE%\syslinux.cfg
echo. >> %DRIVE%\syslinux.cfg
echo LABEL linux >> %DRIVE%\syslinux.cfg
echo KERNEL /KERNEL >> %DRIVE%\syslinux.cfg
echo APPEND boot=UUID=%DRIVEUUID% installer quiet >> %DRIVE%\syslinux.cfg
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
SET DRIVEUUID=