require"characters"
require"PC"
require"setup"
require"input"
require"swords"
require"collisions"
require"controllers"
require"score"
require"Vector"

NUM_NPCS = 15
NUM_PCS = 0
WIDTH = 1280
HEIGHT = 800
PACE = 50
ATTACK_TIMER_MAX = 2.0
SIZE = 10 -- character size
SWORD_LENGTH = 20
SWORD_SWEEP = 540
DEBUG = false


FLOCK_NEIGHBORHOOD = 150
FLOCK_COHESION = 0.5
FLOCK_SEPARATION = 0.5
FLOCK_ALIGNMENT = 0.125
SHEEP_INITIATIVE = 0



function love.load(arg)
	
	love.graphics.setBackgroundColor(75,200,95)
	font = love.graphics.newFont("assets/pcsenior.ttf", 24)
	love.graphics.setFont(font)
	
	SheepImage = love.graphics.newImage("assets/sheep-s.png")
	
	Characters = MakeCharacters(NUM_NPCS)
	Swords = {}
	
	PCs = PC:makePCs(NUM_PCS)
	for i,c in ipairs(PCs) do
		table.insert(Characters,c)
	end

	
	
end

function love.draw(dt)

	DrawCharacters(Characters)
	DrawSwords(Swords)
	-- DrawScore()

end

function love.update(dt)
	
	-- Collisions
	DoCharacterCollisions(Characters)
	DoSwordCollisions(Swords, Characters)
	
	for i, c in ipairs(Characters) do
		c:walk(dt, PACE)
	end
	
	-- UpdateSwords(Swords, dt)
	

	
	
end
