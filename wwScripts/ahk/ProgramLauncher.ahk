RunOrRaise(class, x)
{
    if (WinActive(class)) {
        WinMinimize class
    }
    else if (WinExist(class)) {
        WinActivate class
    }
    else {
        Run x
    }
}

; Run PowerShell on Win + Z
#z::RunOrRaise("ahk_exe notepad++.exe", "C:\Scoop\apps\notepadplusplus\current\notepad++.exe")
^!k::RunOrRaise("ahk_exe KeePassXC.exe", "C:\Scoop\apps\keepassxc\current\KeePassXC.exe")
^#o::RunOrRaise("ahk_exe OUTLOOK.EXE", "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE")
