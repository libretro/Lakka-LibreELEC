@ECHO OFF
TITLE OpenELEC LIVE USB Installer
mode con:cols=67 lines=17
COLOR 17
SET DRIVE=

:checkPrivileges
mkdir "%windir%\OEAdminCheck"
if '%errorlevel%' == '0' (
rmdir "%windir%\OEAdminCheck" & goto gotPrivileges 
) else ( goto getPrivileges )

:getPrivileges
CLS
ECHO.
ECHO.
ECHO                     OpenELEC LIVE USB Installer
ECHO.
ECHO.
ECHO  *****************************************************************
ECHO.
ECHO      Administrator Rights are required for USB Stick creation
ECHO               Invoking UAC for Privilege Escalation
ECHO.
ECHO  *****************************************************************
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
ECHO UAC.ShellExecute %0, "", "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%temp%\OEgetPrivileges.vbs"
exit /B

:gotPrivileges
if exist "%temp%\OEgetPrivileges.vbs" ( del "%temp%\OEgetPrivileges.vbs" )
pushd "%~dp0"

:HashCheck
".\3rdparty\md5sum\md5sum.exe" -c ".\target\SYSTEM.md5"
IF ERRORLEVEL 1 GOTO BadMD5
".\3rdparty\md5sum\md5sum.exe" -c ".\target\KERNEL.md5"
IF ERRORLEVEL 1 GOTO BadMD5

:InstallOE
CLS
ECHO.
ECHO.
ECHO                     OpenELEC LIVE USB Installer
ECHO.
ECHO.
ECHO  *****************************************************************
ECHO.
ECHO          This WILL wipe ALL data off the selected drive
ECHO                      Please use carefully...
ECHO.
ECHO  *****************************************************************
ECHO.
ECHO.

:SelectDrive
ECHO Enter USB Drive letter
ECHO eg. d:
ECHO.

SET /P DRIVE= -- 
IF NOT DEFINED DRIVE goto InvalidDrive
if %DRIVE%==c: goto InvalidDrive
if %DRIVE%==C: goto InvalidDrive

CLS
ECHO.
ECHO.
ECHO                     OpenELEC LIVE USB Installer
ECHO.
ECHO.
ECHO  *****************************************************************
ECHO.
ECHO                     Installing OpenELEC to %DRIVE%
ECHO              Please wait approximately 20 seconds...
ECHO.
ECHO  *****************************************************************
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.

ECHO. | >NUL format %DRIVE% /V:OPENELEC /Q /FS:FAT32 /X
IF ERRORLEVEL 1 goto InvalidDrive
>NUL 3rdparty\syslinux\win32\syslinux.exe -f -m -a %DRIVE%
>NUL copy target\* %DRIVE%
>NUL copy CHANGELOG %DRIVE%
>NUL copy INSTALL %DRIVE%
>NUL copy README.md %DRIVE%
>NUL copy RELEASE %DRIVE%
>NUL copy openelec.ico %DRIVE%

FOR /F "tokens=5" %%G IN ('vol %DRIVE% ^|find "-"') DO SET DRIVEUUID=%%G
ECHO PROMPT 0 >> %DRIVE%\syslinux.cfg
ECHO DEFAULT installer >> %DRIVE%\syslinux.cfg
ECHO. >> %DRIVE%\syslinux.cfg
ECHO LABEL installer >> %DRIVE%\syslinux.cfg
ECHO   KERNEL /KERNEL >> %DRIVE%\syslinux.cfg
ECHO   APPEND boot=LABEL=OPENELEC installer quiet tty >> %DRIVE%\syslinux.cfg
ECHO. >> %DRIVE%\syslinux.cfg
GOTO END

:InvalidDrive
CLS
ECHO.
ECHO.
ECHO                     OpenELEC LIVE USB Installer
ECHO.
ECHO.
ECHO  *****************************************************************
ECHO.
ECHO                     Invalid Drive Selected...
ECHO         Please confirm the drive letter of your USB stick
ECHO.
ECHO  *****************************************************************
ECHO.
ECHO.
GOTO SelectDrive

:BadMD5
CLS
ECHO.
ECHO.
ECHO                     OpenELEC LIVE USB Installer
ECHO.
ECHO.
ECHO  *****************************************************************
ECHO.
ECHO       OpenELEC failed md5 check - Installation will now quit
ECHO.
ECHO             Your original download is probably corrupt
ECHO       Please visit www.openelec.tv and download another copy
ECHO.
ECHO  *****************************************************************
ECHO.
ECHO.
ECHO.
PAUSE
EXIT

:END
CLS
ECHO.
ECHO.
ECHO                     OpenELEC LIVE USB Installer
ECHO.
ECHO.
ECHO  *****************************************************************
ECHO.
ECHO  The OpenELEC LIVE USB Installer has been successfully copied to %DRIVE%
ECHO             Please boot your HTPC off this USB stick
ECHO.
ECHO  *****************************************************************
ECHO.
ECHO.
ECHO.
ECHO.

popd
SET DRIVE=
SET DRIVEUUID=
PAUSE
