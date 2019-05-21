#!/usr/bin/python

import shlex

"""dmenu wrapper script that calls sub-menus based on JSON structure.

Dictionary keys are command names.
Values can be:
 - null : command name is called as-is (must be in your path).
 - text : this text is assumed to be command (+ args)
 - dictionary : a sub-menu to be displayed.

 Sub-menus can be nested repeatedly to any depth.

 Defaults to dmenu, but can use rofi with: -m "rofi -dmenu"

 Order of json should be preserved in the menu display."""


import json
import os
from collections import OrderedDict
from subprocess import Popen, call, PIPE
from argparse import ArgumentParser, FileType


def show_menu(args, menus):
    """Recursive function to walk menus dict and call dmenu cmd/exec result."""
    print("Using command:", args.menucmd)
    proc = Popen(shlex.split(args.menucmd), stdin=PIPE, stdout=PIPE)
    choice, _ = proc.communicate('\n'.join(menus).encode('utf-8'))
    choice = choice.strip().decode('utf-8')
    print(menus[choice])
    if choice:
        if isinstance(menus[choice], OrderedDict):
            # Sub-menu selected. Loop again
            show_menu(args, menus[choice])
        elif menus[choice]:
            # Specific command defined
            command = [os.path.expanduser(x)
                       for x in shlex.split(menus[choice])]
            call(command)
        else:
            # Call the command title
            call([os.path.expanduser(choice)])


def parse_args():
    """Parse command-line arguments."""

    parser = ArgumentParser()
    parser.add_argument('-j', '--json', type=FileType(), required=True,
                        help='JSON menu config file.')
    parser.add_argument('-m', '--menucmd', default="dmenu",
                        help='menu display command (e.g. dmenu, rofi, etc).')

    args = parser.parse_args()
    return args


def main(args):
    """Define menu and call show_menu()"""

    jsonmenu = args.json.read()
    show_menu(args,
              json.JSONDecoder(object_pairs_hook=OrderedDict).decode(jsonmenu))


if __name__ == "__main__":
    main(parse_args())
