-- GameOver.lua 
-- 
-- Post-game info screen. 

GameOver = {
	winner = 0,
	items = {}
}

function GameOver:draw()

	self:DrawText()

end

function GameOver:DrawText()


	love.graphics.setColor(220,220,130,200)
	love.graphics.printf("GAME OVER", 100, 100, 540, 'center', 0, 2)
	
	for i,item in ipairs(self.menuItems) do 
		love.graphics.setColor(245,245,245,128)

		love.graphics.printf(item.text, 100, 148 + 52*i, 540, 'center', 0, 2)
	end


end

function GameOver:new()

	o = {}
	setmetatable(o, self)
	self.__index = self

	self.items = {}

	score = 0

	for i,p in ipairs(PCs) do

		if p.score >= score then
			self.winner = i
			score = p.score
		end
	end

	winner_text = "WINNER: "
	table.insert(items, {text=winner_text, value=winner})

	sups = GetTopSups(PCs, 3)

	for i, s in ipairs(sups) do 
		item = {
			text = s.title .. ": ",
			value = s.winner
		}

	end


	return o

end