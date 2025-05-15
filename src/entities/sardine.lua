newSardine = function(x, y, stage_index)
    local stage_index = stage_index or 1
    local sardine = {}
    sardine.x = x
    sardine.y = y
    sardine.stage_index = stage_index
    sardine.stages = {
        [1] = {
            frame_swimming_1 = {
                image = love.graphics.newImage("assets/images/sardine1.png"),
                shift_x = -272,
                shift_y = -164,
                hitbox = {
                    x = 3,
                    y = 2,
                    width = 10,
                    height = 5
                }
            }
        }
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
                --self.x = self.x - 10 * dt
            end,
            draw = function(self)
                love.graphics.draw(
                    self.stages[self.stage_index].frame_swimming_1.image,
                    self.x + self.stages[self.stage_index].frame_swimming_1.shift_x,
                    self.y + self.stages[self.stage_index].frame_swimming_1.shift_y)
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
