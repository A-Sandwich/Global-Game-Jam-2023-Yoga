--
-- CodyTest.lua
--
-- Use this as a starting point for your game's scenes. Copy this file to your root "scenes" directory,
-- rename it as you like, and then replace all instances of "CodyTest" with your scene's name.
--

CodyTest = {}
class("CodyTest").extends(NobleScene)

-- It is recommended that you declare, but don't yet define, your scene-specific varibles and methods here. Use "local" where possible.

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
local jointSelector

local currentJoint

local background

local spinSinceLastCrack = 0
local lastCrunchPlayed = 1

-- This runs when your scene's object is created, which is the first thing that happens when transitining away from another scene.
function CodyTest:init()
    CodyTest.super.init(self)

    background = Graphics.image.new("assets/images/backgrounds/Studio")
end

function UpdateJointSelector(isUp, isDown, isLeft, isRight)
    currentJoint = jointSelector:getNextJoint(isUp, isDown, isLeft, isRight)
    jointSelector:moveTo(currentJoint:getPos())
end

function CodyTest.buildScoringPoints()
    -- head
    local headStartX, headStartY = headJoint:getPos()
    ScoringPoints.add(headStartX, headStartY - 30, ScoringPoints.bodyPartType.Head,
        { ScoringPoints.chakraTypes.ThirdEye, ScoringPoints.chakraTypes.Crown });

    --ScoringPoints.add(headStartX, headStartY + 80, ScoringPoints.bodyPartType.Head,
    --     { ScoringPoints.chakraTypes.Death });

    ScoringPoints.add(100, 75, ScoringPoints.bodyPartType.LeftLowerArm,
        { ScoringPoints.chakraTypes.Throat });

    ScoringPoints.add(300, 65, ScoringPoints.bodyPartType.RightLowerArm,
        { ScoringPoints.chakraTypes.Throat });

    ScoringPoints.add(130, 195, ScoringPoints.bodyPartType.LeftLowerLeg,
        { ScoringPoints.chakraTypes.Throat });

    ScoringPoints.add(270, 175, ScoringPoints.bodyPartType.RightLowerLeg,
        { ScoringPoints.chakraTypes.Throat });

end

