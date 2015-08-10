-- Overlay.lua
--
-- Menu interface and score display.

NewGameItem = {
	text = "NEW GAME",
	action = function(upordown) end
}

NumPlayersItem = {
	text = "2 PLAYERS",
	num = 2,
	action = function(self, upordown) 
			self.num = self.num + upordown
			self.num = math.max(self.num, 2)
			self.num = math.min(self.num, 4)
			self.text = "" .. self.num .. " PLAYERS"
		end
}

NumNPCsItem = {
	text = "20 NPCs",
	num = 20,
		action = function(self, upordown) 
			self.num = self.num + upordown
			self.num = math.max(self.num, 0)
			self.num = math.min(self.num, 100)
			self.text = "" .. self.num .. " NPCs"
		end
}

Overlay = {
	
	menuOn = true,
	menuItems = {NewGameItem, NumPlayersItem, NumNPCsItem},
	title = "HAYSTACK TACTICS",
	scoreOn = true,
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

	
	for i,item in ipairs(self.menuItems) do 
		love.graphics.setColor(245,245,245,128)
		if i == math.ceil(self.activeItem) then
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
	item = math.ceil(Overlay.activeItem)

	for i=1,num_controllers do
		if UpPush(i) > 0.9 then 
			Overlay:changeMenuSelection(-0.2 * UpPush(i)) 
		end
		if DownPush(i) > 0.9 then 
			Overlay:changeMenuSelection(0.2*DownPush(i)) 
		end
		if RightPush(i) > 0.5 then
			Overlay.menuItems[item]:action(1)
		end
		if LeftPush(i) > 0.5 then
			Overlay.menuItems[item]:action(-1)
		end

	end
end
