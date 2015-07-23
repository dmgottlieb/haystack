-- An obstacle is a box defined by x and y bounds corners (easy to calculate rectilinear distance)
Obstacle = {
	UX = 0,
	LX = 0,
	UY = 0,
	LY = 0
}

-- Constructor takes 4 vectors for the corners of the box
function Obstacle:new(UX, LX, UY, LY)
	o = {}
	setmetatable(o, self)
	self.__index = self

	o.UX = UX
	o.LX = LX
	o.UY = UY
	o.LY = LY
	
	return o
end

-- Gets shortest displacement vector from given position vector X to the obstacle
function Obstacle:getDisplacement(X)
	nearestPoint = Vector:new(0,0)

	nearestPoint.x = math.max(X.x, self.LX)
	nearestPoint.x = math.min(X.x, self.UX)
	nearestPoint.y = math.max(X.y, self.LY)
	nearestPoint.y = math.min(X.y, self.UY)

	displacement = nearestPoint - X 

	return displacement
end

function Obstacle:getCenter()
	c = Vector:new(0,0)

	c.x = (self.UX + self.LX) / 2
	c.y = (self.UY + self.LY) / 2

	return c
end

