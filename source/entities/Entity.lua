Entity = {
    x = 0,
    y = 0,
    rot = 0,
    rad = 1,
    parent = nil,
    attachAngle = 0
}

class("Entity").extends()

function Entity:init(x, y, rot, rad, parent, attachAngle)
    self.rot = rot
    self.rad = rad
    self.x = x
    self.y = y
    self.parent = parent
    self.attachAngle = attachAngle
end

function Entity:getPos()
    if self.parent == nil then
        return self.x, self.y
    end

    local pX, pY = self.parent:getPos()
    local pRot = self.parent.rot
    local pRad = self.parent.rad
    local rotOffset = pRot + self.attachAngle

    local rads = degToRad(rotOffset)

    print(rads)

    local rotX = pRad * math.cos(rads)
    local rotY = pRad * math.sin(rads)

    return rotX + pX, rotY + pY
end

function degToRad(d)
    return d * (math.pi / 180)
end
