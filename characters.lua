require"NPC"

function MakeCharacters(N)
	
	characters = {}

	xrange = WIDTH - 50
	yrange = HEIGHT - 50
	
	math.randomseed( os.time() )

	for i = 1, N do
		
		x = math.random(50, xrange)
		y = math.random(50, yrange)
		c = NPC:new()
		c.position = Vector:new(x,y)
		table.insert(characters, c)
		
	end
	
	
	return characters
	
end

function DrawCharacters(characters)
	
	
	for i, c in ipairs(characters) do
		
		c:draw()
		
	end
	
end
