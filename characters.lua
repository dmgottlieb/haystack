require"Character"

function MakeCharacters(N)
	
	characters = {}

	xrange = love.graphics.getWidth() - 50
	yrange = love.graphics.getHeight() - 50

	for i = 1, N do
		
		x = math.random(25, xrange)
		y = math.random(25, yrange)
		characters[i] = Character:new()
		characters[i].x = x
		characters[i].y = y
		
	end
	
	
	return characters
	
end

function DrawCharacters(characters)
	
	
	for i, c in ipairs(characters) do
		
		c:draw()
		
	end
	
end
