#!/bin/bash

xdotool getwindowname $(xdotool search --name "Google Play Music") | rev | cut -d ' ' -f 5- | rev
