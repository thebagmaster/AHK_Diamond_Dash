#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1
CoordMode, Pixel
CoordMode, Mouse

colors := Object()
breakloop := false
fx := 0
fy := 0
ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight, nav2.bmp

Loop
{
	getcolors()
	tx := 1
	ty := 1
	loop, 10
	{
		loop, 9
		{
			;msgbox, % colors[tx,ty] colors[tx,ty-1] colors[tx,ty+1]
			;msgbox, % colors[tx,ty] colors[tx-1,ty] colors[tx,ty+1]
			If((colors[tx,ty] = colors[tx,ty-1] and colors[tx,ty] = colors[tx,ty+1])		
			or (colors[tx,ty] = colors[tx-1,ty] and colors[tx,ty] = colors[tx+1,ty])
			or (colors[tx,ty] = colors[tx,ty-1] and colors[tx,ty] = colors[tx-1,ty])
			or (colors[tx,ty] = colors[tx,ty-1] and colors[tx,ty] = colors[tx+1,ty])
			or (colors[tx,ty] = colors[tx,ty+1] and colors[tx,ty] = colors[tx+1,ty])
			or (colors[tx,ty] = colors[tx,ty+1] and colors[tx,ty] = colors[tx-1,ty])
			or (colors[tx,ty] = 0x9E974D))
			{
				mouseclick,,(tx-1)*40+110+fx,(ty-1)*40+140+fy
				;msgbox, % tx " " ty
				;msgbox, % colors[tx,ty] " " colors[tx,ty-1] " " colors[tx,ty+1]
				;msgbox, % colors[tx,ty] " " colors[tx+1,ty] " " colors[tx-1,ty]
				;msgbox, % (tx-1)*40+100+fx " , " (ty-1)*40+150+fy
				breakloop := true
				break
			}
			ty+=1
		}
		if breakloop
			break
		tx+=1
		ty:=1
	}
	if breakloop
		breakloop := false
	sleep, 80
}

getcolors()
{
	global colors
	global fx
	global fy
	addx := 110
	addy := 140
	loop, 9
	{
		x := A_Index
		loop, 10
		{
			PixelGetColor , c, % (fx+addx), % (fy+addy)
			SplitBGRColor(0x9C690E,fred,fgrn,fblu)
			SplitBGRColor(c,red,grn,blu)
			dev := 10
			if(abs(red-fred)<dev and abs(grn-fgrn)<dev and abs(blu-fblu)<dev)
			{
				mouseclick,,fx+addx,fy+addy
			}
			colors[A_Index,x] := c
			;mousemove,fx+addx,fy+addy
			;msgbox, % colors[A_Index,x] " " a_index " x " x
			addx += 40
		}
		addx := 110
		addy += 40
	}
}

getcolor(c)
{
	if(c = 0x7F6FFF)
		return "red"
	else if( c = 0x19E8FF)
		return "yellow"
	else if(c = 0x30E253)
		return "green"
	else if(c = 0xFA9800)
		return "blue"
	else if(c = 0xFF4CB9)
		return "purp"
}

SplitBGRColor(BGRColor, ByRef Red, ByRef Green, ByRef Blue)
{
    Red := BGRColor & 0xFF
    Green := BGRColor >> 8 & 0xFF
    Blue := BGRColor >> 16 & 0xFF
}

f2::
	pause
return
f3::
	reload
return