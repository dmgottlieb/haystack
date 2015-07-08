

function Walk(c, dt, pace)
	
	c.x = c.x + (c.momentum.x) * dt
	c.y = c.y + (c.momentum.y) * dt
	
	if norm(c.momentum.x, c.momentum.y) > 0 then
		c.direction = math.deg(math.atan2(c.momentum.y, c.momentum.x))	
	end
	
	if not c.PC then
		c.momentum = SheepFlock(c,dt)
		if math.random(0,1) < SHEEP_INITIATIVE * dt then
			direction = math.rad(math.random(0,359.9))
			c.momentum.x = c.momentum.x + 0.1*math.cos(direction)
			c.momentum.y = c.momentum.y + 0.1*math.sin(direction)
		end
	else 
		c.momentum = GetPlayerMomentum(c)
		c.momentum.x = c.momentum.x*pace
		c.momentum.y = c.momentum.y*pace
	end
	

	
end

function sigmoid(x)
	val = 1 / (1 + math.exp(-x))
	return val
end

function norm(x,y)
	return x^2 + y^2
end

-- implements the boids algorithm
function SheepFlock(c,dt)

	neighbors = {}
	
	for i,d in ipairs(Characters) do
		
		if c ~= d then
		
			if Distance(c.x, c.y, d.x, d.y) < FLOCK_NEIGHBORHOOD then
				table.insert(neighbors, d)
			end
			
		end
		
	end
	
	N = table.getn(neighbors)
	
	-- cohesion
	cohesion = {x = 0, y = 0}
	for i,d in ipairs(neighbors) do 
		displacement = {x = d.x - c.x, y = d.y - c.y}
		cohesion.x, cohesion.y = FLOCK_COHESION * (displacement.x / N)*dt + cohesion.x, FLOCK_COHESION * (displacement.y / N)*dt + cohesion.y
	end
	
	-- alignment
	alignment = {x = 0, y = 0}
	for i,d in ipairs(neighbors) do 
		alignment.x, alignment.y = (d.momentum.x / N) + alignment.x, (d.momentum.y / N) + alignment.y
	end
	alignment.x, alignment.y = FLOCK_ALIGNMENT * (alignment.x - c.momentum.x) * dt, FLOCK_ALIGNMENT * (alignment.y - c.momentum.y) * dt
	
	-- separation
	separation = {x = 0, y = 0}
	close_neighbors = {}
	
	for i,d in ipairs(neighbors) do
		if Distance(c.x, c.y, d.x, d.y) < (FLOCK_SEPARATION * FLOCK_NEIGHBORHOOD) then
			table.insert(close_neighbors, d)
		end
	end
	
	for i,d in ipairs (close_neighbors) do 
		displacement = {x = d.x - c.x, y = d.y - c.y}
		separation.x, separation.y = -displacement.x*dt + separation.x, -displacement.y*dt + separation.y
	end
	
	-- combination of velocities
	v = {x = c.momentum.x + cohesion.x + alignment.x + separation.x, y = c.momentum.y + cohesion.y + alignment.y + separation.y}
	-- normalize to unit vector * PACE
	n = norm(v.x, v.y) / PACE
	return {x = v.x / n, y = v.y / n}
	
	
end