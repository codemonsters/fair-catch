function love.load()
    x = 0
end

function love.update(dt)
    x = x + 100 * dt
end

function love.draw()
    love.graphics.print("Hello World", x, 300)
end
