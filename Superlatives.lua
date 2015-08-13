-- Superlatives.lua
-- 
-- Computes endgame superlatives to display at game over screen, e.g. "most friendly," 
-- "most aggressive," "most solitary," "sneakiest," "best dodger." 
--
-- The idea is: each game, the game computes all the superlatives and displays the ~3 
-- most interesting ones. 
-- 
-- Most interesting might be: 
-- * those with widest separation between first and second place
-- * those which have not been displayed recently
-- * there should probably be some random element

Superlative = {
	title = "",
	value = 0,
	add = function(I) 
		return 0 
	end
}

function MakeSuperlatives() 

	ss = {
		mf = Superlative:new("MOST FRIENDLY", FriendlyAdd), 
		ma = Superlative:new("MOST AGGRESSIVE", SwordAdd), 
		ms = Superlative:new("MOST SOLITARY", SolitaryAdd),
		sn = Superlative:new("SNEAKIEST", SneakiestAdd),
		bd = Superlative:new("BEST DODGER", DodgerAdd),
		fe = Superlative:new("FASTEST", FastestAdd),
		mo = Superlative:new("MOST OBLIVIOUS", ObliviousAdd),
		ll = Superlative:new("LONGEST LIVED", LongestAdd)
	}

	return ss
end

function Superlative:new(title, add)

	o = {}
	setmetatable(o, self)
	self.__index = self

	o.title = title
	o.add = add
	o.value = 0
	
	return o
end

-- returns a list of winners of all superlatives, along with the zstat margin of victory
function GetWinners(pcs)

	winners = {}

	for k,v in pairs(pcs[1].ss) do

		winner = 0
		value = -1
		delta = 0

		for i,p in ipairs(pcs) do

			zval = sigmoid(p.ss[k].value)

			if zval > value then
				winner = i
				delta = zval - value
				value = zval
			end




		end

		winners[k] = {w=winner, d=delta}

	end

	sups = {}

	for k,v in pairs(winners) do

		s = {
			winner = winners[k].w,
			delta = winners[k].d,
			title = pcs[1].ss[k].title
		}
		table.insert(sups, s)

	end

	return sups

end

-- Returns the top num most interesting superlatives
function GetTopSups(pcs, num)

	sups = GetWinners(pcs)
	local f = function(c,d) 
			return c.delta < d.delta
	end

	table.sort(sups, f)

	top = {}

	for i = 1,num do 
		table.insert(top, sups[i])
	end

	return top

end

-- Call with s:add(c,dt) to update s.value
function FriendlyAdd(self,c,dt) 
	
	N = table.getn(c:getNeighbors())
	self.value = self.value + N*dt

end

function SwordAdd(self,c,dt)

	if not (c.canAttack) then 
		self.value = self.value + dt
	end

end

function SolitaryAdd(self,c,dt)

	N = table.getn(c:getNeighbors())
	self.value = self.value - N*dt

end

function SneakiestAdd(self,c,dt)

	if c.canAttack then
		self.value = self.value + dt
	end

end

function DodgerAdd(self,c,dt)

	neighbors = c:getNeighbors()
	for i,p in ipairs(neighbors) do
		if p.PC then
			if not (p.canAttack) then
				self.value = self.value + dt
			end
		end
	end

end

function ObliviousAdd(self,c,dt)

	neighbors = c:getNeighbors()
	for i,p in ipairs(neighbors) do
		if p.PC then
			if (c.canAttack) then
				self.value = self.value + dt
			end
		end
	end

end

function LongestAdd(self,c,dt)

	self.value = self.value + c.timeAlive * dt

end

function sigmoid(x)
	val = 1 / (1 + math.exp(-x))
	return val
end