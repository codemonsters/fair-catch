-- devuelve true si la entidad a colisiona con la entidad b
function Collide(a, b)
    return not (a.x + a.h.x > b.x + b.h.x + b.h.w
        or a.y + a.h.y > b.y + b.h.y + b.h.h
        or a.x + a.h.x + a.h.w < b.x + b.h.x
        or a.y + a.h.y + a.h.h < b.y + b.h.y)
end
