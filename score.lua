function DrawScore(players)
	--love.graphics.setColor(0,0,0)

	local scorePositions = {

		{x = 15, y = HEIGHT - 35},
		{x = WIDTH - 30, y = HEIGHT - 35},
		{x = 15, y = 15},
		{x = WIDTH - 30, y = 15}

}
	
	for i, p in ipairs(players) do
		r,g,b = p.color[1], p.color[2], p.color[3]
		love.graphics.setColor(r,g,b)
		love.graphics.print(p.score, scorePositions[i].x, scorePositions[i].y)
	end
end

