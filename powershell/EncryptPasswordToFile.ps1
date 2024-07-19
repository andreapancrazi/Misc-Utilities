function Protect-Password {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [string]$Username
    )

    # Prompt for the service account password as a secure string
    $password = Read-Host "Enter the service account password" -AsSecureString

    # Convert the secure string password to an encrypted standard string
    $encryptedPassword = $password | ConvertFrom-SecureString

    # Generate the filename with prefix
    $filename = "${Username}_encryptedPassword.txt"

    # Save the encrypted password to the file
    Set-Content -Path $filename -Value $encryptedPassword

    # Inform the user that the encrypted password has been saved
    Write-Host "Encrypted password saved to $filename"
}

# Prompt for the service account username
$username = Read-Host "Enter the service account username"
Protect-Password -Username $username