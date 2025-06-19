local playing = {
    name = "Pantalla de juego",
    img_sky = love.graphics.newImage("assets/images/sky.png"),
    img_water = love.graphics.newImage("assets/images/water.png"),
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
local newFisher = require("entities.fisher")
local newPower = require("entities.power")
local newSun = require("entities.sun")

-- carga este screen
function playing.load()
    table.insert(playing.creatures, newSardine1(0, playing.zones[1].y + playing.zones[1].height / 2, 1, playing))
    playing.fisher = newFisher()
    playing.power = newPower()
    playing.sun = newSun()
end

function playing.update(dt)
    playing.fisher:update(dt)

    for k, creature in pairs(playing.creatures) do
        creature:update(dt)
    end

    playing.power:update(dt)
    playing.sun:update(dt)
end

function playing.draw()
    love.graphics.clear(0, 0, 0)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(playing.img_sky, 0, 0)
    playing.sun:draw()
    --love.graphics.draw(playing.img_water, 0, 0)
    playing.fisher:draw()

    for k, creature in pairs(playing.creatures) do
        creature:draw()
        creature:draw_hitbox()
    end

    playing.power:draw()

    -- rectángulos que dividen las zonas del mar
    love.graphics.setColor(1, 0, 1)
    for k, zone in pairs(playing.zones) do
        love.graphics.rectangle("line", zone.x, zone.y, zone.width, zone.height)
        love.graphics.print(k, zone.x + 1, zone.y)
    end

end

function playing.keypressed(key, scancode, isrepeat)
    if scancode == "space" then
        if playing.fisher._state == playing.fisher.states.resting and playing.power._state == playing.power.states.hidden then
            -- empezar a cargar el lance
            playing.power:setState(playing.power.states.charging)
        else
        end
    end
end

function playing.keyreleased(key, scancode, isrepeat)
    if scancode == "space" then
        if playing.power._state == playing.power.states.charging then
            -- lanzar la caña
            playing.power:setState(playing.power.states.thrown)
        end
    end
end

return playing
