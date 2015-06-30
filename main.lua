require"characters"
require"setup"
require"walk"
require"input"


NUM_NPCS = 10
WIDTH = 640
HEIGHT = 480
PACE = 40


function love.load()
	
	love.graphics.setBackgroundColor(190,190,210)
	NPCs = MakeCharacters(NUM_NPCS)
	
	P1 = {x = WIDTH / 2, y = HEIGHT / 2}
	
	
end

function love.draw(dt)

	DrawCharacters(NPCs)
	DrawCharacter(P1.x, P1.y)

end

function love.update(dt)
	
	for i, c in ipairs(NPCs) do
		Walk(c, dt, PACE)
	end
	
	-- Player input logic goes here
	UpdatePlayer(P1,dt)
	
	
end
