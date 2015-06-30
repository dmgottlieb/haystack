function DrawCharacter(x,y)
	-- Draw a character centered at given coordinates
	
	love.graphics.setColor(0,0,100)
	love.graphics.circle('fill', x, y, SIZE, 20)
	
end

function MakeCharacters(N)
	
	characters = {}

	xrange = WIDTH - 50
	yrange = HEIGHT - 50

	for i = 1, N do
		
		characters[i] = {x = math.random(25, xrange), y = math.random(25, yrange), momentum = {x=0, y=0}}
		
	end
	
	return characters
	
end

function DrawCharacters(characters)
	
	for i, c in ipairs(characters) do
		
		DrawCharacter(c.x,c.y)
		
	end
	
end
