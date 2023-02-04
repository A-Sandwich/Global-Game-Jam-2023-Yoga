class('Square').extends(playdate.graphics.sprite)


function Square:init()
    Square.super.init(self) -- this is critical
    self.image = Graphics.image.new("assets/images/patterns/longcheckerhor"):scaledImage(8)
    
    self:setImage(self.image)
    self:moveTo(100, 100)
    self:add()
end