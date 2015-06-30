

-- Moves a character to a new position. 

-- To do
--
-- 1. Improve walking model
-- 2. Prevent collisions.
-- 3. Bound them within the screen area. 
	

function Walk(c, dt, pace)
	
	c.x = c.x + pace * (sigmoid(c.momentum.x) - 0.5) * dt
	c.y = c.y + pace * (sigmoid(c.momentum.y) - 0.5) * dt
	
	c.x = math.max(c.x, 25)
	c.x = math.min(c.x, WIDTH - 25)
	c.y = math.max(c.y, 25)
	c.y = math.min(c.y, HEIGHT - 25)
	
	c.momentum.x = c.momentum.x + math.random(-0.5, 0.5)*10
	c.momentum.y = c.momentum.y + math.random(-0.5, 0.5)*10
	
end

function sigmoid(x)
	val = 1 / (1 + math.exp(-x))
	return val
end