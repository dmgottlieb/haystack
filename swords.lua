function DrawSword(s)
	radians = math.rad(s.theta + s.offset)
	
	direction = {x = math.cos(radians), y = math.sin(radians)}
	
	hilt = {x = s.player.position.x + SIZE * direction.x + 1, y = s.player.position.y + SIZE * direction.y + 1}
	tip = {x = s.player.position.x + (SIZE + SWORD_LENGTH) * direction.x, y = s.player.position.y + (SIZE + SWORD_LENGTH) * direction.y}
	
	love.graphics.setColor(255,255,255)
	love.graphics.setLineWidth(3)
	love.graphics.line(hilt.x, hilt.y, tip.x, tip.y)
end

function DrawSwords(S)
	
	for i, s in ipairs(S) do
		DrawSword(s)
	end
	
end

function UpdateSwords(S, dt)

	for i, s in ipairs(S) do
		if s.theta >= 360 then
			table.remove(S,i)
		else
			UpdateSword(s, dt)
		end
	end
	
end

function UpdateSword(s, dt)
	
	s.theta = s.theta + dt * SWORD_SWEEP
	
end

