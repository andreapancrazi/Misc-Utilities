function Get-ADGroupMembers {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [string]$GroupNamePattern,

        [Parameter(Mandatory = $true)]
        [string[]]$OUList,

        [Parameter(Mandatory = $true)]
        [string]$ServiceAccountUsername,

        [Parameter(Mandatory = $true)]
        [string]$EncryptedPasswordFile,

        [Parameter(Mandatory = $true)]
        [string]$OutputFilePath
    )

    # Hardcoded domain and server details
    $domain = "domain"
    $server = "server_ip"

    # Check if the encrypted password file exists
    if (-Not (Test-Path -Path $EncryptedPasswordFile)) {
        Write-Error "The encrypted password file '$EncryptedPasswordFile' does not exist."
        exit 1
    }

    # Load and decrypt the password from the file
    try {
        $encryptedPassword = Get-Content -Path $EncryptedPasswordFile
        $secureStringPassword = $encryptedPassword | ConvertTo-SecureString
    } catch {
        Write-Error "Failed to load or convert the encrypted password. Error: $_"
        exit 1
    }

    # Create the PSCredential object
    try {
        $User = "$domain\$ServiceAccountUsername"
        $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $secureStringPassword
    } catch {
        Write-Error "Failed to create PSCredential object. Error: $_"
        exit 1
    }

    # Import the Active Directory module
    Import-Module ActiveDirectory

    # Initialize array to store results
    $results = @()

    # Loop through each OU in the list
    foreach ($OU in $OUList) {
        try {
            # Retrieve all groups in the specified OU that match the provided pattern
            $groups = Get-ADGroup -Filter "Name -like '$GroupNamePattern'" -SearchBase $OU -Server $server -Credential $Credential -ErrorAction Stop

            foreach ($group in $groups) {
                Write-Host "Processing Group: $($group.Name)"
                $members = Get-ADGroupMember -Identity $group -Server $server -Credential $Credential -ErrorAction Stop

                # Collect member display names and format them as a single string
                $memberDisplayNames = @()
                foreach ($member in $members) {
                    if ($member.objectClass -eq "user") {
                        $user = Get-ADUser -Identity $member -Properties DisplayName -Server $server -Credential $Credential -ErrorAction Stop
                        $memberDisplayNames += $user.DisplayName
                    } else {
                        $memberDisplayNames += $member.Name  # Fallback for non-user objects
                    }
                }

                # Join member names with commas
                $memberDisplayNamesString = ($memberDisplayNames | Sort-Object) -join ", "

                # Create a custom object for CSV export with only two columns
                $results += [PSCustomObject]@{
                    GroupName = $group.Name
                    Members   = $memberDisplayNamesString
                }
            }
        } catch {
            Write-Error "Error processing OU '$OU': $_"
        }
    }

    # Export results to CSV file with UTF-8 encoding
    try {
        $results | Export-Csv -Path $OutputFilePath -NoTypeInformation -Encoding UTF8
        Write-Host "Results exported to $OutputFilePath"
    } catch {
        Write-Error "Failed to export results to CSV. Error: $_"
    }
}

# Prompt for the parameters and call the function
param (
    [Parameter(Mandatory = $true)]
    [string]$GroupNamePattern,

    [Parameter(Mandatory = $true)]
    [string[]]$OUList,

    [Parameter(Mandatory = $true)]
    [string]$ServiceAccountUsername,

    [Parameter(Mandatory = $true)]
    [string]$EncryptedPasswordFile,

    [Parameter(Mandatory = $true)]
    [string]$OutputFilePath
)

Get-ADGroupMembers -GroupNamePattern $GroupNamePattern -OUList $OUList -ServiceAccountUsername $ServiceAccountUsername -EncryptedPasswordFile $EncryptedPasswordFile -OutputFilePath $OutputFilePath