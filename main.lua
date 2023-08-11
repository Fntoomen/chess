_G.love = require("love")

function love.load()
    local width = love.graphics.getDimensions()
    Squere_size = width / 8

    local letters = {"a","b","c","d","e","f","g","h"}

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

    function Piece(notation)
        local function legalMoves()
            if notation[2] == "P" then
                legal_moves = {{0, 1}, {0, 2}}
            elseif notation[2] == "R" then
                legal_moves = {}
                for i = 1, 8 do
                    legal_moves[i] = {}
                end
            end
        end
        return {
            letter = "",
            number = 0,
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
                Pieces[i][j].letter = letters[j]
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
