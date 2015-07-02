

function Walk(c, dt, pace)
	
	c.x = c.x + pace * (sigmoid(c.momentum.x) - 0.5) * dt
	c.y = c.y + pace * (sigmoid(c.momentum.y) - 0.5) * dt
	
	if not c.PC then
		-- c.momentum.x = c.momentum.x + math.random(-0.5, 0.5)*10
		-- c.momentum.y = c.momentum.y + math.random(-0.5, 0.5)*10
		c.momentum = SheepFlock(c)
	else 
		c.momentum = GetPlayerMomentum(c)
	end
	
	if norm(c.momentum.x, c.momentum.y) > 0 then
		c.direction = math.deg(math.atan2(c.momentum.y, c.momentum.x))	
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
function SheepFlock(c)

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
		cohesion.x, cohesion.y = 0.01 * (displacement.x / N) + cohesion.x, 0.01 * (displacement.y / N) + cohesion.y
	end
	
	-- alignment
	alignment = {x = 0, y = 0}
	for i,d in ipairs(neighbors) do 
		alignment.x, alignment.y = 0.125 * (d.momentum.x / N) + alignment.x, 0.125 * (d.momentum.y / N) + alignment.y
	end
	
	-- separation
	separation = {x = 0, y = 0}
	close_neighbors = {}
	
	for i,d in ipairs(neighbors) do
		if Distance(c.x, c.y, d.x, d.y) < (FLOCK_NEIGHBORHOOD / 2) then
			table.insert(close_neighbors, d)
		end
	end
	
	for i,d in ipairs (close_neighbors) do 
		displacement = {x = d.x - c.x, y = d.y - c.y}
		separation.x, separation.y = -displacement.x + separation.x, -displacement.y + separation.y
	end
	
	-- combination of velocities
	return {x = c.momentum.x + cohesion.x + alignment.x + separation.x, y = c.momentum.y + cohesion.y + alignment.y + separation.y}
	
	
end