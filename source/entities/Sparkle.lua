class('Sparkle').extends(AnimatedSprite)

function onFinishCallback(self)
    self.onAnimFinish(self.key)
end

function Sparkle:init(onAnimFinish, key)
    self.imgTable = playdate.graphics.imagetable.new("assets/images/sparkle-table-7-7")
    Sparkle.super.init(self, self.imgTable) -- this is critical
    self:addState('idle', 1, 5, { tickStep = 6, loop = false, onLoopFinishedEvent = onFinishCallback, xScale = 2, yScale = 2 })
    self:playAnimation()
    self.onAnimFinish = onAnimFinish
    self.key = key
end
