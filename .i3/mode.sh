#!/bin/bash

sed -i s/#4A90D9/#F57900/g ~/.i3/config
i3-msg reload
i3-msg mode "$1"
