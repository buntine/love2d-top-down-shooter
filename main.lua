canShoot = true
canShootMax = 0.2
canShootTimer = canShootMax
bulletImage = nil

bullets = {}
player = {x = 200, y = 710, speed = 150, image = nil}

function love.load(a)
    bulletImage = love.graphics.newImage("assets/bullet_2_orange.png")
    player.image = love.graphics.newImage("assets/Aircraft_03.png")
end

function love.update(td)
    tryKill()
    tryMove(td)
    tryShoot(td)
    positionBullets(td)
end

function love.draw(td)
    drawPlayer()
    drawBullets()
end

function tryKill()
    if love.keyboard.isDown("escape") then
        love.event.push("quit")
    end
end

function tryShoot(td)
    if not canShoot then
        canShootTimer = canShootTimer - (1 * td)

        if canShootTimer < 0 then
            canShoot = true
        end
    end

    if love.keyboard.isDown(' ') and canShoot then
        bullet = {x = player.x + (player.image:getWidth() / 2), y = player.y, image = bulletImage, speed = 140}
        table.insert(bullets, bullet)
        canShoot = false
        canShootTimer = canShootMax
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

function positionBullets(td)
    for i, b in ipairs(bullets) do
        b.y = b.y - (b.speed * td)

        if b.y < 0 then
            table.remove(bullets, i)
        end
    end
end

function drawPlayer()
    love.graphics.draw(player.image, player.x, player.y)
end

function drawBullets()
    for i, b in ipairs(bullets) do
        love.graphics.draw(b.image, b.x, b.y)
    end
end
