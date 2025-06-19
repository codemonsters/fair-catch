MAX_GAME_TIME = 10   -- tiempo que durará la partida en segundos

newSun = function()
    local o = {
        x = 0,
        y = 54,
        image = love.graphics.newImage("assets/images/sun.png"),
        time_alive = 0
    }

    o.draw = function(self)
        --self._state.draw(self)
        love.graphics.draw(self.image, self.x, self.y)
    end
    o.update = function(self, dt)
        --self._state.update(self, dt)
        self.time_alive = self.time_alive + dt
        self.x = self.x + dt * (WORLD_WIDTH - self.image:getWidth()) / MAX_GAME_TIME
        self.y = self.starting_y - 54 * math.sin(((self.x - self.starting_x) / (WORLD_WIDTH - self.image:getWidth() - self.starting_x)) / (math.pi / 2))
        Log.debug(self.time_alive)
    end

    o.states = {
        sunrise = {
            load = function(self)
                --self:setState(self.states.moving)
            end,
            update = function(self, dt)
            end,
            draw = function(self)
            end
        },
        noon = {
            load = function(self)
                self.time_in_current_state = 0
            end,
            update = function(self, dt)
            end,
            draw = function(self)
            end
        },
        sunset = {
            load = function(self)
                self.time_in_current_state = 0
            end,
            update = function(self, dt)
            end,
            draw = function(self)
            end
        },
        night = {
            load = function(self)
                self.time_in_current_state = 0
                -- Log.debug("Thrown with power = " .. self.current_power)
            end,
            update = function(self, dt)
            end,
            draw = function(self)
            end
        }

    }

    o.setState = function(self, state)
        self._state = state
        self._state.load(self)
    end

    o:setState(o.states.sunrise)
    o.starting_x = o.x
    o.starting_y = o.y
    return o
end

return newSun
