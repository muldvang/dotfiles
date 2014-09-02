curl --connect-timeout 3 -m 9 -fsn https://mail.google.com/mail/feed/atom | awk -F 'fullcount>' '{print $2}' | cut -d "<" -f 1
