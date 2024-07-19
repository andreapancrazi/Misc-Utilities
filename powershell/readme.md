# Get AD Group Members Script

## Overview
This script retrieves members of Active Directory groups based on a specified pattern and outputs the results to a CSV file.

## Prerequisites
- Active Directory module for PowerShell
- A service account with appropriate permissions
- Encrypted password file for the service account

## Defining the OU List
Before running the script, define the list of Organizational Units (OUs) as follows:

powershell
$OUList = @("OU=Generic,DC=something,DC=com")


## Running the Script
Execute the script with the following command:

powershell
.\Get-ADGroupMembers.ps1 -GroupNamePattern "GR_01_*" -OUList $OUList -ServiceAccountUsername "service-account" -EncryptedPasswordFile "service-account_encryptedPassword.txt" -OutputFilePath "GroupMembers.csv"



### Parameters:
- GroupNamePattern: Pattern to match group names (e.g., "GR_01*").
- OUList: List of OUs to search within.
- ServiceAccountUsername: Username of the service account.
- EncryptedPasswordFile: Path to the encrypted password file for the service account.
- OutputFilePath: Path where the output CSV file will be saved.

## Encrypting the Password
To encrypt the password for the service account, use the following PowerShell commands:

powershell
# Prompt for the password
$password = Read-Host -AsSecureString "Enter password"

# Convert the password to an encrypted standard string
$encryptedPassword = ConvertFrom-SecureString $password

# Save the encrypted password to a file
$encryptedPassword | Out-File -FilePath "service-account_encryptedPassword.txt"



## Opening the UTF-8 CSV File in Excel
### Using Excel's Import Function
1. Open Excel:
    - Start Excel (create a new blank workbook).
2. Import the Data:
    - Go to the Data tab on the ribbon.
    - Click on Get External Data.
    - Select From Text or From Text/CSV.
3. Select the File:
    - In the file dialog, locate your UTF-8 encoded CSV file and select it.
    - Click Import.
4. Text Import Wizard - Step 1:
    - In the Text Import Wizard, select Delimited as the original data type.
    - Make sure Start import at row is set to 1.
    - Select UTF-8 from the File origin dropdown list.
    - Click Next.
5. Text Import Wizard - Step 2:
    - In this step, choose the delimiters that your CSV file uses. For a standard CSV, this will be Comma.
    - Check the box next to Comma.
    - Click Next.
6. Text Import Wizard - Step 3:
    - In this step, you can specify the data format for each column. Generally, you can leave it at General.
    - Click Finish.
7. Place the Data:
    - Choose where you want to put the data in your workbook (e.g., starting in cell A1).
    - Click OK.

By following these steps, you can ensure that the data, including any special characters or accented characters, is correctly imported into Excel.