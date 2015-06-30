require"characters"
require"setup"
require"walk"


NUM_NPCS = 25
WIDTH = 640
HEIGHT = 480
PACE = 5


function love.load()
	
	love.graphics.setBackgroundColor(190,190,210)
	NPCs = MakeCharacters(NUM_NPCS)
	
	
	
end

function love.draw(dt)

	DrawCharacters(NPCs)

end

function love.update(dt)
	
	for i, c in ipairs(NPCs) do
		Walk(c, dt, PACE)
	end
	
	-- Player input logic goes here
	
end
