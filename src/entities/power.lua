newPower = function()
    local o = {
        x = 2,
        y = 2
    }

    o.draw = function(self)
        self._state.draw(self)
    end
    o.update = function(self, dt)
        self._state.update(self, dt)
    end

    o.states = {
        hidden = {
            load = function(self)
            end,
            update = function(self, dt)
            end,
            draw = function(self)
            end
        },
        charging = {
            load = function(self)
                self.current_power = 0
                self.time_in_current_state = 0
            end,
            update = function(self, dt)
                self.time_in_current_state = self.time_in_current_state + dt
                self.current_power = math.fmod(self.time_in_current_state, 1)
                Log.debug(self.current_power)
            end,
            draw = function(self)
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle("fill", self.x, self.y, 8, 30)
                love.graphics.setColor(1, 0, 0)
                love.graphics.rectangle("fill", self.x, self.y + 30, 8, -30 * self.current_power)
            end
        },
        thrown = {
            load = function(self)
                self.time_in_current_state = 0
                Log.debug("Thrown with power = " .. self.current_power)
            end,
            update = function(self, dt)
                self.time_in_current_state = self.time_in_current_state + dt
                if self.time_in_current_state > 1 then
                    self:setState(self.states.hidden)
                end
            end,
            draw = function(self)
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle("fill", self.x, self.y, 8, 30)
                love.graphics.setColor(1, 0, 0)
                love.graphics.rectangle("fill", self.x, self.y + 30, 8, -30 * self.current_power)
            end
        }
    }

    o.setState = function(self, state)
        self._state = state
        self._state.load(self)
    end

    o:setState(o.states.hidden)

    return o
end

return newPower
