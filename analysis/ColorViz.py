"""ColorViz.py

Draw some cool colorful viz using the other analysis libs.
"""

import MapPlotter as mp 
import LogReader as lr 

l = lr.LogReader()
m = mp.MapPlotter()

l.ReadAllLogs()

selectors = {"event": "position", "char": "NPC"}
l.FilterEvents(selectors)

for loc in l.GetLocations():
	m.AddPointToData(loc[0], loc[1], 1,1,0)

l = lr.LogReader()
l.ReadAllLogs()
selectors = {"event": "position", "char": "PC"}
l.FilterEvents(selectors)

for loc in l.GetLocations():
	m.AddPointToData(loc[0], loc[1], 0,0,1)

l = lr.LogReader()
l.ReadAllLogs()
selectors = {"event": "sword"}
l.FilterEvents(selectors)

for loc in l.GetLocations():
	m.AddPointToData(loc[0], loc[1], 1,0,0)

m.DrawData(scale=255, fn="color-viz.png")