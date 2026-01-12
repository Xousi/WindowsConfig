<#
windows config script
scope: regional configs
    * install required languages packs
    * windows display language
    * keyboard
    * country & region
    * customise regional formats (date, time, currency, numbers)
    * apply settings to system
#>

#Requires -RunAsAdministrator

# the install-language function overwrites the cmd top lines.
# i'm skipping a few lines for lisibility in the terminal.
Write-Output "----- Skipping 5 lines for lisibility reasons"
Write-Output "----- Skipping 5 lines for lisibility reasons"
Write-Output "----- Skipping 5 lines for lisibility reasons"
Write-Output "----- Skipping 5 lines for lisibility reasons"
Write-Output "----- Skipping 5 lines for lisibility reasons"


# ----------------------------- Define Variables -----------------------------

$english = "en-GB"
$french = "fr-FR"
$englishswiss = "en-CH"

$switzerlandGeoId = "223"
# (get with command: Get-WinHomeLocation)

$frenchKeyboardInputId = "040C:0000040C"
# (get with command: Get-WinDefaultInputMethodOverride)


# ---------------------------- Install Languages -----------------------------


# (full language pack, text-to-speech, speech recognition, handwriting, basic typing)
# This is required BEFORE configuring preferences !

Install-Language $english
Install-Language $french


# ------------------------- Configure Language Preferences -------------------------

# define windows display language (UI)
Set-WinUILanguageOverride $english
# windows display bis (for non-unicode programmes)
Set-WinSystemLocale $english

# create & set languages list & keyboards (set primary first)
$LanguageList = New-WinUserLanguageList $english
$LanguageList.Add($french)
Set-WinUserLanguageList $LanguageList -Force
# override default imput method (keyboard) for fr-fr
Set-WinDefaultInputMethodOverride -InputTip $frenchKeyboardInputId

# define country or region (switzerland)
Set-WinHomeLocation -GeoId $switzerlandGeoId

# activate automatic timezone selection
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\tzautoupdate" -Name "Start" -Value 3 # automatic = 3
w32tm /resync # sync time

# define culture / region format (impacts formating dates, calendar...)
Set-Culture $englishswiss


# ------------------------- Customise Regional Formats -------------------------

<#
##### customise culture (regional format)
### edit through registry (current user only)

$regPath = "HKCU:\Control Panel\International"
Set-ItemProperty -Path $regPath -Name sLongDate -Value "dd MMMM yyyy"

### Get-Culture & Set-Culture
these commands can display/modify user culture for a standard one,
but it cannot  customise each property.
$culture = Get-Culture (-Name "en-CH")
$culture | Format-List -Property *
$culture.DateTimeFormat | Format-List -Property *

#>

# update the registry for the current user (custom regional formats)
$regPath = "HKCU:\Control Panel\International"

### date formats
Set-ItemProperty -Path $regPath -Name sShortDate -Value "dd.MM.yy"
Set-ItemProperty -Path $regPath -Name sLongDate -Value "dd MMM yyyy"
# first day of week
set-ItemProperty -Path $regPath -Name firstdayofweek -Value 0 # Monday

### time formats
set-ItemProperty -Path $regPath -Name sShortTime -Value "HH:mm"
set-ItemProperty -Path $regPath -Name sTimeFormat -Value "HH:mm:ss"
# Time separator
set-ItemProperty -Path $regPath -Name sTime -Value ":"
# AM symbol
set-ItemProperty -Path $regPath -Name s1159 -Value "AM"
# PM symbol
set-ItemProperty -Path $regPath -Name s2359 -Value "PM"

### currency formats
set-ItemProperty -Path $regPath -Name sCurrency -Value "CHF"
set-ItemProperty -Path $regPath -Name iCurrency -Value 3 # 1.1 CHF
set-ItemProperty -Path $regPath -Name iNegCurr -Value 8 # -1.1 CHF
# money decimal separators
set-ItemProperty -Path $regPath -Name sMonDecimal -Value "."
# money thousands separators (space)
set-ItemProperty -Path $regPath -Name sMonThousandSep -Value " "
# money digit grouping
set-ItemProperty -Path $regPath -Name sMonGrouping -Value "3;0" # 123 456 789

### numbers formats
# decimal separators
set-ItemProperty -Path $regPath -Name sDecimal -Value "."
# thousands separators (space)
set-ItemProperty -Path $regPath -Name sThousand -Value " "
# digit grouping
set-ItemProperty -Path $regPath -Name sGrouping -Value "3;0" # 123 456 789
# negative number format
set-ItemProperty -Path $regPath -Name iNegNumber -Value 1 # -1.1
# list separator
set-ItemProperty -Path $regPath -Name sList -Value ","




# ------------------------- Apply Settings to System -------------------------

# copy regional settings to new user accounts and welcome screen
Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True
