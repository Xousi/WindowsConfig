<#
windows config script
scope: regional configs
    * windows display language
    * languages packs & keyboard
    * country & region
#>

#Requires -RunAsAdministrator

# Install Language function overwrite the cmd top lines. I'm skipping a few ones for lisibility in the terminal.
Write-Output "----- Skipping 5 lines for lisibility reasons"
Write-Output "----- Skipping 5 lines for lisibility reasons"
Write-Output "----- Skipping 5 lines for lisibility reasons"
Write-Output "----- Skipping 5 lines for lisibility reasons"
Write-Output "----- Skipping 5 lines for lisibility reasons"


$english = "en-GB"
$french = "fr-FR"
$englishswiss = "en-CH"


##### Install languages
# (Full language pack, text-to-speech, speech recognition, handwriting, basic typing)
# Installation is required BEFORE configuring preferences !

Install-Language $english
Install-Language $french


##### Config language preferences


# define windows display language (UI)
Set-WinUILanguageOverride $english
# windows display bis (for non-unicode programmes)
Set-WinSystemLocale $english

# create & set languages list & keyboards (set primary first)
$LanguageList = New-WinUserLanguageList $english
$LanguageList.Add($french)
Set-WinUserLanguageList $LanguageList

# define culture / region format (impacts formating dates, calendar...)
Set-Culture $englishswiss

# define country or region (switzerland)
Set-WinHomeLocation 223

# copy regional settings to new user accounts and welcome screen
Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True




<#
##### TODO: Next Steps

Set French keyboard as default input method for keyboard
    * Time & language > Typing > Advanced keyboard settings > Override for default input method

Regional format
    * Time & language > Language & region > Regional format > Change data formats


#>
