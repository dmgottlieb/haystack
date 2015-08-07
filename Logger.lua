-- Logger.lua
-- Idea: collect logs of sheep locations (and other info?) from game testing, for analysis. 

Logger = {
	events = {},
	header = "Haystack tactics log\n",
	data_fields = "event, x, y, time, memo" -- csv line with variable names
}

function Logger:new()
	o = {}
	setmetatable(o, self)
	self.__index = self


	-- Idea: initialize log header with automatic version info from git hook
	return o
end

function Logger:addEvent()
	-- Add csv line describing event
end

function Logger:writeLog()
	name = "logs/hslog-" .. os.time() .. ".csv"
	f = love.filesystem.newFile(name)
	f:open("w")
	f:write(self.header)
	for i,l in ipairs(self.events) do
		f.write(l)
	end
	f:close()
end