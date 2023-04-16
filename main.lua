_G.love = require("love")

function love.load()
    love.graphics.setBackgroundColor(204 / 255, 255 / 255, 153 / 255)
    love.graphics.setColor(0 / 255, 153 / 255, 90 / 255)
    
    pacman = {
        mode = "fill",
        x = 200,
        y = 200,
        radius = 50,
        alfa = 0.4,
        beta = 5.6,
        eat = false,
    }

    food = {
        mode = "fill",
        x = 500,
        y = 170,
        width = 40,
        height = 40,
        eaten = false,
        counter = 0,
    }
end

function love.update(dt)

    if love.keyboard.isDown("w") then
        pacman.y = pacman.y - 5
        pacman.alfa = pacman.alfa - 1.5
        pacman.beta = pacman.beta - 1.5
    end
    if love.keyboard.isDown("s") then
        pacman.y = pacman.y + 5
        pacman.alfa = pacman.alfa + 1.7
        pacman.beta = pacman.beta + 1.7
    end
    if love.keyboard.isDown("a") then
        pacman.x = pacman.x - 5
        pacman.alfa = pacman.alfa - 3
        pacman.beta = pacman.beta - 3
    end
    if love.keyboard.isDown("d") then
        pacman.x = pacman.x + 5
    end

    if (pacman.x >= food.x - 50 and pacman.x <= food.x + food.width + 50) and (pacman.y >= food.y - 50 and pacman.y <= food.y + 50) then
        pacman.eat = true
        food.counter = food.counter + 1
    else
        pacman.eat = false
    end

    if food.counter >= 20 then
        food.eaten=true
    end
end

function love.draw()
    if pacman.eat and not food.eaten then
        pacman.alfa = 1
        pacman.beta = 5
    end
    if not food.eaten then
        love.graphics.rectangle(food.mode, food.x, food.y, food.width, food.height)
    end
    love.graphics.arc(pacman.mode, pacman.x, pacman.y, pacman.radius, pacman.alfa, pacman.beta)
    if not (pacman.eat and not food.eaten) then
        pacman.alfa = 0.4
        pacman.beta = 5.6
    end

end