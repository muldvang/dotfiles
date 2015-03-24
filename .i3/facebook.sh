#!/bin/bash

fbcmd notify | ag MESSAGES_UNREAD | cut -d " " -f 3
