<#
windows config script
scope: install softwares with winget
#>

#Requires -RunAsAdministrator


# ----------------------------- Define Variables -----------------------------


$defaultInstallationPath = "S:"


$wingetConfig = @{

    ##### Standard Softwares

    "Common" = @(

        @{
            # installation folder not customizable
            "Name"   = "Brave"
            "ID"     = "Brave.Brave"
            "source" = "winget"
        }

        @{
            # temporarily unavailable on winget - should be re-added later
            "Name"   = "Chrome"
            "ID"     = "Google.Chrome"
            "source" = "winget"
        }

        @{
            "Name"   = "Firefox"
            "ID"     = "Mozilla.Firefox"
            "source" = "winget"
        }

        @{
            "Name"   = "VSCode"
            "ID"     = "Microsoft.VisualStudioCode"
            "source" = "winget"
        }

        @{
            "Name"   = "7zip"
            "ID"     = "7zip.7zip"
            "source" = "winget"
        }

        @{
            "Name"   = "NAPS2"
            "ID"     = "Cyanfish.NAPS2"
            "source" = "winget"
        }

        <# not available on winget
        @{
            "Name"   = "Office 2019"
            "ID"     = "Microsoft.Office.Office2019"
            "source" = "winget"
        }
        #>
    )


    ##### Games

    "Games"  = @(

        @{
            "Name"   = "Riot\League Of Legends"
            "ID"     = "RiotGames.LeagueofLegends"
            "source" = "winget"
        }

        @{
            "Name"   = "Steam"
            "ID"     = "Valve.Steam"
            "source" = "winget"
        }

        <# not available on winget
        @{
            "Name"   = "Dofus"
            "ID"     = "Ankama.Dofus"
            "source" = "winget"
        }
        #>

    )

    ##### Personal Softwares

    "Perso"  = @(

        @{
            # installation folder not customizable
            "Name"   = "RazerSynapse"
            "ID"     = "RazerInc.RazerInstaller.Synapse4"
            "source" = "winget"
        }

        @{
            # installation folder not customizable
            "Name"   = "Discord"
            "ID"     = "Discord.Discord"
            "source" = "winget"
        }

        @{
            "Name"   = "GIMP"
            "ID"     = "GIMP.GIMP.3"
            "source" = "winget"
        }

        <# not available on winget
        @{
            "Name"   = "FreeFileSync"
            "ID"     = "FreeFileSync.FreeFileSync"
            "source" = "winget"
        }
        #>

        <# not available on winget
        @{
            "Name"   = "VMWare"
            "ID"     = "VMware.WorkstationPlayer"
            "source" = "winget"
        }
        #>

        <# not needed for now
        @{
            "Name"   = "VLC"
            "ID"     = "VideoLAN.VLC"
            "source" = "winget"
        }
        #>

        <# not needed for now
        @{
            "Name"   = "Shotcut" # video edition software
            "ID"     = "Shotcut.Shotcut"
            "source" = "winget"
        }
        #>

    )

    ##### Professional Softwares

    "Pro"    = @(

        <# already pre-installed by default
        @{
            "Name"   = "MS Teams"
            "ID"     = "Microsoft.Teams"
            "source" = "winget"
        }
        #>
    )


}



# ---------------------------- Run Installations -----------------------------

foreach ($category in $wingetConfig.Keys) {

    Write-Output "`n########## Category: $category ##########`n"

    foreach ($software in $wingetConfig[$category]) {

        $softwareID = $software['ID']
        $softwareName = $software['Name']
        $softwareSource = $software['source']

        $installPath = "$defaultInstallationPath\$category\$softwareName"

        # install the software
        # -e for exact id match
        $command = "winget install -e --id $softwareID --location '$installPath' --source $softwareSource"

        Write-Output "Installing $softwareName."

        Invoke-Expression $command


    }
}
