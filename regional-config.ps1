# Création de la liste de langues
$LanguageList = New-WinUserLanguageList "en-GB"
$LanguageList.Add("fr-FR")

# Définir l'ordre (langue par défaut en premier)
Set-WinUserLanguageList $LanguageList -Force

# Définir la langue d'affichage par défaut (UI)
Set-WinUILanguageOverride -Language "en-GB"

# Définir la culture et locale système
Set-Culture "en-GB"
Set-WinSystemLocale "en-GB"

# Suisse
Set-WinHomeLocation 223

# ---- Réglage des claviers : FR d’abord, EN ensuite ----

# Récupérer la liste actuelle
$Lang = Get-WinUserLanguageList

foreach ($l in $Lang) {
    # FR-FR = clavier français
    if ($l.LanguageTag -eq "fr-FR") {
        $l.InputMethodTips.Clear()
        $l.InputMethodTips.Add("040C:0000040C") # FR AZERTY
    }

    # EN-GB = conserver le clavier anglais
    if ($l.LanguageTag -eq "en-GB") {
        $l.InputMethodTips.Clear()
        $l.InputMethodTips.Add("0809:00000809") # EN-GB QWERTY
    }
}

# IMPORTANT : mettre FR en premier dans la liste des claviers
# (ordre de la liste = ordre d’apparition = clavier par défaut)
$Ordered = $Lang | Sort-Object { if ($_.LanguageTag -eq "fr-FR") {0} else {1} }

Set-WinUserLanguageList $Ordered -Force

Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True

