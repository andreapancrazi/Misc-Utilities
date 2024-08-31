param (
    [Parameter(Mandatory=$true)]
    [string]$filePath
)

# Check if the file exists
if (-Not (Test-Path $filePath)) {
    Write-Host "File not found: $filePath"
    exit
}

# Get the directory and filename components
$directory = Split-Path -Parent $filePath
$filename = Split-Path -Leaf $filePath
$secretFilePath = Join-Path $directory "$($filename).secret"

# Copy the original file to a new file with the .secret extension
Copy-Item -Path $filePath -Destination $secretFilePath

# Read the original file content
$content = Get-Content -Path $filePath -Raw

# Define the patterns and their replacements
$patterns = @{
    '("Password"\s*:\s*)".*?"'               = '${1}"YOUR_Password"';
    '("X-API-Key"\s*:\s*)".*?"'              = '${1}"YOUR_X-API-Key"';
    '("APIKey"\s*:\s*)".*?"'                 = '${1}"YOUR_APIKey"';
    '("Token"\s*:\s*)".*?"'                  = '${1}"YOUR_Token"';
    '("Secret"\s*:\s*)".*?"'                 = '${1}"YOUR_Secret"';
    '("Key"\s*:\s*)".*?"'                    = '${1}"YOUR_Key"';
    '("AccessKey"\s*:\s*)".*?"'              = '${1}"YOUR_AccessKey"';
    '("PrivateKey"\s*:\s*)".*?"'             = '${1}"YOUR_PrivateKey"';
}

# Replace each pattern in the content
foreach ($pattern in $patterns.Keys) {
    $replacement = $patterns[$pattern]
    $content = [regex]::Replace($content, $pattern, $replacement)
}

# Save the modified content back to the original file
Set-Content -Path $filePath -Value $content

Write-Host "Secrets have been replaced with placeholders in $filePath"
Write-Host "Original file with secrets has been saved as $secretFilePath"
