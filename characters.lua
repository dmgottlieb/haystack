require"NPC"

function MakeCharacters(N)
	
	characters = {}

	xrange = WIDTH - 50
	yrange = HEIGHT - 50
	
	math.randomseed (os.time())

	for i = 1, N do
		
		
		x = math.random(-200, -50)
		y = math.random(50, yrange)
		c = NPC:new()
		c.position = Vector:new(x,y)
		c.baaTimer = BAA_TIMER_MAX
		-- c.direction = math.rad(math.random(0,359.9))
		-- speed = math.random()
		-- c.momentum.x = speed * PACE * math.cos(c.direction)
		-- c.momentum.y = speed * PACE * math.sin(c.direction)
		table.insert(characters, c)
		
	end
	
	
	return characters
	
end

function DrawCharacters(characters)
	
	
	for i, c in ipairs(characters) do
		
		c:draw()
		
	end
	
end
