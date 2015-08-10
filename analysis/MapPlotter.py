"""
MapPlotter.py

Makes a plot of sheep positions from log data. 
"""

import numpy as np
import PIL.Image as pi
from math import sqrt, floor

RADIUS = 20


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
			for x in range(p.x-RADIUS, p.x+RADIUS):
				xrange = p.x - x
				yrange = int(sqrt((RADIUS^2) - (xrange^2) + .01) + 0.5)
				for y in range(p.y-yrange, p.y+yrange):
					if (x > 0) and (x < 32) and (y > 0) and (y < 32):
						data[y,x] = self.locations[p]
		

		# Normalize by largest value
		N = 5 * 255.0 * (1.0 / np.amax(data))
		data = N * data


		img = pi.fromarray( data ) 
		img.show()

	def DrawQuantizedLocations(self):

		data = np.zeros( (self.height / 24,self.width / 24), dtype=np.uint8 )
		for p in self.locations.keys():
			if (p.x > 0) and (p.x < 1280) and (p.y > 0) and (p.y < 768):
				x, y = int(p.x / 24), int(p.y / 24)
				data[y,x] = self.locations[p]

		N = 10 *  255.0 * (1.0 / np.amax(data))

		data = N * data

		img = pi.fromarray( data )
		img = img.resize((self.width, self.height))
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