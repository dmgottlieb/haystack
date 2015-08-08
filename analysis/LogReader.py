"""
LogReader.py

Reads info from Haystack log files.
"""

import csv
import os

LOGPATH = "/Users/dave/Library/Application Support/LOVE/haystack/logs"

class LogReader(object):

	events = []

	def __init__(self):
		pass

	def ReadFile(self,filename):
		lines = []

		with open(filename, 'r') as f:
			# Read lines and strip comments and spaces
			lines = [l.replace(" ","") for l in f if not (l.startswith("--"))]



		# Read csv
		r = csv.DictReader(lines, delimiter=",")

		self.events = self.events + list(r)

	def ReadAllLogs(self):

		for fn in os.listdir(LOGPATH):
			if fn.endswith(".csv"):
				self.ReadFile(LOGPATH + "/" + fn)

	def GetLocations(self):
		locations = []

		for e in self.events:
			if e['event'] == 'position':
				x, y = int(e['x']), int(e['y'])
				locations.append((x,y))

		return locations



	
