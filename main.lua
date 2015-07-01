require"characters"
require"setup"
require"walk"
require"input"
require"swords"
require"collisions"

NUM_NPCS = 20
WIDTH = 640
HEIGHT = 480
PACE = 50
ATTACK_TIMER_MAX = 2.0
SIZE = 10 -- character size
SWORD_LENGTH = 20
SWORD_SWEEP = 540
DEBUG = true


function love.load()
	
	love.graphics.setBackgroundColor(190,190,210)
	Characters = MakeCharacters(NUM_NPCS)
	Swords = {}
	
	P1 = {x = WIDTH / 2, y = HEIGHT / 2, direction = 0, canAttack = true, attackTimer = ATTACK_TIMER_MAX, momentum={x=0, y=0}, color = {r=100,g=100,b=100}, PC = true}
	table.insert(Characters,P1)
	
	
end

function love.draw(dt)

	DrawCharacters(Characters)
	DrawSwords(Swords)

end

function love.update(dt)
	
	-- Collisions
	DoCharacterCollisions(Characters)
	
	for i, c in ipairs(Characters) do
		Walk(c, dt, PACE)
	end
	
	-- Player input logic goes here
	UpdatePlayer(P1,dt)
	UpdateSwords(Swords, dt)
	

	
	
end
