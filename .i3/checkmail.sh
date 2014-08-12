#!/usr/bin/sh
curl --connect-timeout 1 -m 3 -fsn https://mail.google.com/mail/feed/atom | awk -F 'fullcount>' '{print $2}' | cut -d "<" -f 1
