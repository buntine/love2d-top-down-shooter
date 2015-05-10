canShoot = true
shootMax = 0.2
shootTimer = shootMax

enemySpeedRange = {low = 100, high = 190}
spawnEnemyRange = {low = 0.5, high = 1.6}
spawnEnemyTimer = spawnEnemyRange.low

bulletImage = nil
enemyImage = nil

bullets = {}
enemies = {}
player = {x = 200, y = 710, speed = 150, image = nil}

function love.load(a)
    bulletImage = love.graphics.newImage("assets/bullet.png")
    enemyImage = love.graphics.newImage("assets/enemy.png")
    player.image = love.graphics.newImage("assets/hero.png")
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
        bullet = {
          x = player.x + (player.image:getWidth() / 2),
          y = player.y,
          image = bulletImage, 
          speed = 140}
        canShoot = false
        shootTimer = shootMax

        laser = love.audio.newSource("assets/gun.ogg", "static")
        laser:play()

        table.insert(bullets, bullet)
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
        enemy = {
          x = math.random(10, love.graphics.getWidth() - enemyImage:getWidth() - 10),
          y = -enemyImage:getHeight(),
          image = enemyImage,
          speed = math.random(enemySpeedRange.low, enemySpeedRange.high)}
        spawnEnemyTimer = math.random(spawnEnemyRange.low, spawnEnemyRange.high)

        table.insert(enemies, enemy)
    end
end

function positionEnemies(td)
    for i, e in ipairs(enemies) do
        e.y = e.y + (e.speed * td)

        if e.y > love.graphics.getHeight() then
            table.remove(enemies, i)
        end
    end
end

function positionBullets(td)
    for i, b in ipairs(bullets) do
        b.y = b.y - (b.speed * td)

        if b.y < 0 then
            table.remove(bullets, i)
        end

        for n, e in ipairs(enemies) do
            if collision(b, e) then
                hit = love.audio.newSource("assets/hit.ogg", "static")
                hit:play()

                table.remove(bullets, i)
                table.remove(enemies, n)
            end
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
    for i, e in ipairs(enemies) do
        love.graphics.draw(e.image, e.x, e.y)
    end
end

function collision(a, b)
    aw, ah = a.image:getDimensions()
    bw, bh = b.image:getDimensions()

    return a.x < (b.x + bw) and
      b.x < (a.x + aw) and
      a.y < (b.y + bh) and
      b.y < (a.y + ah)
end
