#!/bin/bash
while true;
do /usr/bin/head -c 25M /dev/urandom > "$HOME/upload/test-$(date '+%Y%m%d%H%M')" ; ppd terminal exec put "$HOME/upload/test-$(date '+%Y%m%d%H%M')";
sleep 900;
/usr/bin/rm -rf "$HOME/upload/test*";
sleep 1;
done
