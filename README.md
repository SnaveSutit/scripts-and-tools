# scripts-and-tools

A collection of handy Powershell scripts I've made to make my life easier

# Disclaimer

_This repository contains scripts that are provided "as is" without any warranty of any kind. Use them at your own risk. The author is not responsible for any damage or loss caused by the use of these scripts._

# Requirements

-   Powershell 7
-   Running Powershell scripts requires the execution policy to be set to `Unrestricted`. You can set this by running the following command in an elevated powershell window:

    ```pwsh
    Set-ExecutionPolicy Unrestricted
    ```

# Scripts

-   ## Create Junction

    When run without any arguments, this script will ask for a Junction name, and open a folder browser to select the target folder. It will then create a junction in the current directory with the name you provided, pointing to the selected folder.

    ```pwsh
    .\create-junction.ps1
    ```

    If you want to create a junction without being prompted, you can run the script with the `-Name` and `-Target` parameters. For example:

    ```pwsh
    .\create-junction.ps1 -Name "MyJunction" -Target "C:\Path\To\Target"
    ```
