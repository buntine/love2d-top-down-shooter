player = {x = 200, y = 710, speed = 150, image = nil}

function love.load(a)
    player.image = love.graphics.newImage("assets/Aircraft_03.png")
end

function love.update(td)
    if love.keyboard.isDown("escape") then
        love.event.push("quit")
    end
end

function love.draw(td)
    love.graphics.draw(player.image, player.x, player.y)
end
