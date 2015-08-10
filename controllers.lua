function SetUpGamePads() 
	gamepads = love.joystick.getJoysticks()
end

function LeftPush(controller)
	
	--keyboard arrows
	if controller==1 then
		if love.keyboard.isDown('left') then
			return 1
		end

	-- keyboard wasd		
	elseif controller==2 then
		if love.keyboard.isDown('a') then
			return 1
		end
	
	else
		local joystick = Joysticks[controller - 2]
		return math.max(-joystick:getGamepadAxis("leftx"), 0)
	end
	
	return 0
	
end

function RightPush(controller)
	
	--keyboard arrows
	if controller==1 then
		if love.keyboard.isDown('right') then
			return 1
		end

	-- keyboard wasd		
	elseif controller==2 then
		if love.keyboard.isDown('d') then
			return 1
		end
	else
		local joystick = Joysticks[controller - 2]
		return math.max(joystick:getGamepadAxis("leftx"), 0)
	end
	
	return 0
	
end

function DownPush(controller)
	
	--keyboard arrows
	if controller==1 then
		if love.keyboard.isDown('down') then
			return 1
		end

	-- keyboard wasd		
	elseif controller==2 then
		if love.keyboard.isDown('s') then
			return 1
		end
	else
		local joystick = Joysticks[controller - 2]
		return math.max(joystick:getGamepadAxis("lefty"), 0)
	end
	
	return 0
	
end

function UpPush(controller)
	
	--keyboard arrows
	if controller==1 then
		if love.keyboard.isDown('up') then
			return 1
		end
	
	-- keyboard wasd
	elseif controller==2 then
		if love.keyboard.isDown('w') then
			return 1
		end
	else
		local joystick = Joysticks[controller - 2]
		return math.max(-joystick:getGamepadAxis("lefty"), 0)
	end
	
	return 0
	
end

function SwordButton(controller)

	--keyboard arrows
	if controller==1 then
		if love.keyboard.isDown('rshift') then
			return true
		end
	
	-- keyboard wasd
	elseif controller==2 then
		if love.keyboard.isDown(' ') then
			return true
		end
	else 
		local joystick = Joysticks[controller - 2]
		return joystick:isGamepadDown("a")
	end
	
	return false	
end