# Création de la liste de langues
$LanguageList = New-WinUserLanguageList "fr-FR"
$LanguageList.Add("en-GB")
Set-WinUserLanguageList $LanguageList

# Définir la langue d'affichage par défaut (UI)
Set-WinUILanguageOverride -Language "en-GB"

# Définir la culture et locale système
Set-Culture "en-CH"
# Pour des vieux programmes non utf-8
Set-WinSystemLocale "en-GB"

# Suisse
Set-WinHomeLocation 223

Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True
