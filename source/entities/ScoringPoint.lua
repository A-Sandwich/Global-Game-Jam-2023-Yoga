ScoringPoints = {}

ScoringPoints.bodyPartType = {
    Head = "Head",
    UpperBody = "UpperBody",
    LowerBody = "LowerBody",
    RightUpperArm = "RightUpperArm",
    RightLowerArm = "RightLowerArm",
    LeftUpperArm = "LeftUpperArm",
    LeftLowerArm = "LeftLowerArm",
    RightUpperLeg = "RightUpperLeg",
    RightLowerLeg = "RightLowerLeg",
    LeftUpperLeg = "LeftUpperLeg",
    LeftLowerLeg = "LeftLowerLeg"
}

ScoringPoints.chakraTypes = {
    Crown = "Crown",
    ThirdEye = "ThirdEye",
    Throat = "Throat",
    Heart = "Heart",
    Solarplexus = "Solarplexus",
    Sacral = "Sacral",
    Root = "Root",
    Death = "Death"
}

ScoringPoints.allPoints = {}

function ScoringPoints.reset()
    ScoringPoints.allPoints = {}
end

function ScoringPoints.add(x, y, bodyPart, chakras)
    ScoringPoints.allPoints[#ScoringPoints.allPoints + 1] = ScoringPoint(x, y, bodyPart, chakras)
end

function ScoringPoints.drawDebug()
    for _, v in pairs(ScoringPoints.allPoints) do
        v:drawDebug()
    end
end

function ScoringPoints.getClosestPoint(x, y, bodyPart)
    local bodyPartPoint = playdate.geometry.point.new(x, y)
    local pointsForBodyPart = {}
    for _, v in pairs(ScoringPoints.allPoints) do
        if v.bodyPart == bodyPart then
            pointsForBodyPart[#pointsForBodyPart + 1] = v
        end
    end

    local closetPointDistance = nil
    local closestPoint = nil

    for _, v in pairs(pointsForBodyPart) do
        local sPoint = playdate.geometry.point.new(v.x, v.y)
        local distance = bodyPartPoint:distanceToPoint(sPoint)
        if closestPoint == nil then
            closestPoint = v
            closetPointDistance = distance
        elseif closetPointDistance > distance then
            closestPoint = v
            closetPointDistance = distance
        end
    end

    closestPoint.distanceFromBodyPart = closetPointDistance

    return closestPoint
end

ScoringPoint = {}
class('ScoringPoint').extends()

function ScoringPoint:init(x, y, bodyPart, chakras)
    self.x = x
    self.y = y
    self.bodyPart = bodyPart
    self.chakras = chakras
end

function ScoringPoint:drawDebug()
    Graphics.drawCircleAtPoint(self.x, self.y, 5)
end
