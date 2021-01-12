# adobe_kill - kills Adobe crap

With the default settings, this will scan for background Adobe services every hour and kill them if you have no Adobe apps running. The list of Apps is configurable by editing the `donotkillArr` array in the `adobe_kill.sh` script.

## Install

1. open a Terminal and execute the following commands:

    ```
    git clone https://github.com/luckman212/adobe_kill.git

    cd adobe_kill

    cp adobe_kill.sh /usr/local/bin

    sudo chown root com.adobe_kill.daemon.plist
    
    sudo chmod u+x com.adobe_kill.daemon.plist

    sudo cp com.adobe_kill.daemon.plist /Library/LaunchDaemons

    sudo launchctl bootstrap system /Library/LaunchDaemons/com.adobe_kill.daemon.plist
    ```

## Uninstall

1. from Terminal:

    ```
    sudo launchctl bootout system /Library/LaunchDaemons/com.adobe_kill.daemon.plist

    sudo rm /Library/LaunchDaemons/com.adobe_kill.daemon.plist

    rm /usr/local/bin/adobe_kill.sh
    ```

## Caveat

I haven't tested this on any systems other than my own, which were running 10.15.7 thru 11.1, and Adobe Creative Cloud 2021/2022. Please report issues.
