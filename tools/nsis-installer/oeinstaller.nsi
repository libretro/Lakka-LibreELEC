VIProductVersion "1.0.0.0"
VIAddVersionKey ProductName "OpenELEC USB Stick Creator"
VIAddVersionKey Comments "A bootable OpenElec Installer Stick creation tool."
VIAddVersionKey CompanyName "OpenELEC"
VIAddVersionKey LegalCopyright "OpenELEC"
VIAddVersionKey FileDescription "OpenELEC USB Stick Creator"
VIAddVersionKey FileVersion "1.0"
VIAddVersionKey ProductVersion "1.0"
VIAddVersionKey InternalName "OpenELEC USB Stick Creator"

!define PRODUCT_NAME "OpenELEC USB Stick Creator"
!define PRODUCT_VERSION "1.0"
!define PRODUCT_PUBLISHER "OpenELEC"
!define PRODUCT_WEB_SITE "http://openelec.tv"
BrandingText " "

Var "SLET"
Var "SNUM"

!include "MUI.nsh"
!include LogicLib.nsh
!include FileFunc.nsh
!insertmacro GetDrives

!define GENERIC_READ 0x80000000
!define GENERIC_WRITE 0x40000000
!define FILE_SHARE_READ 0x00000001
!define FILE_SHARE_WRITE 0x00000002
!define OPEN_EXISTING 3
!define INVALID_HANDLE_VALUE -1
!define MAXLEN_VOLUME_GUID 51
!define IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS 0x00560000
!define EXTENTS_BUFFER_SIZE 512

!define MUI_ICON "openelec.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "welcome.bmp"
!define MUI_ABORTWARNING

!define MUI_WELCOMEPAGE_TITLE "Welcome to the OpenELEC USB Stick Creator"
!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the creation of an OpenELEC USB Installer Stick.\n\nPlease read the following pages carefully."
!insertmacro MUI_PAGE_WELCOME

!define MUI_PAGE_HEADER_TEXT "License Agreement"
!define MUI_PAGE_HEADER_SUBTEXT "Please review the GPLv2 license below before using the OpenELEC USB Stick Creator"
!define MUI_LICENSEPAGE_TEXT_BOTTOM "If you accept the GPL license terms, click Continue."
!define MUI_LICENSEPAGE_BUTTON "Continue"
!insertmacro MUI_PAGE_LICENSE "gpl-2.0.txt"

Name "${PRODUCT_NAME}"
OutFile 'create_installstick.exe'
ShowInstDetails show
AllowRootDirInstall true
RequestExecutionLevel admin

Page Custom CustomCreate CustomLeave
!define MUI_PAGE_HEADER_TEXT "Preparing USB Stick"
!define MUI_PAGE_HEADER_SUBTEXT "Please wait 45 seconds ..."
!insertmacro MUI_PAGE_INSTFILES

Section "oeusbstart"
         StrCpy $1 "$INSTDIR\"
         Push $1
         Call DISKNO
         ExpandEnvStrings $0 %COMSPEC%
         DetailPrint "- Creating Configuration Files ..."
         FileOpen $4 "$TEMP\oedp.txt" w
         FileWrite $4 "select disk $SNUM$\r$\n"
         FileWrite $4 "clean$\r$\n"
         FileWrite $4 "create partition primary$\r$\n"
         FileWrite $4 "format FS=FAT32 LABEL=OPENELEC QUICK OVERRIDE$\r$\n"
         FileWrite $4 "rescan$\r$\n"
         FileWrite $4 "exit$\r$\n"
         FileClose $4
         DetailPrint "- Formatting USB Device ($SLET) ..."
         nsExec::Exec '"%SystemRoot%\system32\diskpart.exe" /s "$TEMP\oedp.txt"'
         DetailPrint "- Mounting USB Device ..."
         sleep 3000
         DetailPrint "- Making Device Bootable ..."
         nsExec::Exec `"3rdparty\syslinux\win32\syslinux.exe" -f -m -a $SLET`
         DetailPrint "- Copying System Files ..."
         nsExec::Exec `"$0" /c copy target\* $SLET`
         DetailPrint "- Copying Configuration Files ..."
         nsExec::Exec `"$0" /c copy Autorun.inf $SLET`
         nsExec::Exec `"$0" /c copy CHANGELOG $SLET`
         nsExec::Exec `"$0" /c copy INSTALL $SLET`
         nsExec::Exec `"$0" /c copy README $SLET`
         nsExec::Exec `"$0" /c copy RELEASE $SLET`
         nsExec::Exec `"$0" /c copy openelec.ico $SLET`
         nsExec::Exec `"$0" /c ECHO DEFAULT linux > $SLET\syslinux.cfg`
         nsExec::Exec `"$0" /c ECHO PROMPT 0 >> $SLET\syslinux.cfg`
         nsExec::Exec `"$0" /c ECHO. >> $SLET\syslinux.cfg`
         nsExec::Exec `"$0" /c ECHO LABEL linux >> $SLET\syslinux.cfg`
         nsExec::Exec `"$0" /c ECHO KERNEL /KERNEL >> $SLET\syslinux.cfg`
         nsExec::Exec `"$0" /c ECHO APPEND boot=LABEL=OPENELEC installer quiet >> $SLET\syslinux.cfg`
         DetailPrint ""
