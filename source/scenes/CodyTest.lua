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
local Animator = playdate.graphics.animator
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
local confirm
local bounceInTime = 750

local currentJoint

local background
local handleInput = true

local lastCrunchPlayed = 1
local hasEnoughTimePassed = false

local rootChakra
local twoStar
local threeStar
local fourStar
local fiveStar
local rootChakraAnimation
local twoStarAnimation
local threeStarAnimation
local fourStarAnimation
local fiveStarAnimation
local easingFunc = playdate.easingFunctions.inQuad
-- This runs when your scene's object is created, which is the first thing that happens when transitining away from another scene.
function CodyTest:init()
    CodyTest.super.init(self)

    background = Graphics.image.new("assets/images/backgrounds/Studio")
    playdate.resetElapsedTime()

end

function UpdateJointSelector(isUp, isDown, isLeft, isRight)
    currentJoint = jointSelector:getNextJoint(isUp, isDown, isLeft, isRight)
    if currentJoint == confirm then
        jointSelector:moveTo(currentJoint.sprite.x, currentJoint.sprite.y - currentJoint.sprite.height)
    else
        jointSelector:moveTo(currentJoint:getPos())
    end
end

function endGame()
    playdate.sound.sampleplayer.new("assets/sounds/sparkle"):play()
    print("End game")
    handleInput = false
    showStats()
end

function CodyTest.buildScoringPoints()
    -- standard
    ScoringPoints.add(240, 60, ScoringPoints.bodyPartType.Head,
        { ScoringPoints.chakraTypes.ThirdEye, ScoringPoints.chakraTypes.Crown });

    ScoringPoints.add(230, 45, ScoringPoints.bodyPartType.LeftLowerArm,
        { ScoringPoints.chakraTypes.Throat });

    ScoringPoints.add(260, 125, ScoringPoints.bodyPartType.RightLowerArm,
        { ScoringPoints.chakraTypes.Throat });

    ScoringPoints.add(150, 195, ScoringPoints.bodyPartType.RightLowerLeg,
        { ScoringPoints.chakraTypes.Throat });

    ScoringPoints.add(220, 145, ScoringPoints.bodyPartType.LeftLowerLeg,
        { ScoringPoints.chakraTypes.Throat });

    -- devil
    ScoringPoints.add(200, 132, ScoringPoints.bodyPartType.Head,
        { ScoringPoints.chakraTypes.Death });

    ScoringPoints.add(253, 149, ScoringPoints.bodyPartType.LeftLowerArm,
        { ScoringPoints.chakraTypes.Death });

    ScoringPoints.add(153, 154, ScoringPoints.bodyPartType.RightLowerArm,
        { ScoringPoints.chakraTypes.Death });

    ScoringPoints.add(250, 29, ScoringPoints.bodyPartType.RightLowerLeg,
        { ScoringPoints.chakraTypes.Death });

    ScoringPoints.add(154, 22, ScoringPoints.bodyPartType.LeftLowerLeg,
        { ScoringPoints.chakraTypes.Death });

end

