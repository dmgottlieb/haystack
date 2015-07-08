function DrawCharacter(c)
	-- Draw a character centered at given coordinates
	
	
	-- later graphics: a sheep
	-- love.graphics.setColor(255,255,255)
	-- love.graphics.draw(SheepImage, c.x, c.y, math.rad(c.direction), 1,1, 26, 15)
	
	
	-- debug graphics -- plain circle
	love.graphics.setLineWidth(1)
	love.graphics.setColor(c.color.r,c.color.g,c.color.b)
	love.graphics.circle('fill', c.x, c.y, SIZE, 20)
	
	-- For debug: draw momentum vector, flocking neighborhood, separation neighborhood
	love.graphics.setColor(255,255,255)
	love.graphics.line(c.x, c.y, (c.x + c.momentum.x), (c.y + c.momentum.y))
	love.graphics.circle('line', c.x, c.y, FLOCK_NEIGHBORHOOD, 100)
	love.graphics.circle('line', c.x, c.y, FLOCK_NEIGHBORHOOD * FLOCK_SEPARATION, 100)
	
end

function MakeCharacters(N)
	
	characters = {}

	xrange = WIDTH - 50
	yrange = HEIGHT - 50

	for i = 1, N do
		
		characters[i] = {x = math.random(25, xrange), y = math.random(25, yrange), momentum = {x=0, y=0}, direction = 0, color = {r=100,g=100,b=100}, PC = false}
		
	end
	
	
	return characters
	
end

function DrawCharacters(characters)
	
	
	for i, c in ipairs(characters) do
		
		DrawCharacter(c)
		
	end
	
end
