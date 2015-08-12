"""
Analyze.py

Batch file for testing analysis lib.
"""

import MapPlotter as mp 
import LogReader as lr 

l = lr.LogReader()

l.ReadAllLogs()

selectors = {"event": "position", "char": "NPC"}
l.FilterEvents(selectors)

locations = l.GetLocations()

m1 = mp.MapPlotter()

for loc in locations: 
	p = mp.Point(loc[0], loc[1])
	m1.AtLocation(p)

m1.DrawQuantizedLocations("NPCs-only.png")

l = lr.LogReader()

l.ReadAllLogs()

selectors = {"char": "PC"}
l.FilterEvents(selectors)

locations = l.GetLocations()

m2 = mp.MapPlotter()

for loc in locations: 
	p = mp.Point(loc[0], loc[1])
	m2.AtLocation(p)

m2.DrawQuantizedLocations("pcs-only.png")

l = lr.LogReader()

l.ReadAllLogs()

selectors = {"event": "sword"}
l.FilterEvents(selectors)

locations = l.GetLocations()

m1 = mp.MapPlotter()

for loc in locations: 
	p = mp.Point(loc[0], loc[1])
	m1.AtLocation(p)

m1.DrawQuantizedLocations("swords.png")

l = lr.LogReader()

l.ReadAllLogs()

selectors = {"char": "corpse"}
l.FilterEvents(selectors)

locations = l.GetLocations()

m1 = mp.MapPlotter()

for loc in locations: 
	p = mp.Point(loc[0], loc[1])
	m1.AtLocation(p)

m1.DrawQuantizedLocations("corpses.png")