-- When transitioning from another scene, this runs as soon as this scene needs to be visible (this moment depends on which transition type is used).
function CodyTest:enter()
    CodyTest.super.enter(self)

    if Noble.showFPS == false then
        Noble.Input.setCrankIndicatorStatus(true)
    end

    local bodySprite = NobleSprite("assets/images/UpperTorso")
    bodySprite:setCenter(0.5, 0.5)
    bodySprite:add()

    local lBodySprite = NobleSprite("assets/images/LowerTorso")
    lBodySprite:setCenter(0.5, 0.25)
    lBodySprite:add()

    local headSprite = NobleSprite("assets/images/head")
    headSprite:setCenter(0.5, .75)
    headSprite:add()

    local confirmSprite = NobleSprite("assets/images/NonConfirmState")
    confirmSprite:setCenter(0.5, 1.4)
    confirmSprite:add()

    local lUArmSprite = NobleSprite("assets/images/Parts")
    lUArmSprite:setCenter(0.7, 0)
    lUArmSprite:add()

    local lLArmSprite = NobleSprite("assets/images/Parts")
    lLArmSprite:setCenter(0.5, 0)
    lLArmSprite:add()

    local rUArmSprite = NobleSprite("assets/images/Parts")
    rUArmSprite:setCenter(0.3, 0)
    rUArmSprite:add()

    local rLArmSprite = NobleSprite("assets/images/Parts")
    rLArmSprite:setCenter(0.5, 0)
    rLArmSprite:add()

    local lULegSprite = NobleSprite("assets/images/Parts")
    lULegSprite:setCenter(0.5, 0)
    lULegSprite:add()

    local lLLegSprite = NobleSprite("assets/images/Parts")
    lLLegSprite:setCenter(0.5, 0)
    lLLegSprite:add()

    local rULegSprite = NobleSprite("assets/images/Parts")
    rULegSprite:setCenter(0.5, 0)
    rULegSprite:add()

    local rLLegSprite = NobleSprite("assets/images/Parts")
    rLLegSprite:setCenter(0.5, 0)
    rLLegSprite:add()

    uBodyJoint = Joint(200, 100, 0, 32, nil, 0, bodySprite)
    lBodyJoint = Joint(0, 0, 0, 24, uBodyJoint, 90, lBodySprite)
    headJoint = Joint(0, 0, 0, 16, uBodyJoint, 270, headSprite)
    luArmJoint = Joint(0, 0, 260, 40, uBodyJoint, 225, lUArmSprite)
    llArmJoint = Joint(0, 0, 280, 40, luArmJoint, 90, lLArmSprite)
    ruArmJoint = Joint(0, 0, 270, 40, uBodyJoint, 315, rUArmSprite)
    rlArmJoint = Joint(0, 0, 270, 40, ruArmJoint, 90, rLArmSprite)
    luLegJoint = Joint(0, 0, 0, 40, lBodyJoint, 45, lULegSprite)
    llLegJoint = Joint(0, 0, 0, 40, luLegJoint, 90, lLLegSprite)
    ruLegJoint = Joint(0, 0, 270, 40, lBodyJoint, 135, rULegSprite)
    rlLegJoint = Joint(0, 0, 30, 40, ruLegJoint, 90, rLLegSprite)
    confirm = Joint(200, 50, 0, 16, nil, 0, confirmSprite)

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
    confirm:updateLocation()

    jointSelector = JointSelector(uBodyJoint, headJoint, lBodyJoint, luArmJoint, llArmJoint, ruArmJoint, rlArmJoint,
        luLegJoint, llLegJoint, ruLegJoint, rlLegJoint, confirm)
    currentJoint = jointSelector:getNextJoint(false, false, false, false)
    jointSelector:moveTo(currentJoint:getPos())
    jointSelector:add()
    CodyTest.buildScoringPoints()

    playdate.timer.performAfterDelay(5000, function()
        hasEnoughTimePassed = true
    end)
end

function showStats()
    rootChakra = AnimatedSprite(playdate.graphics.imagetable.new("assets/images/rootChakra-expand"))
    playdate.sound.sampleplayer.new("assets/sounds/end_01"):play()

    rootChakra:moveTo(56, 240)
    rootChakraAnimation = Animator.new(bounceInTime, 240, 225, easingFunc)
    rootChakra:addState('idle', 1, 14, { tickStep = 1, loop = false, onLoopFinishedEvent = show2Star })
    rootChakra:playAnimation()
end

function show2Star()
    twoStar = AnimatedSprite(playdate.graphics.imagetable.new("assets/images/2Star_SolarPlexus"))
    playdate.sound.sampleplayer.new("assets/sounds/end_02"):play()

    twoStarAnimation = Animator.new(bounceInTime, 240, 225, easingFunc)
    twoStar:moveTo(120, 225)
    twoStar:addState('idle', 1, 14, { tickStep = 1, loop = false, onLoopFinishedEvent = show3Star })
    twoStar:playAnimation()
