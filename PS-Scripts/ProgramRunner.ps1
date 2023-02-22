$programs =
	"C:\Program Files\Listary\Listary.exe",
	"C:\Program Files\Listary\ListaryHelper64.exe",
	"C:\Program Files\Listary\ListaryHookHelper32.exe",
	"C:\Program Files\Listary\ListaryHookHelper64.exe",
	"C:\Program Files\Microsoft Office\root\Office16\ONENOTEM.EXE",
	"C:\ProgramData\Logishrd\LogiOptions\Software\Current\LogiOverlay.exe",
	"C:\Scoop\apps\7tt\current\7_TASK~1.EXE",
	"C:\Scoop\apps\beeftext\current\Beeftext.exe",
	"C:\Scoop\apps\ditto\current\Ditto.exe",
	"C:\Scoop\apps\dual-monitor-tools\current\DMT.exe",
	"C:\Scoop\apps\everything\current\Everything.exe",
	"C:\Scoop\apps\executor\current\Executor.exe",
	"C:\Scoop\apps\keepassxc\current\KeePassXC.exe",
	"C:\Scoop\apps\sharex\current\ShareX.exe",
	"C:\Scoop\apps\xmousebuttoncontrol\current\XMouseButtonControl.exe",
	"C:\Users\auwwaya\AppData\Local\Microsoft\OneDrive\OneDrive.exe",
	"C:\Users\auwwaya\AppData\Local\Microsoft\OneDrive\OneDrive.exe",
	"C:\Wayan\PS\00 MUST HAVE\02 MyScripts\lwwkeymap\Capsy.exe",
	"C:\Wayan\PS\00 MUST HAVE\autoscreenshot_1.8.2\AutoScreenshot.exe",
	"C:\Wayan\PS\00 MUST HAVE\switcheroo-portable\switcheroo.exe"


foreach ($program in $programs) {
	if (-not (Get-Process -Module $program -ErrorAction SilentlyContinue)) {
    # Notepad is not running, so start it
    Start-Process $program
}
}

