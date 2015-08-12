"""
LogReader.py

Reads info from Haystack log files.
"""

import csv
import sys 
import os
from math import floor


LOGPATH = "/Users/dave/Library/Application Support/LOVE/haystack/logs"

class LogReader(object):

    

    def __init__(self):
        self.events = []

    def ReadFile(self,filename):
        print "Reading log: " + filename
        lines = []

        with open(filename, 'r') as f:
            # Read lines and strip comments and spaces
            lines = [l.replace(" ","") for l in f if not (l.startswith("--"))]



        # Read csv
        r = csv.DictReader(lines, delimiter=",")
        new_events = list(r)
        self.events = self.events + new_events

        print "... done. Read " + str(len(new_events)) + " events." 

    def ReadAllLogs(self):

        for fn in os.listdir(LOGPATH):
            if fn.endswith(".csv"):
                self.ReadFile(LOGPATH + "/" + fn)

        print "Done reading. self.events has " + str(len(self.events)) + " events." 

    def GetLocations(self):
        locations = []

        for e in self.events:
            try: 
                x, y = int(floor(float(e['x']))), int(floor(float(e['y'])))
                locations.append((x,y))
            except: 
                pass

        return locations

    def FilterEvents(self, selectors):
        """Pass a dict of selectors. Remove from self.events any events that do not exactly match"""



        for key in selectors.keys():
            value = selectors[key]

            total = len(self.events)
            print "Filtering " + str(total) + " events on " + key + "=\"" + value + "\""

            count = 0 

            new_events = []

            for e in self.events: 

                count += 1
                barlength = 38
                blocks = barlength * count / total
                percent = 100 * count / total 
                text = "\rPercent: [{0}] {1}%".format( "=" * blocks + " " * (barlength - blocks), percent)

                sys.stdout.write(text)
                sys.stdout.flush()

                if (e[key] == value):
                    new_events.append(e)

            self.events = new_events
            removed = total - len(self.events) 
            print "\n" + str(removed) + " events removed." 

        print "Done filtering. " + str(len(self.events)) + " events remain." 










    
