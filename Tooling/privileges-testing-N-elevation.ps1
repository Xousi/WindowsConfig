<#
powershell testing script
scope: testing admin privileges & elevation
#>

Write-Output "----- checking for admin privileges"
$isadmin = (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
If ($isadmin -eq $False) {
    Write-Output "----- admin privileges missing, restarting the script as admin"

    Start-Process PowerShell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    # Start-Process PowerShell -Verb RunAs -ArgumentList "-NoExit -NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""

    # Backtick (`) used to escape double quotes inside double-quoted string
    # -NoExit can be added if you want the new window to stay open after script termination (after the pause)

    pause
    # Exit to stop the execution of the non-elevated script (does not close the window)
    Exit
}
else {
    Write-Output "----- running as admin, continuing"
}

pause
