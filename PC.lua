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
	PC = true,
	baaTimer = BAA_TIMER_MAX
}
setmetatable(PC, {__index = Character})


function PC:walk(dt, pace)
	-- call super method
	Character.walk(self,dt,pace)

	if not self.alive then
		return nil
	end
	
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

	o.position = Vector:new(0,0)
	o.momentum = Vector:new(0,0)
	o.direction = 0
	o.color = {r=100,g=100,b=100}
	o.timeAlive = 0
	o.wiggle = 0
	o.attackTimer = ATTACK_TIMER_MAX
	o.canAttack = true
	o.PC = true
	o.alive = true

	
	return o
end

-- Returns a new PC with same attributes as object. Use for respawning after death. 
function PC:clone()
	clone = PC:new()

	clone.position = Vector:new(self.position.x, self.position.y)
	clone.momentum = Vector:new(self.momentum.x, self.momentum.y)
	clone.direction = self.direction
	clone.controller = self.controller
	clone.score = self.score

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
		c.baaTimer = BAA_TIMER_MAX
		table.insert(PCs,c)
	end
	
	

	return PCs
end