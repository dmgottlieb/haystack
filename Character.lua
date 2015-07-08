-- Character prototype
Character = 
{
	x = 0, 
	y = 0, 
	momentum = {x=0, y=0}, 
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

local function sigmoid(x)
	val = 1 / (1 + math.exp(-x))
	return val
end

local function norm(x,y)
	return x^2 + y^2
end

function Character:walk(dt, pace)
	
	self.x = self.x + (self.momentum.x) * dt
	self.y = self.y + (self.momentum.y) * dt
	
	if norm(self.momentum.x, self.momentum.y) > 0 then
		self.direction = math.deg(math.atan2(self.momentum.y, self.momentum.x))	
	end
	
	if not self.PC then
		self.momentum = self:SheepFlock(dt)
		if math.random(0,1) < SHEEP_INITIATIVE * dt then
			direction = math.rad(math.random(0,359.9))
			self.momentum.x = self.momentum.x + 0.1*math.cos(direction)
			self.momentum.y = self.momentum.y + 0.1*math.sin(direction)
		end
	else 
		self.momentum = GetPlayerMomentum(self)
		self.momentum.x = self.momentum.x*pace
		self.momentum.y = self.momentum.y*pace
	end
	

	
end

-- implements the boids algorithm
function Character:SheepFlock(dt)

	neighbors = {}
	
	for i,d in ipairs(Characters) do
		
		if self ~= d then
		
			if Distance(self.x, self.y, d.x, d.y) < FLOCK_NEIGHBORHOOD then
				table.insert(neighbors, d)
			end
			
		end
		
	end
	
	N = table.getn(neighbors)
	
	-- cohesion
	cohesion = {x = 0, y = 0}
	for i,d in ipairs(neighbors) do 
		displacement = {x = d.x - self.x, y = d.y - self.y}
		cohesion.x, cohesion.y = FLOCK_COHESION * (displacement.x / N)*dt + cohesion.x, FLOCK_COHESION * (displacement.y / N)*dt + cohesion.y
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
		if Distance(self.x, self.y, d.x, d.y) < (FLOCK_SEPARATION * FLOCK_NEIGHBORHOOD) then
			table.insert(close_neighbors, d)
		end
	end
	
	for i,d in ipairs (close_neighbors) do 
		displacement = {x = d.x - self.x, y = d.y - self.y}
		separation.x, separation.y = -displacement.x*dt + separation.x, -displacement.y*dt + separation.y
	end
	
	-- combination of velocities
	v = {x = self.momentum.x + cohesion.x + alignment.x + separation.x, y = self.momentum.y + cohesion.y + alignment.y + separation.y}
	-- normalize to unit vector * PACE
	n = norm(v.x, v.y) / PACE
	return {x = v.x / n, y = v.y / n}
	
	
end