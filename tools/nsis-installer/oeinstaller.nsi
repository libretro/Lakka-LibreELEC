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

Var "DRIVE_LETTER"
Var "STORAGE_SIZE"
Var "BOOT_TIME"
Var "SSH_PARAM"

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
OutFile 'create_livestick.exe'
ShowInstDetails show
AllowRootDirInstall true
RequestExecutionLevel admin

Page Custom CustomCreate CustomLeave
!define MUI_PAGE_HEADER_TEXT "Preparing USB Stick"
!define MUI_PAGE_HEADER_SUBTEXT "Please wait 45 seconds ..."
!insertmacro MUI_PAGE_INSTFILES

# http://nsis.sourceforge.net/Simple_write_text_to_file
# This is a simple function to write a piece of text to a file. This will write to the end always.
Function WriteToFile
  Exch $0 ;file to write to
  Exch
  Exch $1 ;text to write

  FileOpen $0 $0 a      #open file
  FileSeek $0 0 END     #go to end
  FileWrite $0 $1       #write to file
  FileWrite $0 '$\r$\n' #write crlf
  FileClose $0

  Pop $1
  Pop $0
FunctionEnd

!macro WriteToFile NewLine File String
  !if `${NewLine}` == true
  Push `${String}$\r$\n`
  !else
  Push `${String}`
  !endif
  Push `${File}`
  Call WriteToFile
!macroend
!define WriteToFile `!insertmacro WriteToFile false`
!define WriteLineToFile `!insertmacro WriteToFile true`

Section "oeusbstart"
  ExpandEnvStrings $0 %COMSPEC%

  DetailPrint "- Formatting USB Device ($DRIVE_LETTER) ..."
  nsExec::Exec `"$0" /c format $DRIVE_LETTER /V:OPENELEC /Q /FS:FAT32 /X`

  DetailPrint "- Making Device Bootable ..."
  nsExec::Exec `"3rdparty\syslinux\win32\syslinux.exe" -f -m -a $DRIVE_LETTER`

  DetailPrint "- Copying System Files ..."
  nsExec::Exec `"$0" /c copy target\* $DRIVE_LETTER`

  DetailPrint "- Copying Configuration Files ..."
  nsExec::Exec `"$0" /c copy Autorun.inf $DRIVE_LETTER`
  nsExec::Exec `"$0" /c copy openelec.ico $DRIVE_LETTER`
  nsExec::Exec `"$0" /c copy CHANGELOG $DRIVE_LETTER`
  nsExec::Exec `"$0" /c copy INSTALL $DRIVE_LETTER`
  nsExec::Exec `"$0" /c copy README.md $DRIVE_LETTER`
  nsExec::Exec `"$0" /c copy RELEASE $DRIVE_LETTER`
  nsExec::Exec `"$0" /c copy 3rdparty\syslinux\vesamenu.c32 $DRIVE_LETTER`
  nsExec::Exec `"$0" /c copy splash.png $DRIVE_LETTER`

  DetailPrint "- Creating Bootloader configuration ..."
  Delete '$DRIVE_LETTER\syslinux.cfg'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'UI vesamenu.c32'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'PROMPT 0'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU TITLE Boot Menu'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU BACKGROUND splash.png'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'TIMEOUT $BOOT_TIME'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'DEFAULT live'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' ''

  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU WIDTH 70'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU MARGIN 15'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU ROWS 2'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU HSHIFT 4'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU VSHIFT 13'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU TIMEOUTROW 10'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU TABMSGROW 8'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU CMDLINEROW 8'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU HELPMSGROW 13'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU HELPMSGENDROW 26'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU CLEAR'
  
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' ''
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU COLOR border       30;44   #40ffffff #00000000 std'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU COLOR title        1;36;44 #ff8bbfe3 #00000000 std'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU COLOR sel          7;37;40 #80f0f0f0 #ff606060 all'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU COLOR unsel        37;44   #50ffffff #00000000 std'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU COLOR help         37;40   #c0ffffff #a0000000 std'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU COLOR timeout_msg  37;40   #80ffffff #00000000 std'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU COLOR timeout      1;37;40 #c0ffffff #00000000 std'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU COLOR msg07        37;40   #90ffffff #a0000000 std'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'MENU COLOR tabmsg       31;40   #ff868787 #00000000 std'
  
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' ''
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'LABEL installer'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' '  MENU LABEL Run OpenELEC Installer'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' '  KERNEL /KERNEL'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' '  APPEND boot=LABEL=OPENELEC installer quiet vga=current'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' ''
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' 'LABEL live'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' '  MENU LABEL Run OpenELEC Live'
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' '  KERNEL /KERNEL'
  ${If} $STORAGE_SIZE == "0"
    ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' '  APPEND boot=LABEL=OPENELEC disk=FILE=STORAGE quiet vga=current $SSH_PARAM'
  ${Else}
    ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' '  APPEND boot=LABEL=OPENELEC disk=FILE=STORAGE,$STORAGE_SIZE quiet vga=current $SSH_PARAM'
  ${EndIf}
  ${WriteToFile} '$DRIVE_LETTER\syslinux.cfg' ''
  DetailPrint ""
