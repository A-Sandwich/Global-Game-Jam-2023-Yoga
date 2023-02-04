TitleScreen = {}
class("TitleScreen").extends(NobleScene)

TitleScreen.baseColor = Graphics.kColorWhite

local background
local torso
local sequence

function TitleScreen:init()
	TitleScreen.super.init(self)

	background = Graphics.image.new("assets/images/background1")

	local crankTick = 0

	TitleScreen.inputHandler = {
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

function TitleScreen:enter()
	TitleScreen.super.enter(self)

	sequence = Sequence.new():from(0):to(100, 1.5, Ease.outBounce)
	sequence:start();
end

function TitleScreen:start()
	TitleScreen.super.start(self)
	Noble.Input.setCrankIndicatorStatus(true)

end

function TitleScreen:drawBackground()
	TitleScreen.super.drawBackground(self)

	background:draw(0, 0)
end

function TitleScreen:update()
	TitleScreen.super.update(self)	
	playdate.graphics.drawText("Yoga?", 100, 100, 200, 100)
end

function TitleScreen:exit()
	TitleScreen.super.exit(self)

	Noble.Input.setCrankIndicatorStatus(false)
	sequence = Sequence.new():from(100):to(240, 0.25, Ease.inSine)
	sequence:start();
end

function TitleScreen:finish()
	TitleScreen.super.finish(self)
end