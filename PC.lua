require"Character"

-- PC prototype inherits Character prototype
PC = Character:new() -- is this redundant? see "constructor" below.
PC.PC = true
PC.canAttack = true
PC.attackTimer = ATTACK_TIMER_MAX

function PC:walk(dt, pace)
	-- call super method
	Character.walk(self,dt,pace)
	
	self.momentum = GetPlayerMomentum(self)
	self.momentum.x = self.momentum.x*pace
	self.momentum.y = self.momentum.y*pace

	UpdatePlayer(self, dt)
end

function PC:new()
	o = Character:new()
	setmetatable(o, self)
	self.__index = self

	o.PC = true
	o.canAttack = true
	o.attackTimer = ATTACK_TIMER_MAX
	
	return o
end

function PC:makePCs(numPCs)
	PCs = {}
	
	positions = {
		{x = WIDTH / 2 - 100, y = HEIGHT / 2 - 100},
		{x = WIDTH / 2 + 100, y = HEIGHT / 2 + 100}
	}
	
	for i = 1, numPCs do
		c = PC:new()
		c.controller = i
		c.score = 0
		c.x, c.y = positions[i].x, positions[i].y
		table.insert(PCs,c)
	end
	
	return PCs
end