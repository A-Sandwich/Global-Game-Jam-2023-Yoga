TitleScreen = {}
class("TitleScreen").extends(NobleScene)

TitleScreen.baseColor = Graphics.kColorWhite

local background
local sequence

function TitleScreen:init()
	TitleScreen.super.init(self)

	background = Graphics.image.new("assets/images/backgrounds/Menu")

	local crankTick = 0

	TitleScreen.inputHandler = {
		AButtonDown = function()
			Noble.transition(CodyTest)
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
end

function TitleScreen:drawBackground()
	TitleScreen.super.drawBackground(self)

	background:draw(0, 0)

	playdate.graphics.drawText("Credits", 150, 100)
	playdate.graphics.drawText("A Sandwich", 175, 125)
	playdate.graphics.drawText("Cxsquared", 300, 125)
	playdate.graphics.drawText("Kevin Sanchez", 175, 150)
	playdate.graphics.drawText("ToastyFish", 300, 150)

	playdate.graphics.drawText("Press A to Begin Session", 150, 200)
end

function TitleScreen:update()
	TitleScreen.super.update(self)	
end

function TitleScreen:exit()
	TitleScreen.super.exit(self)

	sequence = Sequence.new():from(100):to(240, 0.25, Ease.inSine)
	sequence:start();
end

function TitleScreen:finish()
	TitleScreen.super.finish(self)
end