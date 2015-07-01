

-- Moves a character to a new position. 

-- To do
--
-- 1. Improve walking model
-- 2. Prevent collisions.
-- 3. Bound them within the screen area. 
	

function Walk(c, dt, pace)
	
	c.x = c.x + pace * (sigmoid(c.momentum.x) - 0.5) * dt
	c.y = c.y + pace * (sigmoid(c.momentum.y) - 0.5) * dt
	
	if not c.PC then
		c.momentum.x = c.momentum.x + math.random(-0.5, 0.5)*10
		c.momentum.y = c.momentum.y + math.random(-0.5, 0.5)*10
	else 
		c.momentum = GetPlayerMomentum(c)
		print(c.momentum.x)
	end
			
		
	
end

function sigmoid(x)
	val = 1 / (1 + math.exp(-x))
	return val
end