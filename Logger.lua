-- Logger.lua
-- Idea: collect logs of sheep locations (and other info?) from game testing, for analysis. 

Logger = {
	events = {},
	header = "--Haystack tactics log \n",
	map = "-- \n",
	data_fields = "event, char, x, y, time, memo" -- csv line with variable names
}

function Logger:new(map)
	o = {}
	setmetatable(o, self)
	self.__index = self


	-- Idea: initialize log header with automatic version info from git hook
	-- Also: what map is being played
	o.map = "-- map=" .. map .. "\n"
	return o
end

function Logger:addEvent(event, char, x, y, time, memo)
	-- Add csv line describing event
	line = "" .. event .. ", " .. char .. ", " .. x .. ", " .. y .. ", " .. time .. ", " .. memo .. " \n"
	table.insert(self.events, line)
end

function Logger:writeLog()
	name = "logs/hslog-" .. os.time() .. ".csv"
	f = love.filesystem.newFile(name)
	f:open("w")
	f:write(self.header)
	f:write(self.map)
	for i,l in ipairs(self.events) do
		f.write(l)
	end
	f:close()
end