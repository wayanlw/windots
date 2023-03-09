# Define the list of startup programs
$startupPrograms = @(
    "C:\Users\$env:UserName\scoop\apps\everything\current\everything.exe",
    "C:\Users\$env:UserName\scoop\apps\ditto\current\ditto.exe",
    "C:\Users\$env:UserName\scoop\apps\switcheroo\current\switcheroo.exe",
    "C:\Users\$env:UserName\scoop\apps\executor\current\executor.exe",
    "C:\Users\$env:UserName\scoop\apps\sharex\current\sharex.exe",
    "C:\Users\$env:UserName\scoop\apps\notepadplusplus\current\notepad++.exe",
    "C:\Users\$env:UserName\scoop\apps\dual-monitor-tools\current\DMT.exe",
    "C:\Users\$env:UserName\scoop\apps\$startupProgram\current\$startupProgram.exe"
)

# Define the path to the Startup folder
$StartupFolder = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"

# Loop through the array and check if each program's exe file exists
foreach ($startupProgram in $startupPrograms) {

    if (Test-Path $startupProgram) {
        # Get the name of the executable file
        $exeName = Split-Path $startupProgram -Leaf

        # Check if a shortcut already exists in the Startup folder
        $shortcutPath = Join-Path $StartupFolder "$exeName.lnk"
        if (!(Test-Path $shortcutPath)) {
            # Create a new shortcut in the Startup folder
            $WScriptShell = New-Object -ComObject WScript.Shell
            $Shortcut = $WScriptShell.CreateShortcut($shortcutPath)
            $Shortcut.TargetPath = $startupProgram
            $Shortcut.Save()

            Write-Host "Shortcut for $startupProgram created in Startup folder."
        } else {
            Write-Host "Shortcut for $startupProgram already exists in Startup folder."
        }
    } else {
        Write-Host "$startupProgram not installed or executable not found."
    }
}



# Define an array of program names to install and create startup shortcuts for
$startupPrograms = @(
    "vivaldi",
    "everything",
    "ditto",
    "switcheroo",
    "executor",
    "sharex",
    "notepadplusplus"
)

# Define the path to the Startup folder
$StartupFolder = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"

# Loop through the array and check if each program's exe file exists
foreach ($startupProgram in $startupPrograms) {
    $exePath = "C:\Users\$env:UserName\scoop\apps\$startupProgram\current\$startupProgram.exe"

    if (Test-Path $exePath) {
        # Check if a shortcut already exists in the Startup folder
        $shortcutPath = Join-Path $StartupFolder "$startupProgram.lnk"
        if (!(Test-Path $shortcutPath)) {
            # Create a new shortcut in the Startup folder
            $WScriptShell = New-Object -ComObject WScript.Shell
            $Shortcut = $WScriptShell.CreateShortcut($shortcutPath)
            $Shortcut.TargetPath = $exePath
            $Shortcut.Save()

            Write-Host "Shortcut for $startupProgram created in Startup folder."
        } else {
            Write-Host "Shortcut for $startupProgram already exists in Startup folder."
        }
    } else {
        Write-Host "$startupProgram not installed or executable not found."
    }
}
