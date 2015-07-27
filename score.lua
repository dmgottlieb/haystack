function DrawScore(players)
	love.graphics.setColor(0,0,0)

	local scorePositions = {

		{x = 15, y = HEIGHT - 35},
		{x = WIDTH - 15, y = HEIGHT - 35},
		{x = 15, y = 15},
		{x = WIDTH - 15, y = 15}

}
	
	for i, p in ipairs(players) do
		love.graphics.print(p.score, scorePositions[i].x, scorePositions[i].y)
	end
end

