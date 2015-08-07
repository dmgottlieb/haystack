-- Logger.lua
-- Idea: collect logs of sheep locations (and other info?) from game testing, for analysis. 

Logger = {
	events = {}
}

function Logger:new()
	o = {}
	setmetatable(o, self)
	self.__index = self
	
	return o
end

function Logger:addEvent()

end

function Logger:writeLog()
	name = "" .. os.time()
	f = love.filesystem.newFile(name)
	for i,l in ipairs(self.events) do
		f.write(l)
	end
	f:close()
end