<#
windows config script
scope: regional configs
    * windows display language
    * languages packs & keyboard
    * country & region
#>

#Requires -RunAsAdministrator

$english = "en-GB"
$french = "fr-FR"
$englishswiss = "en-CH"


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
