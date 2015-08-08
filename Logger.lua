-- Logger.lua
-- Idea: collect logs of sheep locations (and other info?) from game testing, for analysis. 

Logger = {
	events = {},
	header = "-- Haystack tactics log \n",
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
	
	-- Create logs folder if necessary. 
	if not love.filesystem.exists("logs") then
		love.filesystem.makeDirectory("logs")
	end

	-- get configs for this game
	local cfgs = getConfigs()

	-- create and open file
	name = "logs/hslog-" .. os.time() .. ".csv"
	f = love.filesystem.newFile(name)
	f:open("w")

	-- write header and map name
	f:write(self.header)
	f:write(self.map)

	-- write configs info 
	for key, value in pairs(cfgs) do
		local s = "-- " .. key .. "=" .. value .. "\n"
		f:write(s)
	end

	-- write events
	for i,l in ipairs(self.events) do
		f:write(l)
	end

	f:close()
end

function getConfigs()

	local cfgs = {}

	cfgs = readConfigsIntoTable(cfgs,"defaults.lua") 
	cfgs = readConfigsIntoTable(cfgs,"parameters.lua")

	return cfgs

end

function readConfigsIntoTable(table,filename)

	for line in love.filesystem.lines(filename) do
		-- strip comments
		line = line:gsub("%-%-(.*)", "")
		-- strip spaces
		line = line:gsub("%s", "")

		-- find key/value structure
		local split = line:find("=",1,false)
		if not (split == nil) then
			local key = line:sub(1,split-1)
			local value = line:sub(split+1)
			table[key] = value
		end
	end

	return table

end