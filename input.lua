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
	
	p.attackTimer = p.attackTimer - dt
	if p.attackTimer <= 0 then
		p.canAttack = true
	end
	
	if love.keyboard.isDown(' ') and p.canAttack == true then
		sword = {player = p, theta = 0}
		table.insert(Swords, sword)
		
		-- Disable attack and set timer
		p.canAttack = false
		p.attackTimer = ATTACK_TIMER_MAX
	end
	
	
end
