class('Sparkle').extends(AnimatedSprite)

function Sparkle:init()
    self.imgTable = playdate.graphics.imagetable.new("assets/images/sparkle-table-7-7")
    JointSelector.super.init(self, self.imgTable) -- this is critical
    self:addState('idle',1,4,{ tickStep = 6 })
    self:playAnimation()
end