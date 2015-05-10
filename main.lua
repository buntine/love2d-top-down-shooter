player = {x = 200, y = 710, speed = 150, image = nil}

function love.load(a)
    player.image = love.graphics.newImage("assets/Aircraft_03.png")
end

function love.update(td)
    tryKill()
    tryMove(td)
end

function tryKill()
    if love.keyboard.isDown("escape") then
        love.event.push("quit")
    end
end

function tryMove(td)
    if love.keyboard.isDown("left") then
        if player.x > 0 then
            player.x = player.x - (player.speed * td)
        end
    elseif love.keyboard.isDown("right") then
        if player.x < (love.graphics.getWidth() - player.image:getWidth()) then
            player.x = player.x + (player.speed * td)
        end
    end
end

function love.draw(td)
    love.graphics.draw(player.image, player.x, player.y)
end
