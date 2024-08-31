## Overview

The RobocopyFilesFolders.ps1 script automates the process of copying specific directories and files from a source location to a destination using robocopy. It supports both directory and individual file copying with configurable options.

## Usage

1. Network Drive Mapping: Before using the script, ensure that the source network location is accessible by mapping it to a drive (if necessary):

```powershell
net use Z: \\<SOURCE_SERVER>\D$ /user:<DOMAIN>\<USERNAME>*
```

2. Parameters:

    * sourceBase: The base path of the source files and directories.
    * destinationBase: The base path where the files and directories will be copied to.

3. Execution: Run the script from the PowerShell command line:

```powershell
.\RobocopyFilesFolders.ps1
```

4. Functionality:

    * The script defines functions to copy entire directories and individual files.
    * It executes robocopy commands with specific options for directories (/E, /mt, /z) and files (/is, /it).
    * The script logs the executed commands to the console for tracking.

5. Output:

    * The specified folders and files will be copied from the source to the destination with the defined robocopy options.
    * Console output will show the executed commands and indicate when the operations are completed.