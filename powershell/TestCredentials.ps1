function Test-Credentials {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [string]$Username,

        [Parameter(Mandatory = $true)]
        [string]$EncryptedPasswordFile
    )

    # Hardcoded domain and server details
    $domain = "domain"
    $server = "server_ip"

    # Load the encrypted password from the file
    $encryptedPassword = Get-Content -Path $EncryptedPasswordFile
    $secureStringPassword = $encryptedPassword | ConvertTo-SecureString

    # Create the PSCredential object
    $User = "$domain\$Username"
    $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $secureStringPassword

    # Import the Active Directory module
    Import-Module ActiveDirectory

    # Validate the credentials by querying Active Directory
    try {
        $result = Get-ADUser -Filter * -Server $server -Credential $Credential -ErrorAction Stop
        Write-Host "Credentials are valid. Successfully retrieved AD users."
    } catch {
        Write-Error "Failed to authenticate with the provided credentials. Error: $_"
    }
}

# Prompt for the parameters and call the function
param (
    [Parameter(Mandatory = $true)]
    [string]$Username,

    [Parameter(Mandatory = $true)]
    [string]$EncryptedPasswordFile
)

Test-Credentials -Username $Username -EncryptedPasswordFile $EncryptedPasswordFile