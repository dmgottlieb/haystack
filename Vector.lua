-- Wraps linear algebra functionality, simplifying the rest of the code. 
-- I only need 2 dimensions, so there are 2 dimensions. 

Vector = {
	x = 0,
	y = 0
}
	
function Vector:__add(rhs)
	local o = Vector:new(self.x + rhs.x, self.y + rhs.y)
	return o
end

function Vector:__unm(op)
	return Vector:new(-op.x, -op.y)
end

function Vector:__sub(rhs)
	return self + (- rhs)
end

-- v * w will return the dot product
function Vector:__mul(rhs)
	return self.x * rhs.x + self.y * rhs.y
end

function Vector:norm()
	return math.sqrt(self.x^2 + self.y^2)
end

function Vector:distance(w)
	return (w - self):norm()
end

function Vector:new(x,y)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	
	o.x = x
	o.y = y
	
	return o
end

function Vector:scale(k)
	x = k * self.x
	y = k * self.y
	return Vector:new(x,y)
end

function Vector:angle()

	return math.deg(math.atan2(self.y, self.x))

end



