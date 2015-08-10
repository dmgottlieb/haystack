-- Game.lua 
-- 
-- Wrapper object for game, with NewGame() method.

Game = { 
	num_pcs = 2,
	num_npcs = 20,
	first_to = 3,
	live = true
}

function Game:NewGame(num_pcs, num_npcs, first_to, menu, scoredisp) 

	NUM_PCS = num_pcs
	NUM_NPCS = num_npcs
	self.first_to = first_to
	self.live = true


	Overlay.menuOn = menu
	Overlay.scoreOn = scoredisp

	Characters = MakeCharacters(NUM_NPCS)
	Swords = {}

	
	PCs = makePCs(NUM_PCS)
	for i,c in ipairs(PCs) do
		table.insert(Characters,c)
	end

	
	Log = Logger:new(MAP, CMTS)
	Log:addEvent("start","","","",os.time(),"")

end

function Game:EndGame()

	Log:addEvent("end","","","",os.time(),"")
	Log:writeLog()

	self.live = false
	Overlay.menuOn = true

	--Game:NewGame(self.num_pcs, self.num_npcs, self.first_to, true, false)

end

function Game:CheckState()

	for i,p in ipairs(PCs) do

		if p.score >= self.first_to then
			self:EndGame()
			return nil
		end

	end

end