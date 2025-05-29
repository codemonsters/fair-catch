local playing = {
    name = "Pantalla de juego",
    img_background = love.graphics.newImage("assets/images/background.png"),
    creatures = {},
    zones = {
        [1] = {
            x = 0,
            y = 54,
            width = WORLD_WIDTH,
            height = 54
        },
        [2] = {
            x = 0,
            y = 107,
            width = WORLD_WIDTH,
            height = 54
        },
        [3] = {
            x = 0,
            y = 162,
            width = WORLD_WIDTH,
            height = 54
        },
    },
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

    for k, creature in pairs(playing.creatures) do
        creature:draw()
    end

    -- rectángulos que dividen las zonas del mar
    love.graphics.setColor(1, 0, 1)
    for k, zone in pairs(playing.zones) do
        love.graphics.rectangle("line", zone.x, zone.y, zone.width, zone.height)
        love.graphics.print(k, zone.x + 1, zone.y)
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
