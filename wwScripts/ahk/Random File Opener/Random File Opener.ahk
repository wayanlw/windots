; Set up GUI
Gui, Add, Text,, Enter the folder path:
Gui, Add, Edit, vFolderPath w300
Gui, Add, Button, gSetFolder, Browse...
Gui, Add, Button, gOpenRandomFile, Open Random File
Gui, Show, , Random File Opener

; Variable to store the folder path
global folderPath := ""

Return  ; End of auto-execute section

; Browse for folder
SetFolder:
FileSelectFolder, folderPath
If (folderPath != "")
{
    GuiControl,, FolderPath, %folderPath%
}
Return

; Open a random file from the folder
OpenRandomFile:
FileList := ""
Loop, Files, % folderPath "\*.*", FR
{
    FileList .= A_LoopFileName "`n"
}

; Randomly pick a file
Random, rand, 1, StrSplit(FileList, "`n").MaxIndex() - 1
RandomFile := StrSplit(FileList, "`n")[rand]

; Open the file
Run, % folderPath "\" RandomFile
Return

GuiClose:
ExitApp
