-- Moves a character to a new position. Characters use a random walk. 

-- To do
--
-- 1. Random walk is too jittery. Implement a model with a little bit of memory.
-- 2. Prevent collisions.
-- 3. Bound them within the screen area. 
	

function Walk(c, dt, pace)
	
	c.x = c.x + math.random(0,pace) - pace / 2
	c.y = c.y + math.random(0,pace) - pace / 2
	
end