-- GameOver.lua 
-- 
-- Post-game info screen. 

GameOver = {
	winner = 0,
	items = {},
	wiggle = 0
}

function GameOver:draw()

	self:DrawText()

end

function GameOver:update(dt)

	self.wiggle = self.wiggle + PACE * dt

end

function GameOver:DrawText()

	theta = WIGGLE_RANGE * math.sin(self.wiggle)

	love.graphics.setColor(220,220,130,200)
	love.graphics.printf("GAME OVER", 100, 100, 540, 'right', 0, 2)
	
	for i,item in ipairs(self.items) do 
		love.graphics.setColor(245,245,245,128)

		text = item.text .. "   "
		love.graphics.printf(text, 100, 148 + 52*i, 540, 'right', 0, 2)
		color = PCs[item.value].color
		love.graphics.setColor(color[1], color[2], color[3])
		love.graphics.draw(SheepImage, 1200, 175 + 52*i, theta, 1,1, 26, 15)
	end


end

function GameOver:new()

	o = {}
	setmetatable(o, self)
	self.__index = self

	self.items = {}

	score = 0
	winner = 1

	for i,p in ipairs(PCs) do

		if p.score >= score then
			self.winner = i
			score = p.score
		end
	end

	winner_text = "WINNER: "
	table.insert(self.items, {text=winner_text, value=winner})

	sups = GetTopSups(PCs, 3)

	for i, s in ipairs(sups) do 
		item = {
			text = s.title .. ": ",
			value = s.winner
		}
		table.insert(self.items, item)

	end


	return o

end