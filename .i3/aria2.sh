#!/usr/bin/fish

for id in (diana list | cut -f 1 -d " ")
    set entry (diana files $id | tr -s " ")
    basename (echo $entry | cut -f 4 -d " ")
    echo $entry | cut -f 3 -d " "
end
