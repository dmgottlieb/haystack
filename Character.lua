require"Vector"

-- Character prototype
Character = 
{
	position = Vector:new(0,0), 
	momentum = Vector:new(0,0), 
	direction = 0, 
	color = {r=100,g=100,b=100}
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
		love.graphics.draw(SheepImage, self.position.x, self.position.y, math.rad(self.direction), 1,1, 26, 15)
	else
		-- debug graphics -- plain circle
		love.graphics.setLineWidth(1)
		love.graphics.setColor(self.color.r,self.color.g,self.color.b)
		love.graphics.circle('fill', self.position.x, self.position.y, SIZE, 20)

		-- draw momentum vector, flocking neighborhood, separation neighborhood
		love.graphics.setColor(255,255,255)
		love.graphics.line(self.position.x, self.position.y, (self.position.x + self.momentum.x), (self.position.y + self.momentum.y))
		love.graphics.circle('line', self.position.x, self.position.y, FLOCK_NEIGHBORHOOD, 100)
		love.graphics.circle('line', self.position.x, self.position.y, FLOCK_NEIGHBORHOOD * FLOCK_SEPARATION, 100)
	end
	
end

local function sigmoid(x)
	val = 1 / (1 + math.exp(-x))
	return val
end

local function norm(x,y)
	return math.sqrt(x^2 + y^2)
end

function Character:walk(dt, pace)
	
	self.position = (self.position + self.momentum:scale(dt))
	
	if norm(self.momentum.x, self.momentum.y) > 0 then
		self.direction = math.deg(math.atan2(self.momentum.y, self.momentum.x))	
	end
	
	self.momentum = self:SheepFlock(dt)
	if math.random(0,1) < SHEEP_INITIATIVE * dt then
		direction = math.rad(math.random(0,359.9))
		self.momentum.x = self.momentum.x + 0.1*math.cos(direction)
		self.momentum.y = self.momentum.y + 0.1*math.sin(direction)
	end

	

	
end

-- implements the boids algorithm
function Character:SheepFlock(dt)

	neighbors = {}
	
	for i,d in ipairs(Characters) do
		
		if self ~= d then

			distance = self.position:distance(d.position)
			angle = (d.position - self.position):angle() - self.direction
		
			if (distance < FLOCK_NEIGHBORHOOD) and (angle < FLOCK_NEIGHBORHOOD_ANGLE) then
				table.insert(neighbors, d)
			end
			
		end
		
	end
	
	N = table.getn(neighbors)
	
	-- cohesion
	cohesion = {x = 0, y = 0}
	for i,d in ipairs(neighbors) do 
		displacement = (d.position - self.position)
		cohesion.x, cohesion.y = FLOCK_COHESION * (displacement.x)*dt + cohesion.x, FLOCK_COHESION * (displacement.y)*dt + cohesion.y
	end
	
	-- alignment
	alignment = {x = 0, y = 0}
	for i,d in ipairs(neighbors) do 
		alignment.x, alignment.y = (d.momentum.x / N) + alignment.x, (d.momentum.y / N) + alignment.y
	end
	alignment.x, alignment.y = FLOCK_ALIGNMENT * (alignment.x - self.momentum.x) * dt, FLOCK_ALIGNMENT * (alignment.y - self.momentum.y) * dt
	
	-- separation
	separation = {x = 0, y = 0}
	close_neighbors = {}
	
	for i,d in ipairs(neighbors) do
		if self.position:distance(d.position) < (FLOCK_SEPARATION * FLOCK_NEIGHBORHOOD) then
			table.insert(close_neighbors, d)
		end
	end
	
	for i,d in ipairs (close_neighbors) do 
		displacement = (d.position - self.position)
		separation.x, separation.y = -displacement.x*dt + separation.x, -displacement.y*dt + separation.y
	end
	
	-- soft stay-in-bounds
	bounding = Vector:new(0,0)
	Xmin, Xmax, Ymin, Ymax = 0 + 50, WIDTH - 50, 0 + 50, HEIGHT - 50
	
	if self.position.x < Xmin then
		bounding.x = 10
	end
	
	if self.position.x > Xmax then
		bounding.x = -10
	end
	
	if self.position.y < Ymin then
		bounding.y = 10
	end
	
	if self.position.y > Ymax then 
		bounding.y = -10
	end
	
	-- combination of velocities
	x = self.momentum.x + cohesion.x + alignment.x + separation.x + bounding.x
	y = self.momentum.y + cohesion.y + alignment.y + separation.y + bounding.y
	v = Vector:new(x,y)
	
	-- normalize to unit vector * PACE
	n = 1
	if v:norm() > PACE then
		n = v:norm() / PACE
	end

	v = v:scale(n) 
	
	-- speed decay: first attempt at making the sheep stop for a bit
	v = v:scale(DECAY^(10*dt))



	
	return v
	
	
end