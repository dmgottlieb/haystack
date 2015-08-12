function DrawSword(s)
	radians = math.rad(s.theta + s.offset)
	
	direction = {x = math.cos(radians), y = math.sin(radians)}
	
	hilt = {x = s.player.position.x + (SIZE / 2) * direction.x + 1, y = s.player.position.y + SIZE * direction.y + 1}
	tip = {x = s.player.position.x + (SIZE + SWORD_LENGTH) * direction.x, y = s.player.position.y + (SIZE + SWORD_LENGTH) * direction.y}
	
	r,g,b = s.player.color[1], s.player.color[2], s.player.color[3]
	love.graphics.setColor(r,g,b)

	frame = math.ceil(9 * (s.theta+30) / 60)
	local img  = love.graphics.newImage("assets/swordsheet.png")
	local quad = love.graphics.newQuad((frame-1)*78, 0, 78, 55, img:getDimensions())
	love.graphics.draw(img, quad, s.player.position.x, s.player.position.y, math.rad(s.player.direction),1,1,26,30)

	-- love.graphics.setLineWidth(5)
	-- love.graphics.line(hilt.x, hilt.y, tip.x, tip.y)
end

function DrawSwords(S)
	
	for i, s in ipairs(S) do
		DrawSword(s)
	end
	
end

function UpdateSwords(S, dt)

	for i, s in ipairs(S) do
		if s.theta >= SWORD_RANGE then
			table.remove(S,i)
		else
			UpdateSword(s, dt)
		end
	end
	
end

function UpdateSword(s, dt)
	
	s.theta = s.theta + dt * SWORD_SWEEP
	
end

