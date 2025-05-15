newSardine = function(x, y, stage_index)
    local stage_index = stage_index or 1
    local sardine = {}
    sardine.x = x
    sardine.y = y
    sardine.stage_index = stage_index

    sardine.draw = function(self)
        self._state.draw(self)
    end
    sardine.update = function(self, dt)
        self._state.update(self, dt)
    end

    sardine.states = {
        swimming = {
            -- stages es una colección de frames y cada frame define información sobre su imagen y su hitbox
            stages = {
                [1] = {
                    {
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
            },
            load = function(self)

            end,
            update = function(self, dt)
                --self.x = self.x + 10 * dt
            end,
            draw = function(self)
                print(self.states[self._state])
                love.graphics.draw(
                    self.states[self._state].stages[self.states[self._state].stage_index][1].image,
                    self.x + self.states[self._state].stages[self._state.stage_index][1].shift_x,
                    self.y + self._state.stages[self._state.stage_index][1].shift_y)
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
