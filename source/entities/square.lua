class('Square').extends(playdate.graphics.sprite)


function Square:init(image)
    Square.super.init(self) -- this is critical
    self.image = image 
    self:setCenter(0.0, 0.0)
    self:setImage(self.image)
    self:moveTo(100, 100)
    self:add()
end