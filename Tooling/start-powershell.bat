@REM This batch file opens a new PowerShell window with elevated privileges
@REM

@echo off


@REM ----------------------------- Define Variables -----------------------------


@REM Define base command to start PowerShell as admin
set "BaseCommand=Start-Process PowerShell -Verb RunAs"

@REM Define arguments to pass to the new PowerShell process
set "MainARGS='-NoProfile -ExecutionPolicy Bypass'"
    @REM -NoProfile - starts PowerShell without loading the user's profile (optional)
    @REM -ExecutionPolicy Bypass - allows to run scripts

@REM Define argument to open PS in current directory
set "OpenDirectory='-WorkingDirectory ""%CD%\""' "
@REM ""%CD%\"" - quadruple quotes are needed to handle spaces in the path
@REM ""%CD%\"" - final backslash is needed

@REM Define argument to run a specific script
set "RunScript='-File ""%CD%\privileges-testing-N-elevation.ps1""' "



@REM ----------------------------- Main Commands -----------------------------


@REM Set switch variable:
@REM 1: open in current directory
@REM 2: run script

set OPTION=1

if %OPTION% equ 1 (
    @REM Option 1: Open PowerShell in the current directory
    echo Opening PowerShell with elevated privileges...
    PowerShell -Command "%BaseCommand% -ArgumentList %MainARGS%, %OpenDirectory%"

) else if %OPTION% equ 2 (
    @REM Option 2: Open PowerShell and run a specific script
    echo Opening PowerShell to run script with elevated privileges...
    PowerShell -Command "%BaseCommand% -ArgumentList %MainARGS%, %RunScript%"

)


pause



@REM ----------------------------- End of main code -----------------------------
@REM ----- Testing and Notes -----


@REM @ before a command prevents it from being displayed in the cmd
@REM @echo off prevents all commands (like this text) from being displayed in the cmd
@echo off


echo "%CD%"
@REM %CD% shows the current directory of the cmd prompt, WITHOUT the final backslash
echo "%~dp0"
@REM %~dp0 shows the directory of this batch file, WITH the final backslash


@REM Full working command examples:
@REM PowerShell -Command "Start-Process PowerShell -Verb RunAs -ArgumentList '-NoProfile -ExecutionPolicy Bypass -WorkingDirectory ""%CD%\""' "
@REM PowerShell -Command "Start-Process PowerShell -Verb RunAs -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%CD%\power config.ps1""' "
