#!/bin/bash

ps aux | grep -v '/home/tandersen/.local/' | grep [.]clc | tr -s ' ' | cut -d ' ' -f 14- | rev | cut -d '.' -f 2 | rev | tr '\n' ' '
