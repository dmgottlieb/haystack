function LeftPush(p)
	
	--keyboard arrows
	if p.controller==1 then
		if love.keyboard.isDown('left') then
			return 1
		end

	-- keyboard wasd		
	elseif p.controller==2 then
		if love.keyboard.isDown('a') then
			return 1
		end
	end
	
	return 0
	
end

function RightPush(p)
	
	--keyboard arrows
	if p.controller==1 then
		if love.keyboard.isDown('right') then
			return 1
		end

	-- keyboard wasd		
	elseif p.controller==2 then
		if love.keyboard.isDown('d') then
			return 1
		end
	end
	
	return 0
	
end

function DownPush(p)
	
	--keyboard arrows
	if p.controller==1 then
		if love.keyboard.isDown('down') then
			return 1
		end

	-- keyboard wasd		
	elseif p.controller==2 then
		if love.keyboard.isDown('s') then
			return 1
		end
	end
	
	return 0
	
end

function UpPush(p)
	
	--keyboard arrows
	if p.controller==1 then
		if love.keyboard.isDown('up') then
			return 1
		end
	
	-- keyboard wasd
	elseif p.controller==2 then
		if love.keyboard.isDown('w') then
			return 1
		end
	end
	
	return 0
	
end

function SwordButton(p)

	--keyboard arrows
	if p.controller==1 then
		if love.keyboard.isDown('rshift') then
			return true
		end
	
	-- keyboard wasd
	elseif p.controller==2 then
		if love.keyboard.isDown(' ') then
			return true
		end
	end
	
	return false	
end