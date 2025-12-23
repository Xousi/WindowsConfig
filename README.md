# WindowsConfig
Config Scripts for Windows

# Execussion instructions (Automated)
* Run 'start-powershell.bat'
    * This file does all the manual steps in one bat script
        * Start powershell as admin
        * Bypass script execussion policy (allow script execussion)
        * EITHER Navigate to the current path & lets you run scripts yourself from the powershell windows
        * OR Run a script automatically (see in code)

# Execussion instructions (Manually)
* Open Powershell as admin
    * Navigate here
    * Shift+Right click > Open Powershell window here
    * Open a new powershell as admin
    ```
    "start-process powershell –verb runAs"
    ```
* Allow script execussion for ongoing process
    ```
    "Set-ExecutionPolicy RemoteSigned -Scope Process"
    ```
* Run desired ps1 scripts

# Config
* [ToDo] Region & Languages
    * [ToDo] Windows display language
    * [ToDo] Languages packs installation
    * [ToDo] Custom dates & number format
    * [ToDo] Keyboards
    * [ToDo] Country & region
* [ToDo] Power management
    *


# Sources
https://www.youtube.com/watch?v=xwpoC71-tvs

# Todo
* Power settings
