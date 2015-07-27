require"Character"

-- PC prototype inherits Character prototype
PC = {
	position = Vector:new(0,0), 
	momentum = Vector:new(0,0), 
	direction = 0, 
	color = {r=100,g=100,b=100},
	timeAlive = 0,
	wiggle = 0,
	attackTimer = ATTACK_TIMER_MAX,
	canAttack = true,
	PC = true
}
setmetatable(PC, {__index = Character})


function PC:walk(dt, pace)
	-- call super method
	Character.walk(self,dt,pace)
	
	self.position = (self.position + self.momentum:scale(dt))


	self.momentum = GetPlayerMomentum(self)
	self.momentum.x = self.momentum.x*pace
	self.momentum.y = self.momentum.y*pace

	UpdatePlayer(self, dt)
end

function PC:new()
	o = {}
	setmetatable(o, self)
	self.__index = self

	self.position = Vector:new(0,0)
	self.momentum = Vector:new(0,0)
	self.direction = 0
	self.color = {r=100,g=100,b=100}
	self.timeAlive = 0
	self.wiggle = 0
	self.attackTimer = ATTACK_TIMER_MAX
	self.canAttack = true
	self.PC = true

	
	return o
end

function makePCs(numPCs)
	PCs = {}
	
	positions = {
		{x = -50, y = 400},
		{x = -50, y = 600}
	}
	
	for i = 1, numPCs do
		local c = PC:new()
		c.controller = i
		c.score = 0
		c.position = Vector:new(positions[i].x, positions[i].y)
		table.insert(PCs,c)
	end
	
	

	return PCs
end