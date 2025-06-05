local CREATURE_ZONE = 1

newSardine1 = function(x, y, zone_number, playing_screen)
    local newEntity = {}
    newEntity.x = x
    newEntity.y = y
    newEntity.zone_number = zone_number
    newEntity.playing_screen = playing_screen

    newEntity.draw = function(self)
        self._state.draw(self)
    end

    newEntity.draw_hitbox = function(self)
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("line", self.x + self._state.hitbox.x, self.y + self._state.hitbox.y, self._state.hitbox.width, self._state.hitbox.height)
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
            -- TODO: Arreglar hitbox
            hitbox = {
                x = 0,
                y = 2,
                width = 10,
                height = 5
            },
            load = function(self)
                self.x_velocity = 25 -- pixels per second
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

                -- TODO: Arreglar movimiento sinusoidal (hacer una prueba con el pez a media altura y con el factor que multipla el seno maximizado, es decir altura de la zona menos altura del pez y todo eso dividido entre dos)
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
                if (not self.moving_right and self.x + self._state.hitbox.x < current_zone.x ) or (self.moving_right and self.x > current_zone.x + current_zone.width - (self._state.hitbox.x + self._state.hitbox.width)) then
                    self.x_velocity = -self.x_velocity
                end
            end,
            draw = function(self)
                local scale_x
                if self.moving_right then
                    scale_x = 1
                else
                    scale_x = -1
                end
                love.graphics.draw(self._state.frames[1].image, self.x, self.y, 0, scale_x, 1, self._state.frames[1].image:getWidth() / 2)
            end
        }
    }

    newEntity.setState = function(self, state)
        self._state = state
        self._state.load(self)
    end
    newEntity:setState(newEntity.states.swimming)
    newEntity.zone_highest = newEntity.playing_screen.zones[newEntity.zone_number].y
    newEntity.zone_lowest = newEntity.playing_screen.zones[newEntity.zone_number].y + newEntity.playing_screen.zones[newEntity.zone_number].height

    return newEntity
end

return newSardine1
