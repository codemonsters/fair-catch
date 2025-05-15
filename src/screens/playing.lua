local playing = {
    name = "Pantalla de juego",
    img_background = love.graphics.newImage("assets/images/background.png")
}
local newSardine = require("entities/sardine")
local creatures = {};

-- carga este screen
function playing.load()
    newSardine(1,1)
    --table.insert(creatures, newSardine(WORLD_WIDTH, 0))
    table.insert(creatures, newSardine(0, 0))
    --table.insert(creatures, newSardine(20, 20))
end

function playing.update(dt)
    for k, creature in pairs(creatures) do
        creature:update(dt)
    end
end

function playing.draw()
    love.graphics.clear(0, 0, 0)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(playing.img_background, 0, 0)
    --love.graphics.print("PARTIDA", 100, 100)
    for k, creature in pairs(creatures) do
        creature:draw()
    end
end

function playing.keypressed(key, scancode, isrepeat)
    --if scancode == "space" then
    --    changeScreen(require("screens/playing"))
    --end
end

function playing.keyreleased(key, scancode, isrepeat)
end

return playing
