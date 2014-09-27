#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

Opt("GUIOnEventMode", 1)  ; Set to OnEvent

Opt("WinTitleMatchMode", 2) ; Set the window title match mode, "2" is partial match.


#Region ### START Koda GUI section ###
$ShowWindows = GUICreate("ShowWindows", 267, 167, 222, 151)
$WindowNameInput = GUICtrlCreateInput("", 120, 16, 121, 21)
$Window_Title = GUICtrlCreateLabel("Window_Title", 32, 16, 85, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Row = GUICtrlCreateLabel("Row", 32, 48, 31, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$RowInput = GUICtrlCreateInput("", 120, 48, 121, 21, $ES_NUMBER)
$Col = GUICtrlCreateLabel("Col", 32, 80, 24, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$ColInput = GUICtrlCreateInput("", 120, 80, 121, 21, $ES_NUMBER)
$Show = GUICtrlCreateButton("Show", 152, 112, 91, 25)
$Hide = GUICtrlCreateButton("Hide", 32, 112, 91, 25)
$Status = GUICtrlCreateInput("", 0, 144, 265, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEClicked") ;
GUICtrlSetOnEvent($Show, "ShowWindows")
GUICtrlSetOnEvent($Hide, "HideWindows")

While 1
  Sleep(1000)
WEnd




Func ShowWindows()
   $title = GUICtrlRead($WindowNameInput)
   $num_x = GUICtrlRead($RowInput)
   $num_y = GUICtrlRead($ColInput)
   ;;MsgBox(0, "h", ""&$title&","&$num_x&","&$num_y)
   $windows = WinList($title)
   $window_width = @DesktopWidth / $num_x
   $window_height = @DesktopHeight / $num_y
   $tip = "Total:"&$windows[0][0]&" windows, show: "&$num_x*$num_y&", each: "&$window_width&"*"&$window_height
   ControlSetText ( "ShowWindows", "", "Edit4", $tip )
   For $col = 0 to $num_y - 1
	  For $row = 0 to $num_x - 1
		 $position_x = $row * $window_width
		 $position_y = $col * $window_height
		 $window_num = $col * $num_x + $row + 1
		 If $window_num > $windows[0][0] Then ExitLoop 2
		 ;;MsgBox(0,"ss",$window_num)
		 $r = DllCall("User32.dll", "NONE", "SwitchToThisWindow", "HWND", $windows[$window_num][1], "BOOL", 1)
		 Sleep(30)
		 ;;MsgBox(0,  $window_num&$windows[0][0], $windows[$window_num][1]&","&@error)
		 $ret = DllCall("User32.dll", "BOOL", "MoveWindow", "HWND", $windows[$window_num][1], "int", $position_x, "int", $position_y, "int", $window_width, "int", $window_height, "bool", 1)
		 Sleep(30)
		 ;MsgBox(0, $window_num&$windows[0][0], $windows[$window_num][1]&","&@error)
	  Next
   Next
EndFunc

Func HideWindows()
   $title = GUICtrlRead($WindowNameInput)
   ;;MsgBox(0, "h", ""&$title&","&$num_x&","&$num_y)
   $windows = WinList($title)
   For $i = 0 to $windows[0][0]
	  $r = DllCall("User32.dll", "BOOL", "ShowWindow", "HWND", $windows[$i][1], "int", 6)
	  ;;MsgBox(0,"f",""&@error&","&$i)
   Next

EndFunc


Func CLOSEClicked()
  Exit
EndFunc

