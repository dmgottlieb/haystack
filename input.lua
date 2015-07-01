function UpdatePlayer(p,dt)
	
	dx = 0
	dy = 0

	-- if love.keyboard.isDown('a','left') then
	-- 	dx = - (PACE * dt)
	-- 	p.x = p.x + dx
	-- elseif love.keyboard.isDown('d','right') then
	-- 	dx = (PACE * dt)
	-- 	p.x = p.x + dx
	-- end
	--
	-- if love.keyboard.isDown('w','up') then
	-- 	dy = - (PACE * dt)
	-- 	p.y = p.y + dy
	-- elseif love.keyboard.isDown('s','down') then
	-- 	dy = (PACE * dt)
	-- 	p.y = p.y + dy
	-- end
	
	p.direction = math.deg(math.atan2(dy, dx))
	-- it would be nice if player's direction didn't change when they stood still. Current math makes you face right if you don't move. 
	
	p.attackTimer = p.attackTimer - dt
	if p.attackTimer <= 0 then
		p.canAttack = true
	end
	
	if love.keyboard.isDown(' ') and p.canAttack == true then
		sword = {player = p, theta = 0, offset = p.direction}
		table.insert(Swords, sword)
		
		-- Disable attack and set timer
		p.canAttack = false
		p.attackTimer = ATTACK_TIMER_MAX
	end
	
	
end

function GetPlayerMomentum(p)
	dx, dy = 0,0
	
	if love.keyboard.isDown('a','left') then
		dx = -1
	elseif love.keyboard.isDown('d','right') then
		dx = 1
	end
	
	if love.keyboard.isDown('w','up') then
		dy = -1
	elseif love.keyboard.isDown('s','down') then
		dy = 1
	end
	
	return {x = 1.2*PACE*dx, y = 1.2*PACE*dy}
	
end
