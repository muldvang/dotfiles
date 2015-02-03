#!/usr/bin/fish

if test (math (transmission-remote -l | wc -l) - 2) -gt -2
        echo (math (transmission-remote -l | wc -l) - 2)
end
