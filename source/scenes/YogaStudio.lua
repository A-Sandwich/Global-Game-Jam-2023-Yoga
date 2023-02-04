YogaStudio = {}
class("YogaStudio").extends(NobleScene)

YogaStudio.baseColor = Graphics.kColorWhite

local background
local torso
local sequence

function YogaStudio:init()
	YogaStudio.super.init(self)

	background = Graphics.image.new("assets/images/background1")
	torso = Square()

	local crankTick = 0

	YogaStudio.inputHandler = {
		upButtonDown = function()
			torso:moveTo(torso.x, torso.y - 5)
		end,
		downButtonDown = function()
			torso:moveTo(torso.x, torso.y + 5)
		end,
		leftButtonDown = function()
			torso:moveTo(torso.x - 5, torso.y)
		end,
		rightButtonDown = function()
			torso:moveTo(torso.x + 5, torso.y)
		end,
		cranked = function(change, acceleratedChange)
			crankTick = crankTick + change
			
            torso:setRotation(crankTick)
		end,
		AButtonDown = function()
			
		end
	}

end

function YogaStudio:enter()
	YogaStudio.super.enter(self)

	sequence = Sequence.new():from(0):to(100, 1.5, Ease.outBounce)
	sequence:start();
end

function YogaStudio:start()
	YogaStudio.super.start(self)
	Noble.Input.setCrankIndicatorStatus(true)

end

function YogaStudio:drawBackground()
	YogaStudio.super.drawBackground(self)

	background:draw(0, 0)
end

function YogaStudio:update()
	YogaStudio.super.update(self)	
end

function YogaStudio:exit()
	YogaStudio.super.exit(self)

	Noble.Input.setCrankIndicatorStatus(false)
	sequence = Sequence.new():from(100):to(240, 0.25, Ease.inSine)
	sequence:start();
end

function YogaStudio:finish()
	YogaStudio.super.finish(self)
end