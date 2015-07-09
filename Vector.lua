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
	return {x = -op.x, y = -op.y}
end

function Vector:__sub(rhs)
	return self + (- rhs)
end

function Vector:norm()
	return math.sqrt(self.x^2 + self.y^2)
end

function Vector:new(x,y)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	
	o.x = x
	o.y = y
	
	return o
end





function Vector:distance(w)
	return (w - self):norm()
end