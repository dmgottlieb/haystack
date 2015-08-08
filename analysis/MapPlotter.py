"""
MapPlotter.py

Makes a plot of sheep positions from log data. 
"""

import numpy as np
import PIL.Image as pi


class MapPlotter(object): 

	width = 1280
	height = 768

	locations = {}

	def __init__(self):
		pass

	def AtLocation(self,point):
		val = 0

		# If there is already a value for the given point, fetch it. 
		# Otherwise set the value.
		try:
			val = self.locations[point]
		except:
			pass


		val = val + 1
		self.locations[point] = val

	def DrawLocations(self):
		data = np.zeros( (self.height,self.width), dtype=np.uint8 )
		for p in self.locations.keys():
			if (p.x > 0) and (p.y > 0):
				data[p.y,p.x] = self.locations[p]
		

		# Normalize by largest value
		N = 255.0 * (1.0 / np.amax(data))
		data = N * data


		img = pi.fromarray( data ) 
		img.show()





class Point(object):
	"""Hashable object representing point in 2-space. Used to index log data."""

	x=0
	y=0

	def __init__(self,x,y):
		self.x = x
		self.y = y

	def __hash__(self): 
		return self.x + self.y*10000

	def __eq__(self,other):
		return (self.x == other.x) and (self.y == other.y)

	# def x(self):
	# 	return self.x

	# def y(self):
	# 	return self.y