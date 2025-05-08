local menu = {
    name = "Pantalla menú"
}

-- carga esta pantalla
function menu.load()
    
end

function menu.update(dt)
end

function menu.draw()
    love.graphics.clear(1, 0, 1)
    love.graphics.line(0, 0, WORLD_WIDTH - 1, WORLD_HEIGHT - 1)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("MENÚ", 100, 100)
end

function menu.keypressed(key, scancode, isrepeat)
    if scancode == "space" then
        changeScreen(require("screens/playing"))
    end
end

function menu.keyreleased(key, scancode, isrepeat)
end

return menu
