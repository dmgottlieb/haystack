-- Problems with current collision logic: 
-- 1. Characters raft up after colliding. Random walk should be able to push them apart, but in practice it doesn't seem to happen. 
-- 2. The push from the edge of the screen doesn't interact with the rest of the movement logic, with the side effect that characters can get all jammed up there.

-- Possible solution to 1.: on collision, just zero momentum in direction of movement. 
-- Further, it would help if collision + movement code actually prevented characters from overlapping, or much overlapping. Current collision code only gently discourages that. 

function CheckCollision(c, d)
	
	if Distance(c.position.x, c.position.y, d.position.x, d.position.y) <= 2*SIZE then
		return true
	else
		return false
	end
	
end

function DoWallCollision(c)
	
	
	if (c.position.x <= 25) then
		c.momentum.x = math.max(0, c.momentum.x)
	end
	
	if (c.position.x >= WIDTH - 25) then
		c.momentum.x = math.min(0, c.momentum.x)
	end
	
	if (c.position.y <= 25) then
		c.momentum.y = math.max(0, c.momentum.y)
	end
	
	if (c.position.y >= HEIGHT - 25) then
		c.momentum.y = math.min(0, c.momentum.y)
	end
	
end

function Distance(x1, y1, x2, y2)
	return math.sqrt((x1 - x2)^2 + (y1 - y2)^2)
end

function DoCharacterCollisions(C)
		
	for i, c in ipairs(C) do
		
		for j = (i+1),table.getn(C) do
			
			d = C[j]
			
			if CheckCollision(c, d) then
				
				if DEBUG then
					c.color = {r=200,g=100,b=100}
					d.color = {r=200,g=100,b=100}
				end
				
				normal = {x = d.position.x - c.position.x, y = d.position.y - c.position.y}
				
				-- project c.momentum onto normal vector
				coeff_c = math.min(0,(c.momentum.x * normal.x + c.momentum.y * normal.y) / (normal.x * normal.x + normal.y * normal.y))
				projectionc = {x = coeff_c * normal.x, y = coeff_c * normal.y}
				coeff_d = math.min(0,(d.momentum.x * normal.x + d.momentum.y * normal.y) / (normal.x * normal.x + normal.y * normal.y))
				projectiond = {x = coeff_d * normal.x, y = coeff_d * normal.y}

				
				c.momentum.x, c.momentum.y = c.momentum.x - projectionc.x, c.momentum.y - projectionc.y
				d.momentum.x, d.momentum.y = d.momentum.x - projectiond.x, d.momentum.y - projectiond.y
				
			end
			
			
			
		end
		
		DoWallCollision(c)
		DoObstacleCollisions(c)
		
	end
	
end

function DoObstacleCollisions(c)

	for i,o in ipairs(Obstacles) do
		displacement = -(o:getDisplacement(c.position))
		distance = displacement:norm()
		if distance <= SIZE then

			if DEBUG then
				c.color = {r=100,g=200,b=100}
			end

			coeff = math.min(0, c.momentum * displacement / (displacement:norm())^2)
			projection = displacement:scale(coeff)
				
			c.momentum = c.momentum - projection
		end
	end

end


function DoSwordCollisions(S, C)
	
	for i,s in ipairs(S) do
		
		direction = {x = math.cos(radians), y = math.sin(radians)}
		tip = {x = s.player.position.x + (SIZE + SWORD_LENGTH) * direction.x, y = s.player.position.y + (SIZE + SWORD_LENGTH) * direction.y}
		
		for j, c in ipairs(C) do
		
			if s.Player ~= c then
				
				if Distance(tip.x,tip.y,c.position.x,c.position.y) <= SIZE then
					
					if c.PC == true then
					
						s.player.score = s.player.score + 1

						x, y = c.position.x, c.position.y
						local corpse = NPC:new()
						corpse.position = Vector:new(x,y)
						corpse.alive = false
						table.insert(C, corpse)


					end

					if DEBUG then
						c.color = {r=100,g=100,b=10}
					end

					
					c:die()
					table.insert(C,MakeCharacters(1)[1])
					
				end
				
			end
			
		end
		
	end
	
end

