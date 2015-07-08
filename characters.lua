-- Character prototype
Character = 
{
	x = 0, 
	y = 0, 
	momentum = {x=0, y=0}, 
	direction = 0, 
	color = {r=100,g=100,b=100}, 
	PC = false
}

function Character:new()
	o = {}
	setmetatable(o, self)
	self.__index = self
	
	return o
end

function Character:draw()
	
	if not DEBUG then
		-- later graphics: a sheep
		love.graphics.setColor(255,255,255)
		love.graphics.draw(SheepImage, self.x, self.y, math.rad(self.direction), 1,1, 26, 15)
	else
		-- debug graphics -- plain circle
		love.graphics.setLineWidth(1)
		love.graphics.setColor(self.color.r,self.color.g,self.color.b)
		love.graphics.circle('fill', self.x, self.y, SIZE, 20)

		-- draw momentum vector, flocking neighborhood, separation neighborhood
		love.graphics.setColor(255,255,255)
		love.graphics.line(self.x, self.y, (self.x + self.momentum.x), (self.y + self.momentum.y))
		love.graphics.circle('line', self.x, self.y, FLOCK_NEIGHBORHOOD, 100)
		love.graphics.circle('line', self.x, self.y, FLOCK_NEIGHBORHOOD * FLOCK_SEPARATION, 100)
	end
	
end


function MakeCharacters(N)
	
	characters = {}

	xrange = WIDTH - 50
	yrange = HEIGHT - 50

	for i = 1, N do
		
		x = math.random(25, xrange)
		y = math.random(25, yrange)
		characters[i] = Character:new()
		characters[i].x = x
		characters[i].y = y
		
	end
	
	
	return characters
	
end

function DrawCharacters(characters)
	
	
	for i, c in ipairs(characters) do
		
		c:draw()
		
	end
	
end
