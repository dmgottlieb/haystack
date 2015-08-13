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
require"Logger"
require"Overlay"
require"Game"
require"GameOver"



function love.load(arg)

	LoadParameters()

	Obstacles = {}
	loadMap(MAP)
	
	Baa = love.audio.newSource("assets/baa.mp3", "static")

	WIDTH = love.graphics.getWidth()
	HEIGHT = love.graphics.getHeight()
	
	-- love.graphics.setBackgroundColor(100,225,85)
	font = love.graphics.newFont("assets/pcsenior.ttf", 24)
	love.graphics.setFont(font)
	
	SheepImage = love.graphics.newImage("assets/sheep-s.png")
	DeadSheepImage = love.graphics.newImage("assets/deadsheep-s.png")
	
	Characters = {}
	Swords = {}
	PCs = {}
	Joysticks = {}

	CMTS = table.concat(arg, ' ')

	Screen = Overlay
	Game:NewGame(NUM_PCS, NUM_NPCS, 3, true, false)


	
end

function love.joystickadded(joystick)
	table.insert(Joysticks, joystick)

end


-- On quit, attempt to save game log.
--function love.quit()
-- Deprecated: now log on end game
--end

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

	love.graphics.setColor(255,255,255,255)
	drawMap()

	local corpses = {}
	local alive = {}

	for i,c in ipairs(Characters) do
		if c.alive then 
			table.insert(alive,c) 
		else
			table.insert(corpses,c)
		end
	end

	DrawCharacters(corpses)
	DrawCharacters(alive)
	
	DrawSwords(Swords)

	DrawScore(PCs)

	Screen:draw()


end

function love.update(dt)
	
	-- If 'esc' is pressed, launch debug console
	debugLoop()

	-- If menu is active, run menu input loop
	if Overlay.menuOn then
		Overlay:getInput()
	end

	if Game:CheckState() then
		Screen = GameOver:new()
	end

	-- Collisions
	DoCharacterCollisions(Characters)
	DoSwordCollisions(Swords, Characters)

	-- log positions -- 
	if Log:ready(dt) then
		time = os.time()
		for i,c in ipairs(Characters) do 
			local char = "NPC"
			if c.PC then char = "PC" end
			if not (c.alive) then char = "corpse" end
			local x = math.floor(c.position.x)
			local y = math.floor(c.position.y)
			Log:addEvent("position", char, x, y, time, "")
		end
	end
	
	for i, c in ipairs(Characters) do
		c:walk(dt, PACE)
	end
	
	UpdateSwords(Swords, dt)
	

	
	
end

-- If 'esc' is pressed, launch debug console
function debugLoop()

	if (love.keyboard.isDown("escape")) then
		debug.debug()
	end

end
