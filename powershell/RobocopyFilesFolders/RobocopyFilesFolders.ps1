# Define source and destination paths
$sourceBase = "\\<SOURCE_SERVER>\<SOURCE_PATH>"
$destinationBase = "<DESTINATION_PATH>"

# Robocopy options for directories
$dirOptions = "/mt /z /copy:DAT /E"

# Function to execute robocopy for directories
function Run-RobocopyDir {
    param (
        [string]$source,
        [string]$destination
    )
    
    $cmd = "robocopy "$source" "$destination" $dirOptions"
    Write-Host "Executing: $cmd"
    Invoke-Expression $cmd
}

# Copy specific folders
Run-RobocopyDir "$sourceBase\Folder1" "$destinationBase\Folder1"
Run-RobocopyDir "$sourceBase\Folder2" "$destinationBase\Folder2"
Run-RobocopyDir "$sourceBase\FolderN" "$destinationBase\FolderN"

# Robocopy options for individual files
$fileOptions = "/mt /z /copy:DAT /is /it"

# Function to execute robocopy for files
function Run-RobocopyFile {
    param (
        [string]$sourceDir,
        [string]$destinationDir,
        [string]$fileName
    )
    
    $cmd = "robocopy "$sourceDir" "$destinationDir" "$fileName" $fileOptions"
    Write-Host "Executing: $cmd"
    Invoke-Expression $cmd
}

# Copy specific files
Run-RobocopyFile "$sourceBase\FolderX" "$destinationBase\FolderX" "file1.json"
Run-RobocopyFile "$sourceBase\FolderX" "$destinationBase\FolderX" "file2.config"
Run-RobocopyFile "$sourceBase\FolderX" "$destinationBase\FolderX" "file3.env"

Write-Host "Robocopy operations completed."