<#
windows config script
scope: power configs
    *
    *
    *
#>

Write-Output "----- checking for admin privileges"
$isadmin = (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
If ($isadmin -eq $False) {
    Write-Output "----- admin privileges missing, restarting the script as admin"

    Start-Process PowerShell -Verb runAs -ArgumentList "-noexit", "'$PSCommandPath'; pause"


    # Exit
}
else {
    Write-Output "----- running as admin, continuing"
}
pause

# to enable hibernate
# powercfg -hibernate on

# # to turn off Fast Startup
# # HKLM (HKEY_LOCAL_MACHINE)
# REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /V HiberbootEnabled /T REG_dWORD /D 0 /F

# # change timeout for monitor, sleep, hibernate & disk


# # ac = plugged in
# # dc = on battery
# powercfg -x -monitor-timeout-ac 0
# powercfg -x -monitor-timeout-dc 0
# powercfg -x -standby-timeout-ac 0
# powercfg -x -standby-timeout-dc 0
# powercfg -x -hibernate-timeout-ac 0
# powercfg -x -hibernate-timeout-dc 0
# powercfg -x -disk-timeout-ac 0
# powercfg -x -disk-timeout-dc 0


<#
to check the current values of each power setting, you can
    identify you current power scheme, and it's alias
        run:
            powercfg -query
        first line will mention
        '
        Power Scheme GUID: [ID]  (Balanced)
        GUID Alias: SCHEME_BALANCED
        '

    check the config of each setting with:
    *****
    powercfg -query [scheme_id] [subgroup_id] [setting_id]
    *****

    for monitor timeout:
    powercfg -query SCHEME_BALANCED SUB_SLEEP

    for standby timeout:
    powercfg -query SCHEME_BALANCED SUB_SLEEP STANDBYIDLE

    for hibernate timeout:
    powercfg -query SCHEME_BALANCED SUB_SLEEP HIBERNATEIDLE

    for disk timeout:
    powercfg -query SCHEME_BALANCED SUB_DISK DISKIDLE

    for button actions:
    powercfg -query SCHEME_BALANCED


    to test
    powercfg -query SCHEME_BALANCED SUB_BUTTONS
    powercfg -query SCHEME_BALANCED SUB_DISK
    powercfg -query SCHEME_BALANCED SUB_VIDEO VIDEOIDLE
#>