SectionEnd

Function CustomCreate
!insertmacro MUI_HEADER_TEXT "USB Stick Selection Screen" "Important: Make sure that the correct device is selected."
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Settings' 'NumFields' '7'

  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 1' 'Type' 'Label'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 1' 'Left' '5'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 1' 'Top' '5'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 1' 'Right' '-6'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 1' 'Bottom' '15'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 1' 'Text' \
    'Select drive for Installation (*** ALL DATA WILL BE REMOVED ***):'

  StrCpy $R2 0
  StrCpy $R0 ''
  ${GetDrives} "FDD" GetDrivesCallBack

  GetDlgItem $1 $HWNDPARENT 1
  ${If} $R0 == ""
    EnableWindow $1 0
  ${Else}
    EnableWindow $1 1
  ${EndIf}

  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 2' 'Type' 'DropList'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 2' 'Left' '30'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 2' 'Top' '20'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 2' 'Right' '-31'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 2' 'Bottom' '30'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 2' 'State' '$R1'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 2' 'ListItems' '$R0'

  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 3' 'Type' 'Label'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 3' 'Left' '5'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 3' 'Top' '45'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 3' 'Right' '200'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 3' 'Bottom' '55'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 3' 'Text' \
    'Storage file size for Live USB stick (0 = all free space in MB):'

  WriteIniStr "$PLUGINSDIR\custom.ini" "Field 4" "Type" "Text"
  WriteIniStr "$PLUGINSDIR\custom.ini" "Field 4" "Left" "200"
  WriteIniStr "$PLUGINSDIR\custom.ini" "Field 4" "Top" "43"
  WriteIniStr "$PLUGINSDIR\custom.ini" "Field 4" "Right" "240"
  WriteIniStr "$PLUGINSDIR\custom.ini" "Field 4" "Bottom" "55"
  WriteIniStr "$PLUGINSDIR\custom.ini" "Field 4" "Flags" "ONLY_NUMBERS"
  WriteIniStr "$PLUGINSDIR\custom.ini" "Field 4" "State" "512"

  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 5' 'Type' 'Label'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 5' 'Left' '5'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 5' 'Top' '65'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 5' 'Right' '90'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 5' 'Bottom' '75'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 5' 'Text' \
    'Boot menu timeout (sec):'

  WriteIniStr "$PLUGINSDIR\custom.ini" "Field 6" "Type" "Text"
  WriteIniStr "$PLUGINSDIR\custom.ini" "Field 6" "Left" "90"
  WriteIniStr "$PLUGINSDIR\custom.ini" "Field 6" "Top" "64"
  WriteIniStr "$PLUGINSDIR\custom.ini" "Field 6" "Right" "110"
  WriteIniStr "$PLUGINSDIR\custom.ini" "Field 6" "Bottom" "76"
  WriteIniStr "$PLUGINSDIR\custom.ini" "Field 6" "Flags" "ONLY_NUMBERS"
  WriteIniStr "$PLUGINSDIR\custom.ini" "Field 6" "State" "5"

  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 7' 'Type' 'Checkbox'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 7' 'Left' '30'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 7' 'Top' '85'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 7' 'Right' '200'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 7' 'Bottom' '95'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 7' 'Text' 'Enable SSH (only for debugging purposes)'
  WriteIniStr '$PLUGINSDIR\custom.ini' 'Field 7' 'State' '0'

  push $0
  InstallOptions::Dialog '$PLUGINSDIR\custom.ini'
  pop $0
  pop $0
FunctionEnd

Function CustomLeave
  ReadIniStr $0 '$PLUGINSDIR\custom.ini' 'Field 2' 'State'
  StrCpy '$INSTDIR' '$0'
  StrCpy '$DRIVE_LETTER' '$INSTDIR'

  ReadIniStr $0 '$PLUGINSDIR\custom.ini' 'Field 4' 'State'
  ${If} $0 == "0"
    StrCpy '$STORAGE_SIZE' '0'
  ${ElseIf} $0 < 512
    StrCpy '$STORAGE_SIZE' '512'
  ${Else}
    StrCpy '$STORAGE_SIZE' '$0'
  ${EndIf}

  ReadIniStr $0 '$PLUGINSDIR\custom.ini' 'Field 6' 'State'
  ${If} $0 == "0"
    StrCpy '$BOOT_TIME' '50'
  ${Else}
    IntOp $0 $0 * 10
    StrCpy '$BOOT_TIME' '$0'
  ${EndIf}

  ReadIniStr $0 '$PLUGINSDIR\custom.ini' 'Field 7' 'State'
  ${If} $0 == "1"
    StrCpy '$SSH_PARAM' 'ssh'
  ${Else}
    StrCpy '$SSH_PARAM' ''
  ${EndIf}
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

!define MUI_FINISHPAGE_TITLE "OpenELEC USB Stick Successfully Created"
!define MUI_FINISHPAGE_TEXT "An OpenELEC USB Installer Stick has been created on the device $DRIVE_LETTER.\n\nPlease boot your HTPC off this USB stick and follow the on-screen instructions."
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
