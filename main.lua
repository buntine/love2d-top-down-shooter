canShoot = true
shootMax = 0.2
shootTimer = shootMax

spawnEnemyMax = 1.1
spawnEnemyTimer = spawnEnemyMax

bulletImage = nil
enemyImage = nil

bullets = {}
enemies = {}
player = {x = 200, y = 710, speed = 150, image = nil}

function love.load(a)
    bulletImage = love.graphics.newImage("assets/bullet_2_orange.png")
    player.image = love.graphics.newImage("assets/Aircraft_03.png")
end

function love.update(td)
    tryKill()
    tryMove(td)
    tryShoot(td)
    spawnEnemy(td)
    positionBullets(td)
    positionEnemies(td)
end

function love.draw(td)
    drawPlayer()
    drawBullets()
    drawEnemies()
end

function tryKill()
    if love.keyboard.isDown("escape") then
        love.event.push("quit")
    end
end

function tryShoot(td)
    if not canShoot then
        shootTimer = shootTimer - (1 * td)

        if shootTimer < 0 then
            canShoot = true
        end
    end

    if love.keyboard.isDown(' ') and canShoot then
        bullet = {x = player.x + (player.image:getWidth() / 2), y = player.y, image = bulletImage, speed = 140}
        table.insert(bullets, bullet)
        canShoot = false
        shootTimer = shootMax
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

function spawnEnemy(td)
    spawnEnemyTimer = spawnEnemyTimer - (1 * td)

    if spawnEnemyTimer < 0 then
        print "Enemy"
        enemy = {x = 100, y = 0, image = enemyImage, speed = 100}
        table.insert(enemies, enemy)
        spawnEnemyTimer = spawnEnemyMax
    end
end

function positionEnemies(td)
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

function drawEnemies()
end
