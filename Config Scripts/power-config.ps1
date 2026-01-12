<#
windows config script
scope: power configs
    *
    *
    *
#>

#Requires -RunAsAdministrator


# ----------------------------- Hibernate -----------------------------

# turn off Fast Startup
$powerRegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
Set-ItemProperty -Path $powerRegPath -Name HiberbootEnabled -Value 0

# enable the hibernate option in the control panel
powercfg -hibernate on

# show the hibernate option to the start/power menu
$hibernateRegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings"
Set-ItemProperty -Path $hibernateRegPath -Name ShowHibernateOption -Value 1




# ----------------------------- Power Scheme -----------------------------

# activate the Balanced power scheme
powercfg /setactive SCHEME_BALANCED

# turn off the display
powercfg -x -monitor-timeout-ac 10 # 10 minutes plugged in
powercfg -x -monitor-timeout-dc 5 # 5 minutes on battery
# put the computer to sleep
powercfg -x -standby-timeout-ac 30 # 30 minutes
powercfg -x -standby-timeout-dc 15 # 15 minutes
# put the computer to hibernate
powercfg -x -hibernate-timeout-ac 0 # never
powercfg -x -hibernate-timeout-dc 60 # 60 minutes
# turn off the disk
powercfg -x -disk-timeout-ac 20 # 20 minutes
powercfg -x -disk-timeout-dc 10 # 10 minutes



# ----------------------------- Power Button Actions -----------------------------

# power button action
powercfg -setacvalueindex SCHEME_BALANCED SUB_BUTTONS PBUTTONACTION 2 # hibernate
powercfg -setdcvalueindex SCHEME_BALANCED SUB_BUTTONS PBUTTONACTION 2 # hibernate
# sleep button action
powercfg -setacvalueindex SCHEME_BALANCED SUB_BUTTONS SBUTTONACTION 1 # sleep
powercfg -setdcvalueindex SCHEME_BALANCED SUB_BUTTONS SBUTTONACTION 1 # sleep
# lid close action
powercfg -setacvalueindex SCHEME_BALANCED SUB_BUTTONS LIDACTION 0 # do nothing
powercfg -setdcvalueindex SCHEME_BALANCED SUB_BUTTONS LIDACTION 0 # do nothing



# ----------------------------- Testing & clarifications -----------------------------

<#
##### check the current power settings & power scheme alias:
powercfg -query
    first line will mention
    '
    Power Scheme GUID: [ID]  (Balanced)
    GUID Alias: SCHEME_BALANCED
    '

##### check the config of each setting with:
powercfg -query [scheme_id] [subgroup_id] [setting_id]

careful: settings are expressed in seconds, and hexadecimal format. (see below)
# ac = plugged in
# dc = on battery

##### turn off the display
powercfg -query SCHEME_BALANCED SUB_VIDEO VIDEOIDLE
Current AC Power Setting Index: 0x00000258 = 600 seconds = 10 minutes
Current DC Power Setting Index: 0x0000012c = 300 seconds = 5 minutes
edit with:
powercfg -x -monitor-timeout-ac 10 # 10 minutes
powercfg -x -monitor-timeout-dc 5 # 5 minutes

##### put the computer to sleep
powercfg -query SCHEME_BALANCED SUB_SLEEP STANDBYIDLE
    Current AC Power Setting Index: 0x00000708 = 1800 seconds = 30 minutes
    Current DC Power Setting Index: 0x00000384 = 900 seconds = 15 minutes
edit with:
powercfg -x -standby-timeout-ac 30 # 30 minutes
powercfg -x -standby-timeout-dc 15 # 15 minutes

##### put the computer to hibernate
powercfg -query SCHEME_BALANCED SUB_SLEEP HIBERNATEIDLE
    Current AC Power Setting Index: 0x00000000 = disabled
    Current DC Power Setting Index: 0x00000e10 = 3600 seconds = 60 minutes
edit with:
powercfg -x -hibernate-timeout-ac 0 # never
powercfg -x -hibernate-timeout-dc 60 # 60 minutes

##### turn off the disk
powercfg -query SCHEME_BALANCED SUB_DISK DISKIDLE
    Current AC Power Setting Index: 0x000004b0 = 1200 seconds = 20 minutes
    Current DC Power Setting Index: 0x00000258 = 600 seconds = 10 minutes
edit with:
powercfg -x -disk-timeout-ac 20 # 20 minutes
powercfg -x -disk-timeout-dc 10 # 10 minutes


##### power button action
### this setting is hidden, you can query it with -qh, or permanently unhide it with:
powercfg -attributes SUB_BUTTONS PBUTTONACTION -ATTRIB_HIDE
powercfg -qh SCHEME_BALANCED SUB_BUTTONS PBUTTONACTION
    0 = Do nothing ; 1 = Sleep ; 2 = Hibernate ; 3 = Shut down ; 4 = Turn off the display
    Current AC Power Setting Index: 0x00000002 = Hibernate
    Current DC Power Setting Index: 0x00000002 = Hibernate
edit with:
powercfg -setacvalueindex SCHEME_BALANCED SUB_BUTTONS PBUTTONACTION 2 # hibernate
powercfg -setdcvalueindex SCHEME_BALANCED SUB_BUTTONS PBUTTONACTION 2 # hibernate


##### sleep button action
powercfg -qh SCHEME_BALANCED SUB_BUTTONS SBUTTONACTION
    0 = Do nothing ; 1 = Sleep ; 2 = Hibernate ; 3 = Shut down ; 4 = Turn off the display
    Current AC Power Setting Index: 0x00000001 = Sleep
    Current DC Power Setting Index: 0x00000001 = Sleep
edit with:
powercfg -setacvalueindex SCHEME_BALANCED SUB_BUTTONS SBUTTONACTION 1 # sleep
powercfg -setdcvalueindex SCHEME_BALANCED SUB_BUTTONS SBUTTONACTION 1 # sleep

##### lid close action
powercfg -qh SCHEME_BALANCED SUB_BUTTONS LIDACTION
    0 = Do nothing ; 1 = Sleep ; 2 = Hibernate ; 3 = Shut down ; 4 = Turn off the display
    Current AC Power Setting Index: 0x00000001 = Sleep
    Current DC Power Setting Index: 0x00000001 = Sleep
edit with:
powercfg -setacvalueindex SCHEME_BALANCED SUB_BUTTONS LIDACTION 0 # do nothing
powercfg -setdcvalueindex SCHEME_BALANCED SUB_BUTTONS LIDACTION 0 # do nothing


#>
