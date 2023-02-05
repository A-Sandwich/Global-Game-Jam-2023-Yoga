class('Sparkle').extends(AnimatedSprite)

function onFinishCallback(self)
    self.onAnimFinish(self.key)
end

function Sparkle:init(onAnimFinish, key)
    self.imgTable = playdate.graphics.imagetable.new("assets/images/sparkle-table-7-7")
    JointSelector.super.init(self, self.imgTable) -- this is critical
    self:addState('idle', 1, 4, { tickStep = 6, loop = false, onLoopFinishedEvent = onFinishCallback })
    self:playAnimation()
    self.onAnimFinish = onAnimFinish
    self.key = key
end
