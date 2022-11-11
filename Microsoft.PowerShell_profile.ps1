### PowerShell template profile 
### Version 1.03 - Tim Sneath <tim@sneath.org>
### From https://gist.github.com/timsneath/19867b12eee7fd5af2ba
### From https://raw.githubusercontent.com/ChrisTitusTech/powershell-profile/main/Microsoft.PowerShell_profile.ps1
### This file should be stored in $PROFILE.CurrentUserAllHosts
### If $PROFILE.CurrentUserAllHosts doesn't exist, you can make one with the following:
###    PS> New-Item $PROFILE.CurrentUserAllHosts -ItemType File -Force
### This will create the file and the containing subdirectory if it doesn't already 
###
### As a reminder, to enable unsigned script execution of local scripts on client Windows, 
### you need to run this line (or similar) from an elevated PowerShell prompt:
###   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
### This is the default policy on Windows Server 2012 R2 and above for server Windows. For 
### more information about execution policies, run Get-Help about_Execution_Policies.

# ────────────────────────────────── PROMPT ────────────────────────────────── #
function Global:prompt {"`nPS[$Env:username] $PWD > "} 

# ─────────────────────────────────── scoop ────────────────────────────────── #
function sci {
       scoop install $args
}

function scs($name) {
        scoop search $name
}

function scu {
        scoop uninstall $args
}

function scuall($name) {
        scoop uninstall -p $name
}

function scl {
        scoop list
}

function scup {
        scoop update $args
}

function scinf($name) {
        scoop info $name
}

function scupall() {
        scoop update *
}

function sclean() {
        scoop cleanup *
}

function reload-profile {
        & $profile
}

# ────────────────────────────── admin function ────────────────────────────── #

# Simple function to start a new elevated process. If arguments are supplied then 
# a single command is started with admin rights; if not then a new admin instance
# of PowerShell is started.
function admin
{
    if ($args.Count -gt 0)
    {   
       $argList = "& '" + $args + "'"
       Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $argList
    }
    else
    {
       Start-Process "$psHome\powershell.exe" -Verb runAs
    }
}

# Set UNIX-like aliases for the admin command, so sudo <command> will run the command
# with elevated rights. 
Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin



# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
#                                Other Functions                               #
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
# Quick shortcut to start notepad
function n { notepad $args }

function find-file($name) {
        Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
                $place_path = $_.directory
                Write-Output "${place_path}\${_}"
        }
}


function ll { Get-ChildItem -Path $pwd -File }
function g { Set-Location $HOME\Documents\Github }
function gcom
{
	git add .
	git commit -m "$args"
}
function lazyg
{
	git add .
	git commit -m "$args"
	git push
}
Function Get-PubIP {
 (Invoke-WebRequest http://ifconfig.me/ip ).Content
}
function uptime {
        #Windows Powershell    
        Get-WmiObject win32_operatingsystem | Select-Object csname, @{LABEL='LastBootUpTime';
        EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}}

        #Powershell Core / Powershell 7+ (Uncomment the below section and comment out the above portion)

        <#
        $bootUpTime = Get-WmiObject win32_operatingsystem | Select-Object lastbootuptime
        $plusMinus = $bootUpTime.lastbootuptime.SubString(21,1)
        $plusMinusMinutes = $bootUpTime.lastbootuptime.SubString(22, 3)
        $hourOffset = [int]$plusMinusMinutes/60
        $minuteOffset = 00
        if ($hourOffset -contains '.') { $minuteOffset = [int](60*[decimal]('.' + $hourOffset.ToString().Split('.')[1]))}       
          if ([int]$hourOffset -lt 10 ) { $hourOffset = "0" + $hourOffset + $minuteOffset.ToString().PadLeft(2,'0') } else { $hourOffset = $hourOffset + $minuteOffset.ToString().PadLeft(2,'0') }
        $leftSplit = $bootUpTime.lastbootuptime.Split($plusMinus)[0]
        $upSince = [datetime]::ParseExact(($leftSplit + $plusMinus + $hourOffset), 'yyyyMMddHHmmss.ffffffzzz', $null)
        Get-WmiObject win32_operatingsystem | Select-Object @{LABEL='Machine Name'; EXPRESSION={$_.csname}}, @{LABEL='Last Boot Up Time'; EXPRESSION={$upsince}}
        #>


        #Works for Both (Just outputs the DateTime instead of that and the machine name)
        # net statistics workstation | Select-String "since" | foreach-object {$_.ToString().Replace('Statistics since ', '')}
        
}

# process commands

function pkill($name) {
        Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}
function pgrep($name) {
        Get-Process $name
}

# Setting Editor

Function Test-CommandExists
{
 Param ($command)
 $oldPreference = $ErrorActionPreference
 $ErrorActionPreference = 'SilentlyContinue'
 try {if(Get-Command $command){RETURN $true}}
 Catch {Write-Host "$command does not exist"; RETURN $false}
 Finally {$ErrorActionPreference=$oldPreference}
} 
#

if (Test-CommandExists nvim) {
    $EDITOR='nvim'
} elseif (Test-CommandExists pvim) {
    $EDITOR='pvim'
} elseif (Test-CommandExists vim) {
    $EDITOR='vim'
} elseif (Test-CommandExists vi) {
    $EDITOR='vi'
} elseif (Test-CommandExists code) {
    #VS Code
    $EDITOR='code'
} elseif (Test-CommandExists notepad) {
    #fallback to notepad since it exists on every windows machine
    $EDITOR='notepad'
}
Set-Alias -Name vim -Value $EDITOR