end

function show3Star()
    threeStar = AnimatedSprite(playdate.graphics.imagetable.new("assets/images/3Star_Heart"))
    playdate.sound.sampleplayer.new("assets/sounds/end_03"):play()

    threeStar:moveTo(184, 225)
    threeStarAnimation = Animator.new(bounceInTime, 240, 225, easingFunc)
    threeStar:addState('idle', 1, 14, { tickStep = 1, loop = false, onLoopFinishedEvent = show4Star })
    threeStar:playAnimation()
end

function show4Star()
    fourStar = AnimatedSprite(playdate.graphics.imagetable.new("assets/images/4Star_ThirdEye"))
    playdate.sound.sampleplayer.new("assets/sounds/end_04"):play()

    fourStar:moveTo(248, 225)
    fourStarAnimation = Animator.new(bounceInTime, 240, 225, easingFunc)
    fourStar:addState('idle', 1, 10, { tickStep = 2, loop = false, onLoopFinishedEvent = show5Star })
    fourStar:playAnimation()
end

function show5Star()
    fiveStar = AnimatedSprite(playdate.graphics.imagetable.new("assets/images/5Star_Crown"))
    playdate.sound.sampleplayer.new("assets/sounds/end_05"):play()

    fiveStar:moveTo(312, 225)
    fiveStarAnimation = Animator.new(bounceInTime, 240, 225, easingFunc)
    fiveStar:addState('idle', 1, 13, { tickStep = 1, loop = false })
    fiveStar:playAnimation()
end

-- 400 x 240
-- This runs once a transition from another scene is complete.
function CodyTest:start()
    CodyTest.super.start(self)
end

-- This runs once per frame.
function CodyTest:update()
    CodyTest.super.update(self)

    CodyTest.updateSparkle()
    CodyTest.checkDevil()

    if rootChakraAnimation then
        local y = rootChakraAnimation:currentValue()
        rootChakra:moveTo(rootChakra.x, y)
    end

    if twoStarAnimation then
        local y = twoStarAnimation:currentValue()
        twoStar:moveTo(twoStar.x, y)
    end

    if threeStarAnimation then
        local y = threeStarAnimation:currentValue()
        threeStar:moveTo(threeStar.x, y)
    end

    if fourStarAnimation then
        local y = fourStarAnimation:currentValue()
        fourStar:moveTo(fourStar.x, y)
    end

    if fiveStarAnimation then
        local y = fiveStarAnimation:currentValue()
        fiveStar:moveTo(fiveStar.x, y)
    end
end

local sparkels = {}
sparkels["head"] = nil

function onSparkleFinish(key)
    NobleScene:removeSprite(sparkels[key])
    sparkels[key] = nil
end

local canSparkle = true

function getSparkleDelay()
    return 250 + math.random() * 500
end

function getCrunchDelay()
    return 10000 + math.random() * 5000
end

