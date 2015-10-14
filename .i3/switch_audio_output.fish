#!/usr/bin/fish

set curr_sink (pacmd list-sinks | grep "*" | grep -P [0-9] -o)
set last_sink (pacmd list-sinks | grep index | tail -n 1 | cut -d : -f 2 | tr -d " ")

if test $curr_sink -eq $last_sink
        set next_sink (pacmd list-sinks | grep index | head -n 1 | cut -d : -f 2 | tr -d " ")
else
        set next_sink (pacmd list-sinks | grep index | grep -C 1 "*" | tail -n 1 | cut -d : -f 2 | tr -d " ")
end

pacmd set-default-sink $next_sink
for index in (pacmd list-sink-inputs | grep index)
        set i (echo $index | grep -P [0-9]+ -o)
        pacmd move-sink-input $i $next_sink
end
true
