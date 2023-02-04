--
-- CodyTest.lua
--
-- Use this as a starting point for your game's scenes. Copy this file to your root "scenes" directory,
-- rename it as you like, and then replace all instances of "CodyTest" with your scene's name.
--

CodyTest = {}
class("CodyTest").extends(NobleScene)

-- It is recommended that you declare, but don't yet define, your scene-specific varibles and methods here. Use "local" where possible.
--
-- local variable1 = nil
-- CodyTest.variable2 = nil
-- ...
--

CodyTest.backgroundColor = Graphics.kColorWhite -- This is the background color of this scene.

local body
local head
local head2
local torso
local realHead
local realHead2

-- This runs when your scene's object is created, which is the first thing that happens when transitining away from another scene.
function CodyTest:init()
    CodyTest.super.init(self)

    body = Entity(220, 100, 0, 32)
    head = Entity(0, 0, 0, 16, body, 270)
    head2 = Entity(0, 0, 0, 16, head, 270)

    local headImage = Graphics.image.new("assets/images/head")
    local bodyImage = Graphics.image.new("assets/images/upperbody")
    torso = Square(bodyImage)
    torso:setRotation(body.rot)
    torso:setCenter(0.5, 0.5)
    realHead = Square(headImage)
    realHead:setRotation(head.rot)

    realHead:setCenter(0.5, 1)

    realHead2 = Square(headImage)
    realHead2:setRotation(head2.rot)

    realHead2:setCenter(0.5, 1)

    torso:moveTo(body.x, body.y)

    local hX, hY = head:getPos()
    realHead:moveTo(hX, hY)
    local hX2, hY2 = head2:getPos()
    realHead2:moveTo(hX2, hY2)
end

-- When transitioning from another scene, this runs as soon as this scene needs to be visible (this moment depends on which transition type is used).
function CodyTest:enter()
    CodyTest.super.enter(self)
    -- Your code here
end

-- This runs once a transition from another scene is complete.
function CodyTest:start()
    CodyTest.super.start(self)
    -- Your code here
end

-- This runs once per frame.
function CodyTest:update()
    CodyTest.super.update(self)
    -- Your code here
end

-- This runs once per frame, and is meant for drawing code.
function CodyTest:drawBackground()
    CodyTest.super.drawBackground(self)
    -- Your code here
end

-- This runs as as soon as a transition to another scene begins.
function CodyTest:exit()
    CodyTest.super.exit(self)
    -- Your code here
end

-- This runs once a transition to another scene completes.
function CodyTest:finish()
    CodyTest.super.finish(self)
    -- Your code here
end

function CodyTest:pause()
    CodyTest.super.pause(self)
    -- Your code here
end

function CodyTest:resume()
    CodyTest.super.resume(self)
    -- Your code here
end

-- You can define this here, or within your scene's init() function.
CodyTest.inputHandler = {

    -- A button
    --
    AButtonDown = function() -- Runs once when button is pressed.
        -- Your code here
    end,
    AButtonHold = function() -- Runs every frame while the player is holding button down.
        -- Your code here
    end,
    AButtonHeld = function() -- Runs after button is held for 1 second.
        -- Your code here
    end,
    AButtonUp = function() -- Runs once when button is released.
        -- Your code here
    end,

    -- B button
    --
    BButtonDown = function()
        -- Your code here
    end,
    BButtonHeld = function()
        -- Your code here
    end,
    BButtonHold = function()
        -- Your code here
    end,
    BButtonUp = function()
        -- Your code here
    end,

    -- D-pad left
    --
    leftButtonDown = function()
        -- Your code here
    end,
    leftButtonHold = function()
        -- Your code here
    end,
    leftButtonUp = function()
        -- Your code here
    end,

    -- D-pad right
    --
    rightButtonDown = function()
        -- Your code here
    end,
    rightButtonHold = function()
        -- Your code here
    end,
    rightButtonUp = function()
        -- Your code here
    end,

    -- D-pad up
    --
    upButtonDown = function()
        -- Your code here
    end,
    upButtonHold = function()
        -- Your code here
    end,
    upButtonUp = function()
        -- Your code here
    end,

    -- D-pad down
    --
    downButtonDown = function()
        -- Your code here
    end,
    downButtonHold = function()
        -- Your code here
    end,
    downButtonUp = function()
        -- Your code here
    end,

    -- Crank
    --
    cranked = function(change, acceleratedChange) -- Runs when the crank is rotated. See Playdate SDK documentation for details.
        body.rot = body.rot + change

        torso:moveTo(body.x, body.y)
        torso:setRotation(body.rot)

        head.rot = head.rot - change
        local hX, hY = head:getPos()
        realHead:moveTo(hX, hY)

        local hX2, hY2 = head2:getPos()
        realHead2:moveTo(hX2, hY2)


    end,
    crankDocked = function() -- Runs once when when crank is docked.
        -- Your code here
    end,
    crankUndocked = function() -- Runs once when when crank is undocked.
        -- Your code here
    end
}
