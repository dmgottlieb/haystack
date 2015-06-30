function UpdatePlayer(p,dt)

	if love.keyboard.isDown('a','left') then
		p.x = p.x - (PACE * dt)
	elseif love.keyboard.isDown('d','right') then
		p.x = p.x + (PACE * dt)
	end
	
	if love.keyboard.isDown('w','up') then
		p.y = p.y - (PACE * dt)
	elseif love.keyboard.isDown('s','down') then
		p.y = p.y + (PACE * dt)
	end
	
	
end
