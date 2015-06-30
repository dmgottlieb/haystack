require"characters"
require"setup"
require"walk"
require"input"
require"swords"


NUM_NPCS = 10
WIDTH = 640
HEIGHT = 480
PACE = 40
ATTACK_TIMER_MAX = 2.0
SIZE = 10 -- character size
SWORD_LENGTH = 20
SWORD_SWEEP = 540


function love.load()
	
	love.graphics.setBackgroundColor(190,190,210)
	NPCs = MakeCharacters(NUM_NPCS)
	Swords = {}
	
	P1 = {x = WIDTH / 2, y = HEIGHT / 2, canAttack = true, attackTimer = ATTACK_TIMER_MAX}
	
	
end

function love.draw(dt)

	DrawCharacters(NPCs)
	DrawCharacter(P1.x, P1.y)
	DrawSwords(Swords)

end

function love.update(dt)
	
	for i, c in ipairs(NPCs) do
		Walk(c, dt, PACE)
	end
	
	-- Player input logic goes here
	UpdatePlayer(P1,dt)
	UpdateSwords(Swords, dt)
	
	
end
