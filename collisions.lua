-- Problems with current collision logic: 
-- 1. Characters raft up after colliding. Random walk should be able to push them apart, but in practice it doesn't seem to happen. 
-- 2. The push from the edge of the screen doesn't interact with the rest of the movement logic, with the side effect that characters can get all jammed up there.

-- Possible solution to 1.: on collision, just zero momentum in direction of movement. 
-- Further, it would help if collision + movement code actually prevented characters from overlapping, or much overlapping. Current collision code only gently discourages that. 

function CheckCollision(c, d)
	
	if Distance(c.x, c.y, d.x, d.y) <= 2*SIZE then
		return true
	else
		return false
	end
	
end

function DoWallCollision(c)
	
	
	if (c.x <= 25) then
		c.momentum.x = math.max(0, c.momentum.x)
	end
	
	if (c.x >= WIDTH - 25) then
		c.momentum.x = math.min(0, c.momentum.x)
	end
	
	if (c.y <= 25) then
		c.momentum.y = math.max(0, c.momentum.y)
	end
	
	if (c.y >= HEIGHT - 25) then
		c.momentum.y = math.min(0, c.momentum.y)
	end
	
end

function Distance(x1, y1, x2, y2)
	return math.sqrt((x1 - x2)^2 + (y1 - y2)^2)
end

function DoCharacterCollisions(C)
	
	collisions = {}
	
	for i, c in ipairs(C) do
		
		for j = (i+1),table.getn(C) do
			
			d = C[j]
			
			if CheckCollision(c, d) then
				
				if DEBUG then
					c.color = {r=200,g=100,b=100}
					d.color = {r=200,g=100,b=100}
				end
				
				normal = {x = d.x - c.x, y = d.y - c.y}
				
				-- project c.momentum onto normal vector
				coeff_c = (c.momentum.x * normal.x + c.momentum.y * normal.y) / (normal.x * normal.x + normal.y * normal.y)
				projectionc = {x = coeff_c * normal.x, y = coeff_c * normal.y}
				coeff_d = (d.momentum.x * normal.x + d.momentum.y * normal.y) / (normal.x * normal.x + normal.y * normal.y)
				projectiond = {x = coeff_d * normal.x, y = coeff_d * normal.y}

				
				c.momentum.x, c.momentum.y = c.momentum.x - projectionc.x, c.momentum.y - projectionc.y
				d.momentum.x, d.momentum.y = d.momentum.x - projectiond.x, d.momentum.y - projectiond.y
				
				-- if DEBUG then
				-- 	normal_angle = math.deg(math.atan2(normal.y, normal.x))
				-- 	sword = {player = c, theta = 0, offset = normal_angle }
				-- 	table.insert(Swords, sword)
				-- end
				
			end
			
			
			
		end
		
		DoWallCollision(c)
		
	end
	
end

