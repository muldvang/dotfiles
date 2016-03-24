#!/usr/bin/env python2

import socket
import os

class Dropbox(object):
    "This class handles communication with the dropbox daemon."
    def __init__(self):
        self.connected = False
        self.sck = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

    def connect(self):
        "Connects to the Dropbox command_socket, returns True if it was \
        successfull."
        try:
            self.sck.connect(os.path.expanduser("~/.dropbox/command_socket"))
        except:
            self.connected = False
            return False
        else: # went smooth
            self.connected = True
            return True

    def disconnect(self):
        "Tries to disconnect, returns True/False."
        self.sck.close()
        self.connected = False

    def send_and_fetch(self, msg):
        "Sends a message to the command_socket, and returns the result."

        self.sck.send(msg)
        res = ""
        while not res.endswith("done\n"):
            tmp = self.sck.recv(512)
            res += tmp
            if tmp == "":
                self.connected = False
                return ("notok", "disconnected")
        return res

    def get_status(self):
        "Fetches the status."

        dropbox_folder = os.path.expanduser("~/Dropbox/")

        res = self.send_and_fetch("icon_overlay_file_status\npath\t%s\ndone\n" %
                                  dropbox_folder)

        res = res.split('\n')[:-1]

        res = res[1].split('\t')
        status = res[1]
        return status

if __name__ == "__main__":
    DB = Dropbox()
    if DB.connect() == False:
        print "Error"
        print "Error"
        print "#A52A2A"
    else:
        STATUS = DB.get_status()
        if not STATUS == 'up to date':
            print STATUS.capitalize()
        DB.disconnect()
