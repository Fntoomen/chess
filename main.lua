_G.love = require("love")

function love.load()
	local width = love.graphics.getDimensions()
	Squere_size = width / 8

	local files = {"a","b","c","d","e","f","g","h"}

	Starting_position = {
		{"bR", "bN", "bB", "bQ", "bK", "bB", "bN", "bR"},
		{"bP", "bP", "bP", "bP", "bP", "bP", "bP", "bP"},
		{"", "", "", "", "", "", "", ""},
		{"", "", "", "", "", "", "", ""},
		{"", "", "", "", "", "", "", ""},
		{"", "", "", "", "", "", "", ""},
		{"wP", "wP", "wP", "wP", "wP", "wP", "wP", "wP"},
		{"wR", "wN", "wB", "wQ", "wK", "wB", "wN", "wR"},

	}

	function legalPawnMoves(notation, isWhite)
		local legal_moves = {}

		if notation[2] == "P" then
			if isWhite then
				table.insert(legal_moves, {0, 1})  -- Pawn can move one square forward
				if notation[1] == "2" then
					table.insert(legal_moves, {0, 2})  -- Pawn can move two squares forward on its first move
				end
			else
				table.insert(legal_moves, {0, -1})  -- Pawn can move one square forward (for black)
				if notation[1] == "7" then
					table.insert(legal_moves, {0, -2})  -- Pawn can move two squares forward on its first move (for black)
				end
			end
		end

		return legal_moves
	end

	-- Function to calculate legal moves for Rooks
	function legalRookMoves(notation)
		local legal_moves = {}
		local files = "abcdefgh"
		local rank = tonumber(notation:sub(2, 2))
		local file = notation:sub(1, 1)

		for i = 1, 8 do
			if files:sub(i, i) ~= file then
				table.insert(legal_moves, {i - 1, 0})  -- Horizontal moves
			end
			if i ~= rank then
				table.insert(legal_moves, {0, i - rank})  -- Vertical moves
			end
		end

		return legal_moves
	end

	-- Function to calculate legal moves for Knights
	function legalKnightMoves(notation)
		local legal_moves = {}
		local files = "abcdefgh"
		local rank = tonumber(notation:sub(2, 2))
		local file = notation:sub(1, 1)

		local knight_offsets = {
			{-2, -1}, {-2, 1},
			{-1, -2}, {-1, 2},
			{1, -2}, {1, 2},
			{2, -1}, {2, 1}
		}

		for _, offset in ipairs(knight_offsets) do
			local new_rank = rank + offset[1]
			local new_file_index = files:find(file) + offset[2]
			if new_rank >= 1 and new_rank <= 8 and new_file_index >= 1 and new_file_index <= 8 then
				local new_file = files:sub(new_file_index, new_file_index)
				table.insert(legal_moves, {new_file_index - files:find(file), new_rank - rank})
			end
		end

		return legal_moves
	end

	-- Function to calculate legal moves for Bishops
	function legalBishopMoves(notation)
		local legal_moves = {}
		local files = "abcdefgh"
		local rank = tonumber(notation:sub(2, 2))
		local file = notation:sub(1, 1)

		for i = 1, 8 do
			if files:sub(i, i) ~= file then
				local delta_rank = i - rank
				local delta_file = files:sub(i, i):byte() - file:byte()
				if math.abs(delta_rank) == math.abs(delta_file) then
					table.insert(legal_moves, {delta_file, delta_rank})
				end
			end
		end

		return legal_moves
	end

	-- Function to calculate legal moves for Queens (combining Rook and Bishop moves)
	function legalQueenMoves(notation)
		local legal_moves = {}
		local rook_moves = legalRookMoves(notation)
		local bishop_moves = legalBishopMoves(notation)

		for _, move in ipairs(rook_moves) do
			table.insert(legal_moves, move)
		end

		for _, move in ipairs(bishop_moves) do
			table.insert(legal_moves, move)
		end

		return legal_moves
	end

	-- Function to calculate legal moves for Kings
	function legalKingMoves(notation)
		local legal_moves = {}
		local files = "abcdefgh"
		local rank = tonumber(notation:sub(2, 2))
		local file = notation:sub(1, 1)

		local king_offsets = {
			{-1, -1}, {-1, 0}, {-1, 1},
			{0, -1},           {0, 1},
			{1, -1}, {1, 0}, {1, 1}
		}

		for _, offset in ipairs(king_offsets) do
			local new_rank = rank + offset[1]
			local new_file_index = files:find(file) + offset[2]
			if new_rank >= 1 and new_rank <= 8 and new_file_index >= 1 and new_file_index <= 8 then
				local new_file = files:sub(new_file_index, new_file_index)
				table.insert(legal_moves, {new_file_index - files:find(file), new_rank - rank})
			end
		end

		return legal_moves
	end



	function Piece(notation)
		local function legalMoves()
			if notation[2] == "P" then
				if notation[1] == "w" then
					return legalPawnMoves(file..number, true)
				else
					return legalPawnMoves(file..number, false)
				end
			elseif notation[2] == "R" then
				return legalRookMoves(file..number)
			elseif notation[2] == "N" then
				return legalKnightMoves(file..number)
			elseif notation[2] == "B" then
				return legalBishopMoves(file..number)
			elseif notation[2] == "Q" then
				return legalQueenMoves(file..number)
			else
				return legalKingMoves(file..number)
			end
		end

		return {
			file = "",
			rank = 0,
			legal_moves,
			image = love.graphics.newImage("pieces/"..notation..".svg.png")
		}
	end

	Pieces = {}
	for i = 1, #Starting_position do
		Pieces[i] = {}
		for j = 1, #Starting_position[i] do
			if Starting_position[i][j] ~= "" then

				Pieces[i][j] = Piece(Starting_position[i][j])
				Pieces[i][j].file = files[j]
				Pieces[i][j].numer = i

			end
		end
	end
end

function love.update(dt)
end

function love.draw()
	for i = 0, 7 do
		for j = 0, 7 do
			if (i+j) % 2 == 0 then
				love.graphics.setColor(238 / 255, 238 / 255, 210 / 255)
			else
				love.graphics.setColor(118 / 255, 150 / 255, 86 / 255)
			end

			love.graphics.rectangle("fill", i * Squere_size, j * Squere_size, Squere_size, Squere_size)

		end
	end
	for i = 1, #Starting_position do
		for j = 1, #Starting_position[i] do
			if Pieces[j][i] ~= nil then

				love.graphics.draw(Pieces[j][i].image, (i-1) * Squere_size + 5, (j-1) * Squere_size + 5)

			end
		end
	end
end