-- When transitioning from another scene, this runs as soon as this scene needs to be visible (this moment depends on which transition type is used).
function CodyTest:enter()
    CodyTest.super.enter(self)
    -- Your code here

    local utorsoImage = Graphics.image.new("assets/images/UpperTorso")
    local ltorsoImage = Graphics.image.new("assets/images/LowerTorso")

    local bodySprite = Graphics.sprite.new(utorsoImage)
    bodySprite:setCenter(0.5, 0.5)
    bodySprite:add()

    local lBodySprite = Graphics.sprite.new(ltorsoImage)
    lBodySprite:setCenter(0.5, 0.25)
    lBodySprite:add()

    local headSprite = Graphics.sprite.new(Graphics.image.new("assets/images/head"))
    headSprite:setCenter(0.5, .75)
    headSprite:add()

    local partsImage = Graphics.image.new("assets/images/Parts")

    local lUArmSprite = Graphics.sprite.new(partsImage)
    lUArmSprite:setCenter(0.7, 0)
    lUArmSprite:add()

    local lLArmSprite = Graphics.sprite.new(partsImage)
    lLArmSprite:setCenter(0.5, 0)
    lLArmSprite:add()

    local rUArmSprite = Graphics.sprite.new(partsImage)
    rUArmSprite:setCenter(0.3, 0)
    rUArmSprite:add()

    local rLArmSprite = Graphics.sprite.new(partsImage)
    rLArmSprite:setCenter(0.5, 0)
    rLArmSprite:add()

    local lULegSprite = Graphics.sprite.new(partsImage)
    lULegSprite:setCenter(0.5, 0)
    lULegSprite:add()

    local lLLegSprite = Graphics.sprite.new(partsImage)
    lLLegSprite:setCenter(0.5, 0)
    lLLegSprite:add()

    local rULegSprite = Graphics.sprite.new(partsImage)
    rULegSprite:setCenter(0.5, 0)
    rULegSprite:add()

    local rLLegSprite = Graphics.sprite.new(partsImage)
    rLLegSprite:setCenter(0.5, 0)
    rLLegSprite:add()

    uBodyJoint = Joint(200, 100, 0, 32, nil, 0, bodySprite)
    lBodyJoint = Joint(0, 0, 0, 24, uBodyJoint, 90, lBodySprite)
    headJoint = Joint(0, 0, 0, 16, uBodyJoint, 270, headSprite)
    luArmJoint = Joint(0, 0, 0, 40, uBodyJoint, 225, lUArmSprite)
    llArmJoint = Joint(0, 0, 0, 40, luArmJoint, 90, lLArmSprite)
    ruArmJoint = Joint(0, 0, 0, 40, uBodyJoint, 315, rUArmSprite)
    rlArmJoint = Joint(0, 0, 0, 40, ruArmJoint, 90, rLArmSprite)
    luLegJoint = Joint(0, 0, 0, 40, lBodyJoint, 45, lULegSprite)
    llLegJoint = Joint(0, 0, 0, 40, luLegJoint, 90, lLLegSprite)
    ruLegJoint = Joint(0, 0, 0, 40, lBodyJoint, 135, rULegSprite)
    rlLegJoint = Joint(0, 0, 0, 40, ruLegJoint, 90, rLLegSprite)

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

    jointSelector = JointSelector(uBodyJoint, headJoint, lBodyJoint, luArmJoint, llArmJoint, ruArmJoint, rlArmJoint,
        luLegJoint, llLegJoint, ruLegJoint, rlLegJoint)
    currentJoint = jointSelector:getNextJoint(false, false, false, false)
    jointSelector:moveTo(currentJoint:getPos())
    jointSelector:add()
    CodyTest.buildScoringPoints()
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

    CodyTest.updateSparkle()
end

local sparkleDistance = 35
local sparkels = {}

function CodyTest.updateSparkle()
    -- head
    local hX, hY = headJoint:getPos()
    local headScore = ScoringPoints.getClosestPoint(hX, hY, ScoringPoints.bodyPartType.Head)

    if headScore.distanceFromBodyPart < sparkleDistance and sparkels["head"] ~= nil then
        local spark = Sparkel()
        spark:moveTo(hX, hY)
        sparkels["head"] = spark
    end

end

-- This runs once per frame, and is meant for drawing code.
function CodyTest:drawBackground()
    CodyTest.super.drawBackground(self)

    background:draw(0, 0)

    if Noble.showFPS then
        ScoringPoints.drawDebug()
    end
end

-- This runs as as soon as a transition to another scene begins.
function CodyTest:exit()
    CodyTest.super.exit(self)
    -- Your code here
    Noble.Input.setCrankIndicatorStatus(false)
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
        Noble.Input.setCrankIndicatorStatus(true)
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
        local hX, hY = headJoint:getPos()
        local headScore = ScoringPoints.getClosestPoint(hX, hY, ScoringPoints.bodyPartType.Head)
        printTable(headScore)

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
        UpdateJointSelector(false, false, true, false)
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
        UpdateJointSelector(false, false, false, true)
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
        UpdateJointSelector(true, false, false, false)
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
        UpdateJointSelector(false, true, false, false)
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

        manageCracks(change)
    end,
    crankDocked = function() -- Runs once when when crank is docked.
        -- Your code here
    end,
    crankUndocked = function() -- Runs once when when crank is undocked.
        -- Your code here
    end

}

function manageCracks(change)
    spinSinceLastCrack += change

    if(spinSinceLastCrack > 750) then
        spinSinceLastCrack = 0
        playdate.sound.sampleplayer.new("assets/sounds/bone_crunch_" .. lastCrunchPlayed):play()
        lastCrunchPlayed = lastCrunchPlayed + 1
        if(lastCrunchPlayed > 4) then
            lastCrunchPlayed = 1
        end
    end 
end