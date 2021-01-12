#!/usr/bin/env bash

if (( EUID != 0 )); then
  echo "must be run as root"
  exit 1
fi

rm -f /tmp/adobe_kill.daemon.stdout 2>/dev/null

# if any of these apps are running, abort
donotkillArr=(
  'Adobe Illustrator'
  'Adobe InDesign'
  'Adobe Photoshop'
  'AdobeAcrobat'
)

procArr=(
  'Adobe Desktop Service'
  'Core Sync'
  'Creative Cloud Helper'
  ACCFinderSync
  AdobeCRDaemon
  AdobeIPCBroker
  AdobeResourceSynchronizer
)

launchdArr=(
  com.adobe.acc.installer.v2
  com.adobe.agservice
  com.adobe.ARMDC.Communicator
  com.adobe.ARMDC.SMJobBlessHelper
  com.adobe.ccxprocess
  com.adobe.GC.AGM
  com.adobe.AdobeCreativeCloud
)

donotkill=0
for a in "${donotkillArr[@]}"; do
  m="^/Applications/.*\.app/Contents/MacOS/$a( [0-9]+)?\$"
  if pgrep -lf "$m" >/dev/null; then
    donotkill=1
    echo "$a is running"
  fi
done
(( donotkill == 0 )) || exit

for proc in "${procArr[@]}"; do
  echo "killing $proc"
  killall -QUIT "$proc" 2>/dev/null
done

for d in "${launchdArr[@]}"; do
  echo "stopping $d"
  launchctl stop "$d"
  launchctl stop "$d"
done

#AdobeCRDaemon
pkill -x AdobeCRDaemon

#CCLibrary
echo "killing CCLibrary"
pkill -f '^/Library/Application Support/Adobe/Creative Cloud Libraries/CCLibrary.app/'

#CCXProcess
echo "killing CCXProcess"
pkill -f '^/Applications/Utilities/Adobe Creative Cloud Experience/CCXProcess/CCXProcess.app/'

exit 0
