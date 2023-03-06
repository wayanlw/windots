; Define program paths
chrome_path := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
excel_path := "C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE"
notepad_path := "C:\Windows\System32\notepad.exe"

; Define function to move window
MoveWindow(name, x, y, w, h) {
    WinWaitActive("ahk_exe " . name)
    WinMove("ahk_exe " . name, , x, y, w, h)
}

; ; Open or activate Chrome, Excel, and Notepad
; If !ProcessExist("chrome.exe")
; {
;     Run "chrome.exe"
; }
; MoveWindow("chrome.exe", 0, 0, 1280, 1024)

If !ProcessExist("EXCEL.EXE")
{
    Run "excel.exe"
}
MoveWindow("EXCEL.EXE", 1280, 0, 1280, 1024)

If !ProcessExist("notepad.exe")
{
    Run "notepad.exe"
}
MoveWindow("notepad.exe", 0, 1024, 1280, 1024)
