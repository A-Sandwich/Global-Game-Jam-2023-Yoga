YogaStudio = {}
class("YogaStudio").extends(NobleScene)

YogaStudio.baseColor = Graphics.kColorWhite

local background
local logo
local menu
local sequence

local difficultyValues = {"Rare", "Medium", "Well Done"}

function YogaStudio:init()
	YogaStudio.super.init(self)

	background = Graphics.image.new("assets/images/background1")
	logo = Graphics.image.new("libraries/noble/assets/images/NobleRobotLogo")

	menu = Noble.Menu.new(false, Noble.Text.ALIGN_LEFT, false, Graphics.kColorWhite, 4,6,0, Noble.Text.FONT_SMALL)

	menu:addItem(
		"Difficulty",
		function()
			local oldValue = Noble.Settings.get("Difficulty")
			local newValue = math.ringInt(table.indexOfElement(difficultyValues, oldValue)+1, 1, 3)
			Noble.Settings.set("Difficulty", difficultyValues[newValue])
			menu:setItemDisplayName("Difficulty", "Difficulty: " .. difficultyValues[newValue])
		end,
		nil,
		"Difficulty: " .. Noble.Settings.get("Difficulty")
	)

	local crankTick = 0

	YogaStudio.inputHandler = {
		upButtonDown = function()
			menu:selectPrevious()
		end,
		downButtonDown = function()
			menu:selectNext()
		end,
		cranked = function(change, acceleratedChange)
			crankTick = crankTick + change
			if (crankTick > 30) then
				crankTick = 0
				menu:selectNext()
			elseif (crankTick < -30) then
				crankTick = 0
				menu:selectPrevious()
			end
		end,
		AButtonDown = function()
			menu:click()
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

	menu:activate()
	Noble.Input.setCrankIndicatorStatus(true)

end

function YogaStudio:drawBackground()
	YogaStudio.super.drawBackground(self)

	background:draw(0, 0)
end

function YogaStudio:update()
	YogaStudio.super.update(self)

	Graphics.setColor(Graphics.kColorBlack)
	Graphics.setDitherPattern(0.2, Graphics.image.kDitherTypeScreen)
	Graphics.fillRoundRect(15, (sequence:get()*0.75)+3, 185, 145, 15)
	menu:draw(30, sequence:get()-15 or 100-15)

	Graphics.setColor(Graphics.kColorWhite)
	Graphics.fillRoundRect(260, -20, 130, 65, 15)
	logo:setInverted(true)
	logo:draw(275, 8)

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