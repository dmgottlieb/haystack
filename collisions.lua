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

function Distance(x1, y1, x2, y2)
	return math.sqrt((x1 - x2)^2 + (y1 - y2)^2)
end

function DoCharacterCollisions(C)
	
	collisions = {}
	
	for i, c in ipairs(C) do
		
		for j = i,table.getn(C) do
			
			d = C[j]
			
			if CheckCollision(c, d) then
				-- In a perfectly inelastic collision, the two objects stick together and have the sum of the original momentums
				
				newMomentum = {}
				newMomentum.x = (c.momentum.x + d.momentum.x) / 2
				newMomentum.y = (c.momentum.y + d.momentum.y) / 2
				
				c.momentum.x, c.momentum.y = newMomentum.x, newMomentum.y
				d.momentum.x, d.momentum.y = newMomentum.x, newMomentum.y
				
			end
			
		end
		
	end
	
end

