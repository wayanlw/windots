
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# ———————————————————————————————————————————————————————————————————————————— #
#                                 Install Scoop                                #
# ———————————————————————————————————————————————————————————————————————————— #


if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
	$message = "Do you want to install scoop? (Y/N)"
	$result = Read-Host -Prompt $message
	if ($result.ToLower() -eq "y") {
		# Set the execution policy for the current user to allow remote scripts to be executed
		Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

		# Install scoop
		irm 'https://get.scoop.sh' | iex

		scoop install git aria2
		scoop bucket add extras
		git config --global credential.helper manager # git config
		scoop config aria2-warning-enabled false  # silent the aria2 warnings
	}
	else {
		Write-Host "Skipping Scoop installation."
		scoop update
	}
}
else {
	Write-Host "Scoop is already installed. Skipping installation."
}

# Ask the user for confirmation before proceeding
$message = "Do you want to install scoop programs? (Y/N)"
$result = Read-Host -Prompt $message
if ($result.ToLower() -eq "y") {
	# Define an array of program names to install
	if ((Get-Command scoop -ErrorAction SilentlyContinue)) {
		scoop install git aria2
		scoop bucket add extras
		$programs = @(
			"7tt",
			"beeftext",
			"capture2text",
			"cmder",
			"cryptomator",
			"dark",
			"ditto",
			"docto",
			"dual-monitor-tools",
			"everything",
			"executor",
			"flameshot",
			"freecommander",
			"irfanview-lean",
			"keepassxc",
			"mousejiggler",
			"mpv",
			"nomacs",
			"notepadplusplus",
			"processhacker",
			"quicklook",
			"sharex",
			"sumatrapdf",
			"switcheroo",
			"vscode",
			"whatsapp",
			"windirstat",
			"windows-terminal",
			"xmousebuttoncontrol",
		)
		# Create an empty array to store the program names to be installed
		$installPrograms = @()

		# Loop through the array and ask the user for confirmation before adding each program to the installPrograms array
		foreach ($program in $programs) {
			$message = "Do you want to install $program (Y/N)"
			$result = Read-Host -Prompt $message
			if ($result.ToLower() -eq "y") {
				$installPrograms += $program
			}
		}

		# Check if there are any programs to be installed
		if ($installPrograms.Count -gt 0){
		# Loop through the array and ask the user for confirmation before installing each program
			foreach ($installProgram in $installPrograms) {
				Write-Host "Installing: $installProgram"
				scoop install $installProgram
			}
		}


	}
	else {
	Write-Host "Scoop is not installed. Skipping installation."
	}
}

# ———————————————————————————————————————————————————————————————————————————— #
#                           Context Path Installation                          #
# ———————————————————————————————————————————————————————————————————————————— #

$contextPaths = @(
	"C:\Users\$env:UserName\scoop\apps\notepadplusplus\current\install-context.reg",
	"C:\Users\$env:UserName\scoop\apps\7zip\current\install-context.reg",
	"C:\Users\ww\scoop\apps\vscode\current\install-context.reg"
)

if (Test-Path $contextPaths) {
	# Check if a shortcut already exists in the Startup folder
	foreach ($contextPath in $contextPaths) {
		reg import $contextPath
	}
}

# ──────────────────────────────────────────────────────────────────────────── #
#                             Copying Setting Files                            #
# ──────────────────────────────────────────────────────────────────────────── #

Copy-Item "$([Environment]::GetFolderPath('MyDocuments'))\Git Repositories\.windot\DMT\DmtSettings.xml" -Destination "C:\Users\$env:UserName\scoop\apps\persist\dual-monitor-tools\DmtSettings.xml" -Force
Copy-Item "$([Environment]::GetFolderPath('MyDocuments'))\Git Repositories\.windot\BeefText\comboList.json" -Destination "C:\Users\$env:UserName\scoop\apps\persist\beeftext\Data\comboList.json" -Force
Copy-Item "$([Environment]::GetFolderPath('MyDocuments'))\Git Repositories\.windot\Excutor\Executor.ini" -Destination "C:\Users\$env:UserName\AppData\Roaming\Executor\executor.ini" -Force


# ———————————————————————————————————————————————————————————————————————————— #
#                          Creating startup shortcuts                          #
# ———————————————————————————————————————————————————————————————————————————— #

# Define the list of startup programs
$startupPrograms = @(
    "C:\Users\$env:UserName\scoop\apps\everything\current\everything.exe",
    "C:\Users\$env:UserName\scoop\apps\ditto\current\ditto.exe",
    "C:\Users\$env:UserName\scoop\apps\switcheroo\current\switcheroo.exe",
    "C:\Users\$env:UserName\scoop\apps\executor\current\executor.exe",
    "C:\Users\$env:UserName\scoop\apps\sharex\current\sharex.exe",
    "C:\Users\$env:UserName\scoop\apps\notepadplusplus\current\notepad++.exe",
    "C:\Users\$env:UserName\scoop\apps\dual-monitor-tools\current\DMT.exe"
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
			& $shortcutPath
        } else {
            Write-Host "Shortcut for $startupProgram already exists in Startup folder."
        }
    } else {
        Write-Host "$startupProgram not installed or executable not found."
    }
}





# ———————————————————————————————————————————————————————————————————————————— #
#                 Activating the old windows menu if Windows 11                #
# ———————————————————————————————————————————————————————————————————————————— #

$osVersion = (Get-ComputerInfo).OsName
if ($osVersion -match "11") {
	reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
	Write-Host "Old windows rightclick menu successfully implemented."
}
else {
    Write-Host "No need to activate old menu. You're not running windows 11."
}


# ———————————————————————————————————————————————————————————————————————————— #
#                           Cloning Windots and Capsy                          #
# ———————————————————————————————————————————————————————————————————————————— #

# Define the URL for the Git repositories
$windotUrl = "https://github.com/wayanlw/.windot"
$capsyUrl = "https://github.com/wayanlw/capsy"

# Define the destination folder
$destinationFolder = "$([Environment]::GetFolderPath('MyDocuments'))\Git Repositories"

# Create the destination folder if it doesn't exist
if (!(Test-Path -Path $destinationFolder -PathType Container)) {
    New-Item -Path $destinationFolder -ItemType Directory | Out-Null
}

# Clone the windot repository into the destination folder
cd $destinationFolder
git clone $windotUrl

# Clone the capsy repository into the destination folder
cd $destinationFolder
git clone $capsyUrl

# ——————————————————————————————— Capsy startup —————————————————————————————— #

# Define the path to the capsy.exe program
$capsyPath = "$([Environment]::GetFolderPath('MyDocuments'))\Git Repositories\.windot\capsy\capsy_mod.exe"

# Create a shortcut to the capsy.exe program in the startup folder
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut("$([Environment]::GetFolderPath('Startup'))\capsy.lnk")
$shortcut.TargetPath = $capsyPath
$shortcut.Save()

# ———————————————————————————————————————————————————————————————————————————— #
#                              Powershell Profile                              #
# ———————————————————————————————————————————————————————————————————————————— #
$profilePath = "$([Environment]::GetFolderPath('MyDocuments'))\Git Repositories\.windot\Windows PowerShell\Microsoft.PowerShell_profile.ps1"
$psFolder = $PROFILE.CurrentUserAllHosts | Split-Path

if (!(Test-Path $psFolder)) {
    New-Item -ItemType Directory -Path $psFolder | Out-Null
}

Copy-Item $profilePath -Destination $psFolder -Force
Write-Host "Powershell Profile profile.ps1 copied."
. $profile
