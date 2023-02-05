class('Sparkle').extends(AnimatedSprite)

function onFinishCallback(self)
    self.onAnimFinish(self)
end

function Sparkle:init(onAnimFinish)
    self.imgTable = playdate.graphics.imagetable.new("assets/images/sparkle-table-7-7")
    JointSelector.super.init(self, self.imgTable) -- this is critical
    self:addState('idle', 1, 4, { tickStep = 6, onLoopFinishedEvent = self:destory() })
    self:playAnimation()
    self.onAnimFinish = onAnimFinish
end
