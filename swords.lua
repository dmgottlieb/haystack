function DrawSword(s)
	radians = math.rad(s.theta)
	
	direction = {x = math.cos(radians), y = math.sin(radians)}
	
	hilt = {x = s.player.x + SIZE * direction.x + 1, y = s.player.y + SIZE * direction.y + 1}
	tip = {x = s.player.x + (SIZE + SWORD_LENGTH) * direction.x, y = s.player.y + (SIZE + SWORD_LENGTH) * direction.y}
	
	love.graphics.setColor(255,255,255)
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
