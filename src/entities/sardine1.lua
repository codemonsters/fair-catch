local CREATURE_ZONE = 1

newSardine1 = function(x, y, playing_screen)
    local newEntity = {}
    newEntity.x = x
    newEntity.y = y
    newEntity.playing_screen = playing_screen

    newEntity.draw = function(self)
        self._state.draw(self)
    end
    newEntity.update = function(self, dt)
        self._state.update(self, dt)
    end

    newEntity.states = {
        swimming = {
            frames = {
                {
                    image = love.graphics.newImage("assets/images/sardine1_swimming_01.png"),
                }
            },
            hitbox = {
                x = 3,
                y = 2,
                width = 10,
                height = 5
            },
            load = function(self)
                self.x_velocity = 10 -- pixels per second
                self.moving_right = true
                self.time_alive = 0
            end,
            update = function(self, dt)
                self.time_alive = self.time_alive + dt
                local current_zone = self.playing_screen.zones[CREATURE_ZONE]
                -- si la sardina está fuera de su zona del mar, acercarla hacia ella
                if self.y < current_zone.y then
                    self.y = self.y + 20 * dt
                elseif self.y > current_zone.y + current_zone.height then
                    self.y = self.y - 20 * dt
                end

                -- movimiento sinusoidal
                local last_x = self.x
                self.x = self.x + self.x_velocity * dt
                if self.x > last_x then
                    -- se está moviendo hacia la derecha
                    self.moving_right = true
                else
                    -- se está moviendo hacia la izquierda
                    self.moving_right = false
                end

                -- cambio de dirección
                if (not self.moving_right and self.x < current_zone.x + self._state.hitbox.x + self._state.hitbox.width) or (self.moving_right and self.x > current_zone.x + current_zone.width - (self._state.hitbox.x + self._state.hitbox.width)) then
                    self.x_velocity = -self.x_velocity
                end
            end,
            draw = function(self)
                local sx
                if self.moving_right then
                    sx = 1
                else
                    sx = -1
                end
                love.graphics.draw(self._state.frames[1].image, self.x, self.y + 20 * math.sin(self.time_alive), 0, sx, 1)
            end
        }
    }
    newEntity.setState = function(self, state)
        self._state = state
        self._state.load(self)
    end
    newEntity:setState(newEntity.states.swimming)

    return newEntity
end

return newSardine1
