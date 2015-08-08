"""
Analyze.py

Batch file for testing analysis lib.
"""

import MapPlotter as mp 
import LogReader as lr 

l = lr.LogReader()
m = mp.MapPlotter()

l.ReadAllLogs()

locations = l.GetLocations()

for loc in locations: 
	p = mp.Point(loc[0], loc[1])
	m.AtLocation(p)

m.DrawQuantizedLocations()