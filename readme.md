# Misc Utilities 

Welcome to the Misc Utilities repository! This repository contains a collection of miscellaneous utility scripts written in PowerShell and Bash to assist with various administrative tasks and automations.

## Table of Contents

- [Introduction](#introduction)
- [PowerShell Scripts](#powershell-scripts)
   - [Available Scripts](#available-scripts)
   - [Usage](#usage)
   - [Example](#example)
- [Bash Scripts](#bash-scripts)
  - [Available Scripts](#available-scripts-1)
  - [Usage](#usage-1)
  - [Example](#example-1)
- [Contributing](#contributing)
- [License](#license)


## Introduction

This repository is a collection of scripts designed to simplify and automate common administrative tasks. These scripts can be used for tasks such as managing credentials, querying Active Directory, and processing data files.

## PowerShell Scripts
### Available Scripts

- Protect-Password.ps1:
Prompts for a service account username and password, encrypts the password, and saves it to a file.

- Test-Credentials.ps1:
Validates the provided service account credentials by attempting to query Active Directory.

- Get-ADGroupMembers.ps1:
Retrieves members of Active Directory groups based on a specified pattern and outputs the results to a CSV file.

### Usage

To use a PowerShell script, follow these steps:

1. Open a PowerShell terminal.
2. Navigate to the directory where the script is located.
3. Execute the script using the .\<script-name>.ps1 command.

Example:

```powershell
.\Protect-Password.ps1
```

## Bash Scripts
### Available Scripts

...

### Usage

To use a Bash script, follow these steps:

1. Open a terminal.
2. Navigate to the directory where the script is located.
3. Make the script executable (if it isn't already) using chmod +x <script-name>.sh.
4. Execute the script using ./<script-name>.sh.

Example:

```bash
chmod +x example-script.sh
./example-script.sh
```

## Contributing

Contributions are welcome! If you have a script you'd like to add or an improvement to an existing script, please submit a pull request. Be sure to follow the existing coding style and include a description of your changes.

## License

This repository is licensed under the MIT License. See the LICENSE file for more details.

Feel free to explore and use the scripts in this repository. If you encounter any issues or have suggestions, please open an issue or submit a pull request. Happy scripting!