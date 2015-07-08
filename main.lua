require"characters"
require"setup"
require"walk"
require"input"
require"swords"
require"collisions"
require"controllers"
require"score"

NUM_NPCS = 30
WIDTH = 1280
HEIGHT = 800
PACE = 50
ATTACK_TIMER_MAX = 2.0
SIZE = 10 -- character size
SWORD_LENGTH = 20
SWORD_SWEEP = 540
DEBUG = true


FLOCK_NEIGHBORHOOD = 100
FLOCK_COHESION = 0.01
FLOCK_SEPARATION = 0.25
FLOCK_ALIGNMENT = 0.125
SHEEP_INITIATIVE = 0.001


function love.load()
	
	love.graphics.setBackgroundColor(190,190,210)
	font = love.graphics.newFont("assets/pcsenior.ttf", 24)
	love.graphics.setFont(font)
	
	SheepImage = love.graphics.newImage("assets/sheep-s.png")
	
	Characters = MakeCharacters(NUM_NPCS)
	Swords = {}
	
	P1 = {x = WIDTH / 2 - 100, y = HEIGHT / 2 - 100, direction = 0, canAttack = true, attackTimer = ATTACK_TIMER_MAX, momentum={x=0, y=0}, color = {r=100,g=100,b=100}, PC = true, controller=1, score=0}
    P2 = {x = WIDTH / 2 + 100, y = HEIGHT / 2 + 100, direction = 0, canAttack = true, attackTimer = ATTACK_TIMER_MAX, momentum={x=0, y=0}, color = {r=100,g=100,b=100}, PC = true, controller=2, score=0}
	table.insert(Characters,P1)
	table.insert(Characters,P2)
	
	
end

function love.draw(dt)

	DrawCharacters(Characters)
	DrawSwords(Swords)
	DrawScore()

end

function love.update(dt)
	
	-- Collisions
	DoCharacterCollisions(Characters)
	DoSwordCollisions(Swords, Characters)
	
	for i, c in ipairs(Characters) do
		Walk(c, dt, PACE)
	end
	
	-- Player input logic goes here
	UpdatePlayer(P1,dt)
	UpdatePlayer(P2,dt)
	UpdateSwords(Swords, dt)
	

	
	
end
