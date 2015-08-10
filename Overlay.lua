-- Overlay.lua
--
-- Menu interface and score display.

NewGameItem = {
	text = "NEW GAME",
	action = function(self, upordown) 
			if not (upordown == 1) then return nil end
			local num_players = Overlay.menuItems[2].disp
			local num_NPCs = Overlay.menuItems[3].disp 
			local first_to = Overlay.menuItems[4].disp
			Game:NewGame(num_players, num_NPCs, first_to, false, true)
		end
}

NumPlayersItem = {
	text = "2 PLAYERS",
	num = 2,
	disp = 2,
	action = function(self, upordown) 
			self.num = self.num + upordown
			self.num = math.max(self.num, 2)
			self.num = math.min(self.num, 4)
			self.disp = math.ceil(self.num)
			self.text = "" .. self.disp .. " PLAYERS"
		end
}

NumNPCsItem = {
	text = "20 NPCs",
	num = 20,
	disp = 20,
		action = function(self, upordown) 
			self.num = self.num + upordown
			self.num = math.max(self.num, 0)
			self.num = math.min(self.num, 100)
			self.disp = math.ceil(self.num)
			self.text = "" .. self.disp .. " NPCs"
		end
}

FirstToItem = {
	text = "3 POINTS TO WIN",
	num = 3,
	disp = 3,
		action = function(self, upordown) 
			self.num = self.num + upordown
			self.num = math.max(self.num, 1)
			self.num = math.min(self.num, 10)
			self.disp = math.ceil(self.num)
			self.text = "" .. self.disp .. " POINTS TO WIN"
		end


}

Overlay = {
	
	menuOn = true,
	menuItems = {NewGameItem, NumPlayersItem, NumNPCsItem, FirstToItem},
	title = "HAYSTACK TACTICS",
	scoreOn = false,
	activeItem = 1
}



function Overlay:draw()

	if (self.menuOn) then
		Overlay:drawMenu()
	end

	if (self.scoreOn) then
		--Overlay:drawScore()
	end


end

function Overlay:menuStencil()

	love.graphics.print("I am a dog! I am a dog! \n I am a dog!", 100,100, 0, 2)

end

function Overlay:drawMenu()


	love.graphics.setColor(220,220,130,200)
	love.graphics.printf(self.title, 100, 100, 540, 'center', 0, 2)

	active = math.ceil(self.activeItem)

	
	for i,item in ipairs(self.menuItems) do 
		love.graphics.setColor(245,245,245,128)
		if i == active then
			love.graphics.setColor(245,245,245,255)
		end
		love.graphics.printf(item.text, 100, 148 + 52*i, 540, 'center', 0, 2)
	end


end

-- pass 1 or -1 to change menu selection
function Overlay:changeMenuSelection(upordown)

	num = table.getn(self.menuItems)
	self.activeItem = self.activeItem + upordown
	self.activeItem = math.max(1, self.activeItem)
	self.activeItem = math.min(num, self.activeItem)

end 

function Overlay:getInput()

	num_controllers = 2
	item = math.ceil(self.activeItem)

	for i=1,num_controllers do
		if UpSelect(i) > 0.5 then 
			Overlay:changeMenuSelection(- 0.2) 
		end
		if DownSelect(i) > 0.5 then 
			Overlay:changeMenuSelection(0.2) 
		end
		if RightSelect(i) > 0.5 then
			Overlay.menuItems[item]:action(0.2)
		end
		if LeftSelect(i) > 0.5 then
			Overlay.menuItems[item]:action(-0.2)
		end
		if SwordButton(i) then
			Overlay.menuItems[item]:action(1)
		end

	end
end
