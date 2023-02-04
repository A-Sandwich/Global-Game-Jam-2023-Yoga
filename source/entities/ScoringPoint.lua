ScoringPoint = {}
class('ScroingPoint').extends()

ScoringPoint.bodyPartType = {
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

ScoringPoint.allPoints = {}

function ScoringPoint:init(x, y, bodyPart)
    self.x = x
    self.y = y
    self.bodyPart = bodyPart
end

function ScoringPoint.add(x, y, bodyPart)
    ScoringPoint.allPoints[#ScoringPoint.allPoints + 1] = ScoringPoint(x, y, bodyPart)
end

function ScoringPoint.getClosestPoint(x, y, bodyPart)
    local pointsForBodyPoint = {}
    for _, v in pairs(ScoringPoint.allPoints) do
        if v.bodyPart == bodyPart then
            pointsForBodyPoint[#pointsForBodyPoint + 1] = v
        end
    end
end
