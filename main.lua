_G.love = require("love")

function love.load()
    local width = love.graphics.getDimensions()
    Squere_size = width / 8
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
        return {
            x, y = 0, 0,
            legal_moves = {},
            image = love.graphics.newImage("pieces/"..notation..".svg.png")
        }
    end
    Pieces = {}
    for i = 1, #Starting_position do
        Pieces[i] = {}
        for j = 1, #Starting_position[i] do
            if Starting_position[i][j] ~= "" then
                Pieces[i][j] = Piece(Starting_position[i][j])
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