function CodyTest.updateSparkle()
    local randDist = math.random() * 16
    local randRad = math.random() * 2 * math.pi;
    local randX = math.sin(randRad) * randDist
    local randY = math.cos(randRad) * randDist

    local randomNum = math.random()

    -- head
    local hX, hY = headJoint:getPos()
    local headScore = ScoringPoints.getClosestPoint(hX, hY, ScoringPoints.bodyPartType.Head)

    if randomNum < 1 / 5 and canSparkle and headScore.distanceFromBodyPart < 40 and sparkels["head"] == nil then
        canSparkle = false
        local spark = Sparkle(onSparkleFinish, "head")
        spark:moveTo(headScore.x + randX, headScore.y + randY)
        NobleScene:addSprite(spark)
        sparkels["head"] = spark
        playdate.timer.performAfterDelay(getSparkleDelay(), function()
            canSparkle = true
        end)
    end

    -- left arm
    local laX, laY = llArmJoint:getPos()
    local leftArmScore = ScoringPoints.getClosestPoint(laX, laY, ScoringPoints.bodyPartType.LeftLowerArm)

    if randomNum < 2 / 5 and canSparkle and leftArmScore.distanceFromBodyPart < 18 and sparkels["leftarm"] == nil then
        canSparkle = false
        local spark = Sparkle(onSparkleFinish, "leftarm")
        spark:moveTo(leftArmScore.x + randX, leftArmScore.y + randY)
        sparkels["leftarm"] = spark
        playdate.timer.performAfterDelay(getSparkleDelay(), function()
            canSparkle = true
        end)
    end

    -- right arm
    local raX, raY = rlArmJoint:getPos()
    local rightArmScore = ScoringPoints.getClosestPoint(raX, raY, ScoringPoints.bodyPartType.RightLowerArm)

    if randomNum < 3 / 5 and canSparkle and rightArmScore.distanceFromBodyPart < 18 and sparkels["rightarm"] == nil then
        canSparkle = false
        local spark = Sparkle(onSparkleFinish, "rightarm")
        spark:moveTo(rightArmScore.x + randX, rightArmScore.y + randY)
        sparkels["rightarm"] = spark
        playdate.timer.performAfterDelay(getSparkleDelay(), function()
            canSparkle = true
        end)
    end

    -- left arm
    local llX, llY = llLegJoint:getPos()
    local leftLegScore = ScoringPoints.getClosestPoint(llX, llY, ScoringPoints.bodyPartType.LeftLowerLeg)

    if randomNum < 4 / 5 and canSparkle and leftLegScore.distanceFromBodyPart < 12 and sparkels["leftleg"] == nil then
        canSparkle = false
        local spark = Sparkle(onSparkleFinish, "leftleg")
        spark:moveTo(leftLegScore.x + randX, leftLegScore.y + randY)
        sparkels["leftleg"] = spark
        playdate.timer.performAfterDelay(getSparkleDelay(), function()
            canSparkle = true
        end)
    end

    -- right leg
    local rlX, rlY = rlLegJoint:getPos()
    local rightLegScore = ScoringPoints.getClosestPoint(rlX, rlY, ScoringPoints.bodyPartType.RightLowerLeg)

    if canSparkle and rightLegScore.distanceFromBodyPart < 23 and sparkels["rightleg"] == nil then
        canSparkle = false
        local spark = Sparkle(onSparkleFinish, "rightleg")
        spark:moveTo(rightLegScore.x + randX, rightLegScore.y + randY)
        sparkels["rightleg"] = spark
        playdate.timer.performAfterDelay(getSparkleDelay(), function()
            canSparkle = true
        end)
    end

end

