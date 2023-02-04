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

local headJoint
local uBodyJoint
local lBodyJoint
local luArmJoint
local llArmJoint
local ruArmJoint
local rlArmJoint
local luLegJoint
local llLegJoint
local ruLegJoint
local rlLegJoint

local joints = {}
local currentJointIndex

local head
local uBody
local lBody
local luArm
local llArm
local ruArm
local rlArm
local luLeg
local llLeg
local ruLeg
local rlLeg

local gfx = playdate.graphics

-- This runs when your scene's object is created, which is the first thing that happens when transitining away from another scene.
function CodyTest:init()
    CodyTest.super.init(self)

    local bodySprite = gfx.sprite.new(Graphics.image.new("assets/images/upperbody"))
    bodySprite:setCenter(0.5, 0.5)
    bodySprite:add()

    local lBodySprite = gfx.sprite.new(Graphics.image.new("assets/images/lowerbody"))
    lBodySprite:setCenter(0.5, 0.5)
    lBodySprite:add()

    local headSprite = gfx.sprite.new(Graphics.image.new("assets/images/head"))
    headSprite:setCenter(0.5, 1)
    headSprite:add()

    local lUArmSprite = gfx.sprite.new(Graphics.image.new("assets/images/leftupperarm"))
    lUArmSprite:setCenter(0.5, 0)
    lUArmSprite:add()

    local lLArmSprite = gfx.sprite.new(Graphics.image.new("assets/images/leftlowerarm"))
    lLArmSprite:setCenter(0.5, 0)
    lLArmSprite:add()

    local rUArmSprite = gfx.sprite.new(Graphics.image.new("assets/images/rightupperarm"))
    rUArmSprite:setCenter(0.5, 0)
    rUArmSprite:add()

    local rLArmSprite = gfx.sprite.new(Graphics.image.new("assets/images/rightlowerarm"))
    rLArmSprite:setCenter(0.5, 0)
    rLArmSprite:add()

    local lULegSprite = gfx.sprite.new(Graphics.image.new("assets/images/leftupperleg"))
    lULegSprite:setCenter(0.5, 0)
    lULegSprite:add()

    local lLLegSprite = gfx.sprite.new(Graphics.image.new("assets/images/leftlowerleg"))
    lLLegSprite:setCenter(0.5, 0)
    lLLegSprite:add()

    local rULegSprite = gfx.sprite.new(Graphics.image.new("assets/images/rightupperleg"))
    rULegSprite:setCenter(0.5, 0)
    rULegSprite:add()

    local rLLegSprite = gfx.sprite.new(Graphics.image.new("assets/images/rightlowerleg"))
    rLLegSprite:setCenter(0.5, 0)
    rLLegSprite:add()

    uBodyJoint = Joint(200, 100, 0, 32, nil, 0, bodySprite)
    lBodyJoint = Joint(0, 0, 0, 24, uBodyJoint, 90, lBodySprite)
    headJoint = Joint(0, 0, 0, 16, uBodyJoint, 270, headSprite)
    luArmJoint = Joint(0, 0, 0, 48, uBodyJoint, 225, lUArmSprite)
    llArmJoint = Joint(0, 0, 0, 48, luArmJoint, 90, lLArmSprite)
    ruArmJoint = Joint(0, 0, 0, 48, uBodyJoint, 315, rUArmSprite)
    rlArmJoint = Joint(0, 0, 0, 48, ruArmJoint, 90, rLArmSprite)
    luLegJoint = Joint(0, 0, 0, 48, lBodyJoint, 45, lULegSprite)
    llLegJoint = Joint(0, 0, 0, 24, luLegJoint, 90, lLLegSprite)
    ruLegJoint = Joint(0, 0, 0, 48, lBodyJoint, 135, rULegSprite)
    rlLegJoint = Joint(0, 0, 0, 24, ruLegJoint, 90, rLLegSprite)

    joints[1] = uBodyJoint
    joints[2] = headJoint
    joints[3] = lBodyJoint
    joints[4] = luArmJoint
    joints[5] = llArmJoint
    joints[6] = ruArmJoint
    joints[7] = rlArmJoint
    joints[8] = luLegJoint
    joints[9] = llLegJoint
    joints[10] = ruLegJoint
    joints[11] = rlLegJoint

    currentJointIndex = 1

    headJoint:updateLocation()
    uBodyJoint:updateLocation()
    lBodyJoint:updateLocation()
    luArmJoint:updateLocation()
    llArmJoint:updateLocation()
    ruArmJoint:updateLocation()
    rlArmJoint:updateLocation()
    luLegJoint:updateLocation()
    llLegJoint:updateLocation()
    ruLegJoint:updateLocation()
    rlLegJoint:updateLocation()
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
        local currentJoint = joints[currentJointIndex]
        currentJoint.rot = currentJoint.rot + change
        currentJoint.sprite:setRotation(currentJoint.rot)

        headJoint:updateLocation()
        uBodyJoint:updateLocation()
        lBodyJoint:updateLocation()
        luArmJoint:updateLocation()
        llArmJoint:updateLocation()
        ruArmJoint:updateLocation()
        rlArmJoint:updateLocation()
        luLegJoint:updateLocation()
        llLegJoint:updateLocation()
        ruLegJoint:updateLocation()
        rlLegJoint:updateLocation()

    end,
    crankDocked = function() -- Runs once when when crank is docked.
        -- Your code here
    end,
    crankUndocked = function() -- Runs once when when crank is undocked.
        -- Your code here
    end
}
