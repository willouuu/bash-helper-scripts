#!/bin/bash

# Notification pour tous les utilisateurs depuis root

# get list of current users
for userLast in $(who | sort -u -k1,1 | awk '{print $1}'); do

        USER="$userLast"
        NOTIFY_SEND_BIN="/usr/bin/notify-send"

        TITLE="Mise à jour en cours"

        MESSAGE="Merci de ne pas eteindre l'ordinateur"

        # get pid of user dbus process
        DBUS_PID=`ps ax | grep "gconfd-2" | grep -v grep | awk '{ print $1 }'`

        # get DBUS_SESSION_BUS_ADDRESS variable
        DBUS_SESSION=`grep -z DBUS_SESSION_BUS_ADDRESS /proc/$DBUS_PID/environ | sed -e s/DBUS_SESSION_BUS_ADDRESS=//`

        # send notify
        DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION su -c "$NOTIFY_SEND_BIN \"$TITLE\" \"$MESSAGE\"" $USER

done
