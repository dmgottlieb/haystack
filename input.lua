require"Vector"

function UpdatePlayer(p,dt)
	
	dx = 0
	dy = 0
		
	p.attackTimer = p.attackTimer - dt
	if p.attackTimer <= 0 then
		p.canAttack = true
	end
	
	if SwordButton(p.controller) and p.canAttack == true then
		sword = {player = p, theta = 0, offset = p.direction}
		table.insert(Swords, sword)

		-- log sword attack
		Log:addEvent("sword","PC",p.position.x, p.position.y, os.time(), "")
		
		-- Disable attack and set timer
		p.canAttack = false
		p.attackTimer = ATTACK_TIMER_MAX
	end
	
	
end

function GetPlayerMomentum(p)
	dx, dy = 0,0
	
	dx = RightPush(p.controller) - LeftPush(p.controller)
	dy = DownPush(p.controller) - UpPush(p.controller)
	
	return Vector:new(dx, dy)
	
end
