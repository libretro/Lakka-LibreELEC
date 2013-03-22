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
>NUL copy 3rdparty\syslinux\vesamenu.c32 %DRIVE%
>NUL copy splash.png %DRIVE%

FOR /F "tokens=5" %%G IN ('vol %DRIVE% ^|find "-"') DO SET DRIVEUUID=%%G
ECHO UI vesamenu.c32 > %DRIVE%\syslinux.cfg
ECHO PROMPT 0 >> %DRIVE%\syslinux.cfg
ECHO MENU TITLE Boot Menu >> %DRIVE%\syslinux.cfg
ECHO MENU BACKGROUND splash.png >> %DRIVE%\syslinux.cfg
ECHO TIMEOUT 50 >> %DRIVE%\syslinux.cfg
ECHO DEFAULT live >> %DRIVE%\syslinux.cfg
ECHO. >> %DRIVE%\syslinux.cfg
ECHO MENU WIDTH 70 >> %DRIVE%\syslinux.cfg
ECHO MENU MARGIN 15 >> %DRIVE%\syslinux.cfg
ECHO MENU ROWS 2 >> %DRIVE%\syslinux.cfg
ECHO MENU HSHIFT 4 >> %DRIVE%\syslinux.cfg
ECHO MENU VSHIFT 13 >> %DRIVE%\syslinux.cfg
ECHO MENU TIMEOUTROW 10 >> %DRIVE%\syslinux.cfg
ECHO MENU TABMSGROW 8 >> %DRIVE%\syslinux.cfg
ECHO MENU CMDLINEROW 8 >> %DRIVE%\syslinux.cfg
ECHO MENU HELPMSGROW 13 >> %DRIVE%\syslinux.cfg
ECHO MENU HELPMSGENDROW 26 >> %DRIVE%\syslinux.cfg
ECHO MENU CLEAR >> %DRIVE%\syslinux.cfg
ECHO. >> %DRIVE%\syslinux.cfg
ECHO MENU COLOR border       30;44   #40ffffff #00000000 std >> %DRIVE%\syslinux.cfg
ECHO MENU COLOR title        1;36;44 #ff8bbfe3 #00000000 std >> %DRIVE%\syslinux.cfg
ECHO MENU COLOR sel          7;37;40 #80f0f0f0 #ff606060 all >> %DRIVE%\syslinux.cfg
ECHO MENU COLOR unsel        37;44   #50ffffff #00000000 std >> %DRIVE%\syslinux.cfg
ECHO MENU COLOR help         37;40   #c0ffffff #a0000000 std >> %DRIVE%\syslinux.cfg
ECHO MENU COLOR timeout_msg  37;40   #80ffffff #00000000 std >> %DRIVE%\syslinux.cfg
ECHO MENU COLOR timeout      1;37;40 #c0ffffff #00000000 std >> %DRIVE%\syslinux.cfg
ECHO MENU COLOR msg07        37;40   #90ffffff #a0000000 std >> %DRIVE%\syslinux.cfg
ECHO MENU COLOR tabmsg       31;40   #ff868787 #00000000 std >> %DRIVE%\syslinux.cfg
ECHO.  >> %DRIVE%\syslinux.cfg
ECHO LABEL installer >> %DRIVE%\syslinux.cfg
ECHO   MENU LABEL Run OpenELEC Installer >> %DRIVE%\syslinux.cfg
ECHO   KERNEL /KERNEL >> %DRIVE%\syslinux.cfg
ECHO   APPEND boot=LABEL=OPENELEC installer quiet vga=current >> %DRIVE%\syslinux.cfg
ECHO. >> %DRIVE%\syslinux.cfg
ECHO LABEL live >> %DRIVE%\syslinux.cfg
ECHO   MENU LABEL Run OpenELEC Live >> %DRIVE%\syslinux.cfg
ECHO   KERNEL /KERNEL >> %DRIVE%\syslinux.cfg
ECHO   APPEND boot=LABEL=OPENELEC disk=FILE=STORAGE,512 quiet vga=current >> %DRIVE%\syslinux.cfg
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
