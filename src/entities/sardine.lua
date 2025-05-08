newSardine = function(x, y, size)
    size = size or 1
    local sardine = {}
    sardine.x = x
    sardine.y = y
    sardine.size = size
    sardine.image_shift_x = -272
    sardine.image_shift_y = -164
    sardine.images = {
        sardine_swimming_1 = love.graphics.newImage("assets/images/sardine1.png")
    }
    sardine.draw = function(self)
        self._state.draw(self)
    end
    sardine.update = function(self, dt)
        self._state.update(self, dt)
    end

    sardine.states = {
        swimming = {
            load = function(self)
            end,
            update = function(self, dt)
                self.x = self.x - 10 * dt
            end,
            draw = function(self)
                love.graphics.draw(self.images.sardine_swimming_1, self.x + self.image_shift_x, self.y + self.image_shift_y)
            end
        }
    }
    sardine.setState = function(self, state)
        self._state = state
        self._state.load(self)
    end
    sardine:setState(sardine.states.swimming)

    return sardine
end

return newSardine
