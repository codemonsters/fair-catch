newFisher = function()
    local fisher = {}

    fisher.draw = function(self)
        self._state.draw(self)
    end
    fisher.update = function(self, dt)
        self._state.update(self, dt)
    end

    fisher.states = {
        resting = {
            frames = {
                {
                    image = love.graphics.newImage("assets/images/temporalFisher.png"),
                }
            },

            load = function(self)
            end,
            update = function(self, dt)
            end,
            draw = function(self)
                love.graphics.draw(self._state.frames[1].image, 0, 0)
            end
        }
    }
    newFisher.setState = function(self, state)
        self._state = state
        self._state.load(self)
    end
    newFisher:setState(newFisher.states.resting)

    return fisher
end

return newFisher
