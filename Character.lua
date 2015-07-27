require"Vector"
require"Obstacle"

-- Character prototype
Character = 
{
	position = Vector:new(0,0), 
	momentum = Vector:new(0,0), 
	direction = 0, 
	color = {r=100,g=100,b=100},
	timeAlive = 0,
	wiggle = 0,
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
	self.wiggle = self.wiggle + self.momentum:norm() * dt

	m = self.momentum
	if not self.PC then
		m = self:SheepFlock(dt)
	end
	if m:norm() > 0.0005*PACE then
		self.momentum = m
	else
		self.momentum = Vector:new(0,0)
	end

	if math.random(0,1) < SHEEP_INITIATIVE * dt then
		direction = math.rad(math.random(0,359.9))
		self.momentum.x = self.momentum.x + PACE * 0.1*math.cos(direction)
		self.momentum.y = self.momentum.y + PACE * 0.1*math.sin(direction)
	end

	if self.momentum:norm() > 5 then
		self.direction = math.deg(math.atan2(self.momentum.y, self.momentum.x) + WIGGLE_RANGE * math.sin(self.wiggle))	
	end

	

	self.timeAlive = self.timeAlive + dt

end

-- implements the boids algorithm
function Character:SheepFlock(dt)

	neighbors = {}
	
	for i,d in ipairs(Characters) do
		
		if self ~= d then

			distance = self.position:distance(d.position)
			angle = math.abs((d.position - self.position):angle() - self.direction)
		
			if (distance < FLOCK_NEIGHBORHOOD) and (angle < FLOCK_NEIGHBORHOOD_ANGLE) then
				table.insert(neighbors, d)
			end
			
		end
		
	end
	
	
	cohesion = self:getCohesion(neighbors,dt)
	alignment = self:getAlignment(neighbors,dt)
	separation = self:getSeparation(neighbors,dt)
	bounding = self:getBounding(dt)
	grain = self:goGetGrain(dt)
	threat = self:goAvoidThreat(dt)
	avoidance = self:avoidObstacles(dt)
	rushIn = self:rushIn(dt)
	
	
	

	
	-- combination of velocities
	v = self.momentum + 
			cohesion:scale(FLOCK_COHESION) + 
			alignment:scale(FLOCK_ALIGNMENT) + 
			bounding + 
			separation +
			grain:scale(GRAIN_DESIRE) + 
			threat:scale(THREAT_AVOID) + 
			avoidance:scale(OBSTACLE_AVOID)

	
	-- normalize to unit vector * PACE
	n = math.min(1, PACE / (v:norm()))
	v = v:scale(n)



	return v + self:rushIn(dt)
	
	
end

function Character:rushIn(dt)
	rushIn = Vector:new(0,0)
	if self.timeAlive <= RUSH_TIME then
		rushIn.x = PACE
	end
	return rushIn
end

function Character:avoidObstacles(dt)
	avoidance = Vector:new(0,0)

	nearbyObstacles = {}

	for i, o in ipairs(Obstacles) do 
		displacement = o:getDisplacement(self.position)
		distance = displacement:norm()
		if (distance < OBSTACLE_NEIGHBORHOOD) then
			table.insert(nearbyObstacles, o)
		end
	end

	for i, o in ipairs(nearbyObstacles) do 
		displacement = o:getDisplacement(self.position)
		avoidance = avoidance - displacement
	end

	avoidance = avoidance:scale(dt)

	return avoidance

end


function Character:getCohesion(neighbors,dt)

	N = math.max(1,table.getn(neighbors))
	cohesion = Vector:new(0,0)
	for i,d in ipairs(neighbors) do 
		displacement = (d.position - self.position)
		cohesion = displacement + cohesion
	end
	cohesion = cohesion:scale(dt / N)
	return cohesion
end

function Character:getAlignment(neighbors, dt)

	N = math.max(1,table.getn(neighbors))
	alignment = Vector:new(0,0)
	for i,d in ipairs(neighbors) do 
		alignment = (d.momentum - self.momentum) + alignment
	end
	alignment = alignment:scale(dt / N)

	return alignment
end

function Character:getSeparation(neighbors, dt)
	separation = Vector:new(0,0)
	close_neighbors = {}
	
	for i,d in ipairs(neighbors) do
		if self.position:distance(d.position) < (FLOCK_SEPARATION * FLOCK_NEIGHBORHOOD) then
			table.insert(close_neighbors, d)
		end
	end
	
	for i,d in ipairs (close_neighbors) do 
		displacement = (d.position - self.position)
		separation = (separation - displacement):scale(dt)
	end

	return separation

end


function Character:getBounding(dt)
	bounding = Vector:new(0,0)
	Xmin, Xmax, Ymin, Ymax = 0 + 50, WIDTH - 50, 0 + 50, HEIGHT - 50
	
	if self.position.x < Xmin then
		bounding.x = PACE * dt
	end
	
	if self.position.x > Xmax then
		bounding.x = - PACE * dt
	end
	
	if self.position.y < Ymin then
		bounding.y = PACE * dt
	end
	
	if self.position.y > Ymax then 
		bounding.y = - PACE * dt
	end
	return bounding
end

function Character:goGetGrain(dt)
	displacement = Vector:new(0,0)

	if love.mouse.isDown("l") then 
		grain_position = Vector:new(love.mouse.getX(), love.mouse.getY())
		displacement = grain_position - self.position
	end

	displacement:scale(dt)

	return displacement
end

function Character:goAvoidThreat(dt)
	displacement = Vector:new(0,0)

	if love.mouse.isDown("r") then 
		threat_position = Vector:new(love.mouse.getX(), love.mouse.getY())
		displacement =  self.position - threat_position
	end

	displacement:scale(dt)

	return displacement
end

function Character:doBaa()
	Baa:play()
end


