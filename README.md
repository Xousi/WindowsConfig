# WindowsConfig
Config Scripts for Windows

# Execussion instructions (Automated)
* Run 'start-powershell.bat'
    * This file does all the manual steps in one bat script
        * Start powershell as admin
        * Bypass script execution policy (allow script execution)
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
* Allow script execution for ongoing process
    ```
    "Set-ExecutionPolicy RemoteSigned -Scope Process"
    ```
* Run desired ps1 scripts

# Config
Each config section is automated in a dedicated script.
Execute them one by one in order to automatically configure a fresh windows install.

* Region & Languages
    * Install required languages packs
    * Windows display language
    * Keyboards
    * Country & region
    * Customise regional formats (date, time, currency, numbers)

* Power management
    * turn off fast startup & enable hibernate
    * configure custom power scheme timeouts
    * configure power buttons actions


* Softwares auto-installation with winget
    * List softwares to be installed by category (Standards, Perso, Pro, Games)
    * Auto install them with winget

# Windows Activation (Digital license)
Once the new windows is configures you need to activate it. 

* If you own a digital license on your microsoft account you need to
    * Sign in to your new computer with the new Microsoft account.
        * Go to Settings > Accounts > Your Info
        * Select Sign in with a Microsoft account instead
    * If the license does not activate automatically, use the troubleshooter
        * Go to Settings > System > Activation
        * Select Troubleshoot.
        * Select "I changed hardware on this device recently".
        * (Optional) Sign in with the old account if prompted, then select the new device to transfer the license.
