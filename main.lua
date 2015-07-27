require"characters"
require"PC"
require"setup"
require"input"
require"swords"
require"collisions"
require"controllers"
require"score"
require"Vector"
require"map-functions"



function love.load(arg)

	LoadParameters()

	Obstacles = {}
	loadMap(MAP)
	
	Baa = love.audio.newSource("assets/baa.mp3", "static")

	WIDTH = love.graphics.getWidth()
	HEIGHT = love.graphics.getHeight()
	
	love.graphics.setBackgroundColor(100,225,85)
	font = love.graphics.newFont("assets/pcsenior.ttf", 24)
	love.graphics.setFont(font)
	
	SheepImage = love.graphics.newImage("assets/sheep-s.png")
	
	Characters = MakeCharacters(NUM_NPCS)
	Swords = {}

	
	PCs = makePCs(NUM_PCS)
	for i,c in ipairs(PCs) do
		table.insert(Characters,c)
	end

	Joysticks = {}
	
end

function love.joystickadded(joystick)
	table.insert(Joysticks, joystick)
	index = table.getn(Joysticks)
	for i, p in ipairs(PCs) do
		if (p.controller == 1) or (p.controller == 2) then
			p.controller = index + 2
			return nil
		end
	end
end


function LoadParameters()
	-- loads all parameters. 
	-- Default parameters are loaded from defaults.lua. 
	-- Since parameters.lua is run afterwards, values in this file override those in defaults.lua. 
	-- This is useful to me because I can have a tracked file with all the parameters (defaults.lua), and also try out changes in an untracked file (parameters.lua)
	defaults = love.filesystem.load('defaults.lua')
	parameters = love.filesystem.load('parameters.lua')
	defaults()
	parameters()
end

function love.draw(dt)

	drawMap()
	DrawCharacters(Characters)
	DrawSwords(Swords)

	DrawScore(PCs)


end

function love.update(dt)
	
	-- Collisions
	DoCharacterCollisions(Characters)
	DoSwordCollisions(Swords, Characters)
	
	for i, c in ipairs(Characters) do
		c:walk(dt, PACE)
	end
	
	UpdateSwords(Swords, dt)
	

	
	
end
