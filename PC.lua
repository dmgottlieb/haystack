require"Character"
require"Superlatives"

PC = Character:new()

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

	-- update all the superlative values
	for k,s in pairs(self.ss) do
		self.ss[k]:add(self,dt)
	end
	
	
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



-- leaves a corpse and respawns at left edge. Return corpse so calling process can add it to Characters list.
function PC:die()
	-- corpse = Character:new()
	-- corpse.position = Vector:new(self.position.x, self.position.y)
	-- corpse.alive = false

	local x = -50
	local y = math.random(50, HEIGHT - 50)
	self.position = Vector:new(x,y)
	self.timeAlive = 0
	self.alive = true

	--return corpse
end

function makePCs(numPCs)
	PCs = {}
	
	-- positions = {
	-- 	{x = -50, y = 150},
	-- 	{x = -50, y = 300},
	-- 	{x = -50, y = 450},
	-- 	{x = -50, y = 600}
	-- }

	colors = {
	{255, 255, 0},
	{127, 255, 127},
	{255, 127, 127},
	{127, 127, 255}
	
	}
	
	for i = 1, numPCs do
		local c = PC:new()
		c.controller = i
		c.score = 0
		y = math.random(50, HEIGHT - 50)
		c.position = Vector:new(-50, y)
		c.color = colors[i]
		c.baaTimer = BAA_TIMER_MAX
		c.ss = MakeSuperlatives()
		table.insert(PCs,c)
	end
	
	

	return PCs
end