function DrawScore()
	love.graphics.setColor(0,0,0)
	
	love.graphics.print(P1.score, 15, HEIGHT - 35)
	love.graphics.print(P2.score, WIDTH - 35, HEIGHT - 35)
end

