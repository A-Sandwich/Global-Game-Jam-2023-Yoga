Joint = {
    x = 0,
    y = 0,
    rot = 0,
    rad = 1,
    parent = nil,
    attachAngle = 0
}

class("Joint").extends(playdate.graphics.sprite)

function Joint:init(x, y, rot, rad, parent, attachAngle, sprite)
    Joint.super.init(self)
    self.rot = rot
    self.rad = rad
    self.x = x
    self.y = y
    self.parent = parent
    self.attachAngle = attachAngle
    self.sprite = sprite
end

function Joint:updateLocation()
    local x, y = self:getPos()

    if self.sprite ~= nil then
        self.sprite:moveTo(x, y)
    end
end

function Joint:getPos()
    if self.parent == nil then
        return self.x, self.y
    end

    local pX, pY = self.parent:getPos()
    local pRot = self.parent.rot
    local pRad = self.parent.rad
    local rotOffset = pRot + self.attachAngle

    local rads = degToRad(rotOffset)

    local rotX = pRad * math.cos(rads)
    local rotY = pRad * math.sin(rads)

    return rotX + pX, rotY + pY
end

function degToRad(d)
    return d * (math.pi / 180)
end
