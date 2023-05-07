#Persistent
SetBatchLines, -1
Process, Priority,, High

Gui +LastFound
hWnd := WinExist()

DllCall( "RegisterShellHookWindow", UInt,hWnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage" )
Return

ShellMessage( wParam,lParam )
{
   WinGet, Style, Style, A
    If (wParam = 1 || wParam = 32772 || wParam = 32773)
    {
        sleep, 40
        WinGet windows, List
        Loop %windows%
        {
            id := windows%A_Index%
            WinGetTitle title, ahk_id %id%
            If (title = "")
                continue
            WinGetClass class, ahk_id %id%	
            If (class = "ApplicationFrameWindow") 
            {
                WinGetText, text, ahk_id %id%
                If (text = "")
                    continue
            } 
            WinGet, style, style, ahk_id %id%
            if !(style & 0xC00000) ; if the window doesn't have a title bar
            {
                If !(title = "League of Legends")
                    continue
            }
            WinGet, state, MinMax, ahk_id %id%
            if (state = -1) ; If the window is minimized
                continue
            
            Run cmd.exe /c C:\Apps\livelycu.exe setprop --monitor 1 --property "blur=true",,hide
            return
        }
        Run cmd.exe /c C:\Apps\livelycu.exe setprop --monitor 1 --property "blur=false",,hide
        return
    }
}
Activate_Window:
	SetTitleMatchMode, 3
	WinActivate, %A_ThisMenuItem%
return