#!/bin/bash

sed -i s/#F57900/#4A90D9/g ~/.i3/config
i3-msg reload
i3-msg mode "default"
