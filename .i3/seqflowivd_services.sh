#!/bin/bash

ps aux | grep [.]Main | tr -s ' ' | cut -d ' ' -f 14- | rev | cut -d '.' -f 2 | rev | tr '\n' ' '
