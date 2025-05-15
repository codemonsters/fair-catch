-- enable debugging using local lua debugger vscode extension
if os.getenv "LOCAL_LUA_DEBUGGER_VSCODE" == "1" then
    local lldebugger = require "lldebugger"
    lldebugger.start()
    local run = love.run
    function love.run(...)
        local f = lldebugger.call(run, false, ...)
        return function(...) return lldebugger.call(f, false, ...) end
    end
end

Log = require("libraries/log/log") -- https://github.com/rxi/log.lua
Log.level = "trace"

--WORLD_WIDTH, WORLD_HEIGHT = 640, 360 -- El juego se crea por completo dentro de una pantalla de este tamaño (y posteriormente se escala según sea necesario)
WORLD_WIDTH, WORLD_HEIGHT = 384, 216 -- El juego se crea por completo dentro de una pantalla de este tamaño (y posteriormente se escala según sea necesario)

Mobile = love.system.getOS() == "iOS" or love.system.getOS() == "Android" -- flag para reflejar si se está ejecutando en un dispositivo móvil

local screen = nil

function changeScreen(newScreen)
    Log.debug("cargando pantalla: " .. newScreen.name)
    screen = newScreen
    screen.load()
end

function love.load()
    Log.info("Iniciando juego")

    love.graphics.setDefaultFilter("nearest") -- Cambiamos el filtro usado durante el escalado
    FontTitle = love.graphics.newFont("assets/fonts/fishing.otf", 80) -- https://www.dafont.com/fishing-7.font

    if Mobile then
        love.window.setFullscreen(true)
        WindowWidth, WindowHeight = love.graphics.getDimensions()
        Log.debug("Ejecutando en dispositivo móvil")
    else
        WindowWidth, WindowHeight = love.window.getDesktopDimensions()
        if love.window.getFullscreen() then
            Log.debug("Ejecutando en pantalla completa (resolución: " .. WindowWidth .. " x " .. WindowHeight .. " px)")
        else
            WindowWidth, WindowHeight = WindowWidth * .7, WindowHeight * .7 -- definimos el tamaño inicial de la ventana
            Log.debug("Ejecutando en una ventana de: " .. WindowWidth .. " x " .. WindowHeight .. " px")
            love.window.setMode(
                WindowWidth,
                WindowHeight,
                {
                    vsync = true,
                    resizable = true,
                    centered = true
                }
            )
        end
    end

    updateCanvasScaleVariables(WindowWidth, WindowHeight)

    math.randomseed(os.time()) -- NOTE: Quizá redundante, parece que Love ya inicializa la semilla random automáticamente

    -- set window title
    love.window.setTitle("Fair Catch")
    changeScreen(require("screens/menu"))
    Log.info("Juego cargado")
end

function love.update(dt)
    screen.update(dt)
end

function love.draw()
    love.graphics.push()
    love.graphics.setCanvas(mainCanvas)
    love.graphics.translate(CanvasShiftX, CanvasShiftY)
    love.graphics.scale(CanvasScaleFactor, CanvasScaleFactor)
        screen.draw()
    love.graphics.setCanvas() -- volvemos a dibujar en la ventana principal
    love.graphics.pop()
end

function love.resize(w, h)
    updateCanvasScaleVariables(w, h)
end

function love.keypressed(key, scancode, isrepeat)
    if key == "q" then
        Log.info("Finalizado")
        love.event.quit()
    elseif key == "f" then
        if love.window.getFullscreen() then
            love.window.setFullscreen(false)
        else
            love.window.setFullscreen(true)
        end
    else
        screen.keypressed(key, scancode, isrepeat)
    end
end

function love.keyreleased(key, scancode, isrepeat)
    screen.keyreleased(key, scancode, isrepeat)
end

-- TODO: Renombar con la U mayúscula o hacer local
function updateCanvasScaleVariables(windowWidth, windowHeight)
    -- calcula el valor de las variables: scaleFactor, desplazamientoX, desplazamientoY (utilizadas para escalar y desplazar el viewport del juego dentro de la ventana principal)
    Log.debug("Recalculando variables escalado para resolución " .. windowWidth .. " x " .. windowHeight)

    local canvasScaleFactorWidth = windowWidth / WORLD_WIDTH
    local canvasScaleFactorHeight = windowHeight / WORLD_HEIGHT
    if canvasScaleFactorWidth < canvasScaleFactorHeight then
        CanvasScaleFactor = canvasScaleFactorWidth
    else
        CanvasScaleFactor = canvasScaleFactorHeight
    end

    CanvasShiftX = (windowWidth - CanvasScaleFactor * WORLD_WIDTH) / 2
    CanvasShiftY = (windowHeight - CanvasScaleFactor * WORLD_HEIGHT) / 2
end
