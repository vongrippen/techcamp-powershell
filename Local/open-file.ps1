Function Get-FileName
# Open file dialog box and select a file to import
{   
    [void][System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.filter = "Markdown Files (*.md)| *.md" # Set the file types visible to dialog

    # Alternate filters include:
    # "CSV files (*.csv) | *.csv"

    $OpenFileDialog.initialDirectory = $pwd # "c:\"
    
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}

# --------- USAGE ---------------

$filename = Get-FileName
$filecontents = Get-Content $filename

Write-Host $filecontents