SectionEnd

Function CustomCreate
!insertmacro MUI_HEADER_TEXT "USB Stick Selection Screen" "Important: Make sure that the correct device is selected."

         WriteIniStr '$PLUGINSDIR\custom.ini' 'Settings' 'NumFields' '2'

         WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 1' 'Type' 'Label'
         WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 1' 'Left' '5'
         WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 1' 'Top' '5'
         WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 1' 'Right' '-6'
         WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 1' 'Bottom' '17'
         WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 1' 'Text' \
         'Select drive for Installation (*** ALL DATA WILL BE REMOVED ***):'

         StrCpy $R2 0
         StrCpy $R0 ''
         ${GetDrives} "FDD" GetDrivesCallBack

         WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 2' 'Type' 'DropList'
         WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 2' 'Left' '30'
         WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 2' 'Top' '25'
         WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 2' 'Right' '-31'
         WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 2' 'Bottom' '105'
         WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 2' 'State' '$R1'
         WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 2' 'ListItems' '$R0'
         
         push $0
         InstallOptions::Dialog '$PLUGINSDIR\custom.ini'
         pop $0
         pop $0
FunctionEnd

Function CustomLeave
        ReadIniStr $0 '$PLUGINSDIR\custom.ini' 'Field 2' 'State'
        StrCpy '$INSTDIR' '$0'
        StrCpy '$SLET' '$INSTDIR'
FunctionEnd

Function GetDrivesCallBack
         IntCmp $R2 '0' def next next
      def:
         StrCpy $R1 '$9'
      next:
         IntOp $R2 $R2 + 1
         StrCpy $R0 '$R0$9|'
	 Push $0
FunctionEnd

Function DISKNO
         Exch $1
         Push $2
         Push $3
         Push $4
         Push $5
         Push $6
         Push $7

         System::Call "kernel32::GetVolumeNameForVolumeMountPoint(t r1, t r3r3, i ${MAXLEN_VOLUME_GUID}) i.r2"
         ${If} $2 != 0
         StrCpy $3 $3 -1
         System::Call "kernel32::CreateFile(t r3, \\
         i ${GENERIC_READ}|${GENERIC_WRITE}, \\
         i ${FILE_SHARE_READ}|${FILE_SHARE_WRITE}, \\
         i 0, i ${OPEN_EXISTING}, i 0, i 0) i.r2"
         ${If} $2 != ${INVALID_HANDLE_VALUE}
         System::Alloc ${EXTENTS_BUFFER_SIZE}
         Pop $4
         IntOp $5 0 + 0
         System::Call "kernel32::DeviceIoControl(i r2, \\
         i ${IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS}, \\
         i 0, i 0, \\
         i r4, i ${EXTENTS_BUFFER_SIZE}, \\
         *i r5r5, i 0) i.r3"
         ${If} $3 != 0
         System::Call "*$4(i .r5, i, i .r0)"
         ${If} $5 == 0
         StrCpy $0 "Error: Invalid DISK_EXTENT data"
         ${EndIf}
         ${Else}
         StrCpy $0 "Error: DeviceIoControl failed"
         ${EndIf}
         System::Free $4
         System::Call "kernel32::CloseHandle(i r2) i.r3"
         ${Else}
         StrCpy $0 "Error: CreateFile failed for $3"
         ${EndIf}
         ${Else}
         StrCpy $0 "Error: GetVolumeNameForVolumeMountPoint failed for $1"
         ${EndIf}
         StrCpy $SNUM $0

         Pop $7
         Pop $6
         Pop $5
         Pop $4
         Pop $3
         Pop $2
         Pop $1
FunctionEnd

!define MUI_FINISHPAGE_TITLE "OpenELEC USB Stick Successfully Created"
!define MUI_FINISHPAGE_TEXT "An OpenELEC USB Installer Stick has been created on the device $SLET\n\nPlease boot your HTPC off this USB stick and follow the on-screen instructions."
!define MUI_FINISHPAGE_NOREBOOTSUPPORT
!define MUI_PAGE_CUSTOMFUNCTION_SHOW "FinishShow"
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "English"

Function FinishShow
         GetDlgItem $0 $HWNDPARENT 3
         ShowWindow $0 0
         GetDlgItem $0 $HWNDPARENT 1
         SendMessage $0 ${WM_SETTEXT} 0 "STR:Finish"
FunctionEnd

Function .onInit
         InitPluginsDir
         GetTempFileName $0
         Rename $0 '$PLUGINSDIR\custom.ini'
FunctionEnd
