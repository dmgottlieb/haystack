function UpdatePlayer(p,dt)
	
	dx = 0
	dy = 0
	
	p.direction = math.deg(math.atan2(p.momentum.y, p.momentum.x))
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
	
	dx = RightPush(p) - LeftPush(p)
	dy = DownPush(p) - UpPush(p)
	
	return {x = 1.2*PACE*dx, y = 1.2*PACE*dy}
	
end
