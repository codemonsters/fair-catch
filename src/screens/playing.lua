local playing = {
    name = "Pantalla de juego",
    img_background = love.graphics.newImage("assets/images/background.png"),
    creatures = {}
}
local newSardine1 = require("entities.sardine1")

-- carga este screen
function playing.load()
    table.insert(playing.creatures, newSardine1(350, 10, playing))
end

function playing.update(dt)
    for k, creature in pairs(playing.creatures) do
        creature:update(dt)
    end
end

function playing.draw()
    love.graphics.clear(0, 0, 0)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(playing.img_background, 0, 0)
    --love.graphics.print("PARTIDA", 100, 100)
    for k, creature in pairs(playing.creatures) do
        creature:draw()
    end

    -- líneas que dividen las zonas del mar
    love.graphics.setColor(1, 0, 1)
    love.graphics.line(0, 54, WORLD_WIDTH, 54) -- línea entre cielo y zona alta
    love.graphics.line(0, 107, WORLD_WIDTH, 107) -- línea entre zona alta y media
    love.graphics.line(0, 162, WORLD_WIDTH, 162) -- línea entre zona media y baja


end

function playing.keypressed(key, scancode, isrepeat)
    --if scancode == "space" then
    --    changeScreen(require("screens/playing"))
    --end
end

function playing.keyreleased(key, scancode, isrepeat)
end

return playing
