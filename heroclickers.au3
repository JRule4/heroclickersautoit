
Global $maxLevel = 1600
Global $counter
Global $Paused
Global $coord = 0
Global $loc = 1
Global $numbirds = 0
Global $upgraded = 0

HotKeySet("-", "TogglePause")
HotKeySet("=", "ToggleLocation")
HotKeySet("q", "Terminate")

Local $hWnd = WinWait("[REGEXPTITLE:.* - Clicker Heroes - .*]", "", 10)
Global $controlID = 148896680
Local $title
Global $currentLevel

While True
   
   If $loc == 1 Then
	  ControlClick($hWnd,"",$controlID,"left",1,1320,660)
   Else
	  MouseClick("left")
   EndIf
   
   Sleep(10)
   If Mod($coord, 500) == 0 Then ; level treebeast
	  Send("{z DOWN}")	  
	  Sleep(10)
	  MouseClick("left",450,550,3,1)
	  Send("{z UP}")	  
   EndIf
   
   If Mod($coord,4500) == 0 Then
	  $coord =0
   EndIf
   If $coord == 0 Then 	  
	  $title = WinGetTitle($hWnd)
	  
	  $currentLevel = StringRegExp($title, "Lvl ([\d]+) - Clicker .*", 1)
	  $currentLevel = $currentLevel[0]
	  
	  LevelHeroes()

	  ; use abilities
	  Sleep(100)
	  Send("8679712345")	
	  Sleep(10)
	  $coord = 0	
	  
	  RelicSearch()
	  BirdSearch()		
	  

	  ;return to clicking main
	  MouseClick("left",1120,600,1) 
   EndIf
   $coord = $coord + 1
WEnd
Func RelicSearch()
  Local $chestLoc = PixelSearch(332,189,1582,892,0x6f9587,0)
   If IsArray($chestLoc) Then
	  MouseClick("left",$chestLoc[0],$chestLoc[1],1)
	  Sleep(1000)
	  MouseClick("left",1340,300)
	  Sleep(400)
	  MouseClick("left",745,300)
	  Sleep(400)
	  MouseClick("left",650,670)
	  Sleep(500)
	  MouseClick("left",870,630)
	  Sleep(500)
	  MouseClick("left",375,300)
	  Sleep(500)
   EndIf
EndFunc

Func LevelHeroes() 
	  
	    Send("{z UP}")
	  MouseClick("left", 938, 864, 1);go to bottom of list
	  Sleep(100)
	  Send("{z DOWN}")
	  Sleep(100)
	  MouseClick("left", 450, 600, 1)
	  Sleep(10)
	  MouseClick("left", 450, 600, 1)
	  Sleep(10)
	  MouseClick("left", 450, 600, 1)
	  Sleep(10)
	  MouseClick("left", 450, 700, 1)
	  Sleep(10)
	  MouseClick("left", 450, 700, 1)
	  Sleep(10)
	  MouseClick("left", 450, 700, 1)
	  Sleep(100)
	  Send("{z UP}")
	  Sleep(100)
	  ; level all skills
	  Mouseclick("left", 700, 800, 1)
	  
	  ;level treebeast and lowest heroes as much as possible
	  	  
	  MouseClick("left", 938, 427, 1) ; go to top of list
	  If $upgraded < 5 Then
		 Sleep(100)
		 Local $scrollClicks = 0
		 While $scrollClicks < 8		 	  
			Local $base = 0
			While $base < 120*4
				  Send("{z DOWN}")
				  Sleep(100)
			   For $i = 0 To 5 
				  ;MouseClick("left", 450, 430+$base, 1)
				  ControlClick($hWnd,"",$controlID,"left",1,450,310+$base)
				  Sleep(30)
			   Next
			   For $i = 0 To 5
				  ;MouseClick("left", 450, 480+$base, 1)
				  ControlClick($hWnd,"",$controlID,"left",1,450,360+$base)
				  Sleep(30)
			   Next
			   ControlClick($hWnd,"",$controlID,"left",1,1120,600)
			   Sleep(10)
			   $base = $base + 120
			WEnd	  
		 ; scroll down 7 clicks to get to next heroes
			For $j = 0 To 5
			   MouseClick("left",935,880,1)
			   Sleep(150)
			Next
			$scrollClicks = $scrollClicks+1
		 WEnd
		 $upgraded = $upgraded +1  
		 MouseClick("left", 938, 427, 1) ; go to top of list
	  EndIf
	Send("{z UP}")
EndFunc

Func CheckAscend() 
   If Number($currentLevel) > $maxLevel Then
	  Local $n = 0
	  MouseClick("left", 938, 427, 1) 
	  While $n < 27
		 Sleep(500)	 
		 $n = $n+1
		 MouseClick("left",935,880,1)
	  WEnd
	  
	  For $i = 0 to 16
		 MouseClick("left",672, 430+$i*25, 1)
		 ;ControlClick($hWnd,"",$controlID,"left",1,672,430+$i*50)
	  ;MouseClick("left",672, 873,1)
	  Next
	  
	  MouseClick("left",878, 655,1)
	  MouseClick("left",1564,467,1)
	  MouseClick("left",1120,600,1)
	  $currentLevel = 0
	  $upgraded = 0
	  $coord  = -1
   EndIf
EndFunc

Func BirdSearch()
   MouseClick("left", 1200, 600, 1)
   ;MsgBox(0,"start","starting search")
   Local $fishLips = 0	
   Local $fishLeaf = 0
   Local $fishInnerEye = 0
   Local $fishEye = 0
   For $i = 0 To 480
	  $fishLips = PixelSearch(532,375+$i,1572,376+$i,0xfb4e05,50)
	  While IsArray($fishLips)
		 $fishInnerEye = PixelSearch($fishLips[0]-7,$fishLips[1],$fishLips[0]-4,$fishLips[1]+1, 0xf4e4b5 , 50)
		 If IsArray($fishInnerEye) Then
			$fishEye = PixelSearch($fishLips[0]-10,$fishLips[1],$fishLips[0]-5,$fishLips[1]+1, 0x3b2706, 50)
			If IsArray($fishEye) Then
			  ;MsgBox(0,"looking for leaf","coords: " & $fishLips[0] & "x" & $fishLips[1])
			   $fishLeaf = PixelSearch($fishLips[0]-18, $fishLips[1]-8, $fishLips[0]-15, $fishLips[1]-4, 0xa6c31d, 30)
			   If IsArray($fishLeaf) Then				  
				  CheckAscend() ;call ascend when fish is found
				  MouseClick("left",$fishLips[0],$fishLips[1])
				  MouseClick("left",1176,660) ; pick up gold
				  MouseClick("left",1351, 660) ; pick up gold
			   EndIf
			EndIf
		 EndIf
		 $fishLips[0] = $fishLips[0]+1
		 If $fishLips[0] > 1570 Then
			$fishLips = 0
		 Else
			$fishLips = PixelSearch($fishLips[0],375+$i,1572,376+$i,0xfb4e05,50)
		 EndIf
	  WEnd
   Next
  ; MsgBox(0,"start","ending search")
EndFunc

Func ToggleLocation()
   If $loc == 1 Then
	  $loc = 0
   Else
	  $loc = 1
   EndIf   
EndFunc

Func TogglePause()
    $Paused = Not $Paused
    While $Paused
        Sleep(100)
        ToolTip('Script is "Paused"', 0, 0)
    WEnd
    ToolTip("")
 EndFunc   ;==>TogglePause
 
 
Func Terminate()
    Exit 0
EndFunc   ;==>Terminate