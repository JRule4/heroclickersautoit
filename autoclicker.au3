Global $counter
Global $Paused
Global $coord
Global $loc = 1

HotKeySet("-", "TogglePause")
HotKeySet("=", "ToggleLocation")

Local $hWnd = WinWait("[REGEXPTITLE:.* - Clicker Heroes - .*]", "", 10)
Global $controlID = 148896680

While True

   If $loc == 1 Then
	  ControlClick($hWnd,"",$controlID,"left",1,1320,660)
   Else
	  MouseClick("left")
   EndIf
   
   Sleep(10)
WEnd


Func TogglePause()
    $Paused = Not $Paused
    While $Paused
        Sleep(100)
        ToolTip('Script is "Paused"', 0, 0)
    WEnd
    ToolTip("")
 EndFunc   ;==>TogglePause

Func ToggleLocation()
   If $loc == 1 Then
	  $loc = 0
   Else
	  $loc = 1
   EndIf   
EndFunc
