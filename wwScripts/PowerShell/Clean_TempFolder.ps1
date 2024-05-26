# Clean-TempFiles.ps1
# This script cleans temporary files in the user's temp folder without requiring admin rights
# and shows the size of the folder before and after cleaning, including a notification of the space freed up

function Get-FolderSize {
    param (
        [string]$Path
    )
    $size = 0
    Get-ChildItem -Path $Path -Recurse | ForEach-Object { $size += $_.Length }
    return [math]::Round($size / 1MB, 2)
}

# Function to send a notification
function Send-Notification {
    param (
        [string]$message
    )
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show($message, "Clean Temp Files", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}

# Get the path to the user's temp folder
$tempPath = [System.IO.Path]::GetTempPath()

# Get the size of the temp folder before cleaning
$initialSize = Get-FolderSize -Path $tempPath
Write-Output "Initial size of temp folder: $initialSize MB"

# Get a list of all files in the temp folder
$tempFiles = Get-ChildItem -Path $tempPath -File

# Remove each file
foreach ($file in $tempFiles) {
    try {
        Remove-Item -Path $file.FullName -Force -ErrorAction Stop
        Write-Output "Deleted: $($file.FullName)"
    } catch {
        Write-Output "Failed to delete: $($file.FullName). Error: $($_.Exception.Message)"
    }
}

# Get a list of all directories in the temp folder
$tempDirs = Get-ChildItem -Path $tempPath -Directory

# Remove each directory
foreach ($dir in $tempDirs) {
    try {
        Remove-Item -Path $dir.FullName -Recurse -Force -ErrorAction Stop
        Write-Output "Deleted directory: $($dir.FullName)"
    } catch {
        Write-Output "Failed to delete directory: $($dir.FullName). Error: $($_.Exception.Message)"
    }
}

# Get the size of the temp folder after cleaning
$finalSize = Get-FolderSize -Path $tempPath
Write-Output "Final size of temp folder: $finalSize MB"

# Show the size reduction
$sizeReduction = [math]::Round($initialSize - $finalSize, 2)
Write-Output "Total size reduced: $sizeReduction MB"

# Send a notification with the space freed up
Send-Notification -message "Temp folder cleaned. Total space freed up: $sizeReduction MB"