function CodyTest.checkDevil()
    local devilChecksPassed = 0

    local hX, hY = headJoint:getPos()
    local headScore = ScoringPoints.getClosestPoint(hX, hY, ScoringPoints.bodyPartType.Head)
    if headScore.chakras[1] == ScoringPoints.chakraTypes.Death
        and headScore.distanceFromBodyPart < 10 then
        devilChecksPassed = devilChecksPassed + 1
    end

    local laX, laY = llArmJoint:getPos()
    local leftArmScore = ScoringPoints.getClosestPoint(laX, laY, ScoringPoints.bodyPartType.LeftLowerArm)
    if leftArmScore.chakras[1] == ScoringPoints.chakraTypes.Death
        and leftArmScore.distanceFromBodyPart < 10 then
        devilChecksPassed = devilChecksPassed + 1
    end

    local raX, raY = rlArmJoint:getPos()
    local rightArmScore = ScoringPoints.getClosestPoint(raX, raY, ScoringPoints.bodyPartType.RightLowerArm)
    if rightArmScore.chakras[1] == ScoringPoints.chakraTypes.Death
        and rightArmScore.distanceFromBodyPart < 10 then
        devilChecksPassed = devilChecksPassed + 1
    end

    local llX, llY = llLegJoint:getPos()
    local leftLegScore = ScoringPoints.getClosestPoint(llX, llY, ScoringPoints.bodyPartType.LeftLowerLeg)
    if leftLegScore.chakras[1] == ScoringPoints.chakraTypes.Death
        and leftLegScore.distanceFromBodyPart < 10 then
        devilChecksPassed = devilChecksPassed + 1
    end

    local rlX, rlY = rlLegJoint:getPos()
    local rightLegScore = ScoringPoints.getClosestPoint(rlX, rlY, ScoringPoints.bodyPartType.RightLowerLeg)
    if rightLegScore.chakras[1] == ScoringPoints.chakraTypes.Death
        and rightLegScore.distanceFromBodyPart < 10 then
        devilChecksPassed = devilChecksPassed + 1
    end

    if devilChecksPassed >= 5 then
        print("devil cleared")
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

    currentJoint = nil
    headJoint = nil
    uBodyJoint = nil
    lBodyJoint = nil
    luArmJoint = nil
    llArmJoint = nil
    ruArmJoint = nil
    rlArmJoint = nil
    luLegJoint = nil
    llLegJoint = nil
    ruLegJoint = nil
    rlLegJoint = nil
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
        if not handleInput then return end
        if currentJoint == confirm then
            endGame()
        end
    end,

    -- B button
    --
    BButtonDown = function()
        if not handleInput then return end

        if Noble.showFPS then
            local hx, hy = headJoint:getPos()
            print("head " .. headJoint.rot .. ":" .. hx .. "x" .. hy)
            print("uBody" .. uBodyJoint.rot .. ":" .. uBodyJoint:getPos())
            print("lBody" .. lBodyJoint.rot .. ":" .. lBodyJoint:getPos())
            print("LUArm" .. luArmJoint.rot .. ":" .. luArmJoint:getPos())
            local lax, lay = llArmJoint:getPos()
            print("LLArm" .. llArmJoint.rot .. ":" .. lax .. "x" .. lay)
            print("RUArm" .. ruArmJoint.rot .. ":" .. ruArmJoint:getPos())
            local rax, ray = rlArmJoint:getPos()
            print("RLArm" .. rlArmJoint.rot .. ":" .. rax .. "x" .. ray)
            print("LULeg" .. luLegJoint.rot .. ":" .. luLegJoint:getPos())
            local llx, lly = llLegJoint:getPos()
            print("LLLeg" .. llLegJoint.rot .. ":" .. llx .. "x" .. lly)
            print("RULeg" .. ruLegJoint.rot .. ":" .. ruLegJoint:getPos())
            local rlx, rly = rlLegJoint:getPos()
            print("RLLeg" .. rlLegJoint.rot .. ":" .. rlx .. "x" .. rly)
        end
    end,

    -- D-pad left
    --
    leftButtonDown = function()
        if not handleInput then return end
        UpdateJointSelector(false, false, true, false)
    end,

    -- D-pad right
    --
    rightButtonDown = function()
        if not handleInput then return end
        UpdateJointSelector(false, false, false, true)
    end,

    -- D-pad up
    --
    upButtonDown = function()
        if not handleInput then return end
        UpdateJointSelector(true, false, false, false)
    end,

    -- D-pad down
    --
    downButtonDown = function()
        if not handleInput then return end
        UpdateJointSelector(false, true, false, false)
    end,

    -- Crank
    --
    cranked = function(change, acceleratedChange) -- Runs when the crank is rotated. See Playdate SDK documentation for details.
        if not handleInput then return end
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
        confirm:updateLocation()
        manageCracks()
    end,
}

function manageCracks()
    if (hasEnoughTimePassed == true) then
        hasEnoughTimePassed = false
        spinSinceLastCrack = 0
        playdate.timer.performAfterDelay(getCrunchDelay(), function()
            hasEnoughTimePassed = true
        end)
        playdate.sound.sampleplayer.new("assets/sounds/bone_crunch_" .. lastCrunchPlayed):play()
        lastCrunchPlayed = lastCrunchPlayed + 1
        if (lastCrunchPlayed > 4) then
            lastCrunchPlayed = 1
        end
    end
end
