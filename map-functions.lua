-- map-functions.lua

local tileW, tileH, tileset, quads, tileTable, entityInfo, entities

function loadMap(path)
	love.filesystem.load(path)()
end

function map2world(mx, my)
  return (mx-1)*tileW, (my-1)*tileH
end

function newMap(tileWidth, tileHeight, tileSetPath, tileString, quadInfo)
	
	
	tileset = love.graphics.newImage(tileSetPath)
	
	tileW, tileH = tileWidth, tileHeight
	local tilesetW, tilesetH = tileset:getWidth(), tileset:getHeight()

	
	quads = {}
	
	for i,info in ipairs(quadInfo) do
		quads[info[1]] = love.graphics.newQuad(info[2], info[3], tileW, tileH, tilesetW, tilesetH)
	end
	
	
	tileTable = {}
	
	local width = #(tileString:match("[^\n]+"))
	
	for x = 1, width do
		tileTable[x] = {}
	end
	
	local rowIndex, columnIndex = 1,1
	
	for row in tileString:gmatch("[^\n]+") do
		assert(#row == width, 'Map is not aligned: width of row ' .. tostring(rowIndex) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
		columnIndex=1
		for character in row:gmatch(".") do
			tileTable[columnIndex][rowIndex] = character
			columnIndex = columnIndex + 1
		end 
		rowIndex = rowIndex + 1
	end
end

function drawMap()
	
	for i,row in ipairs(tileTable) do
		for j,tile in ipairs(row) do
			love.graphics.draw(tileset, quads[tile], (i - 1)*tileW, (j - 1)*tileH)
		end
	end



end