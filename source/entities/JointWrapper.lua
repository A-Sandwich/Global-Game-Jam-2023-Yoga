class('JointWrapper').extends()

function JointWrapper:init(joint, upJoint, downJoint, leftJoint, rightJoint)
    self.joint = joint
    self.upJoint = upJoint
    self.downJoint = downJoint
    self.leftJoint = leftJoint
    self.rightJoint = rightJoint
end

function JointWrapper:getRightJoint()
    return self.rightJoint
end
function JointWrapper:getLeftJoint()
    return self.leftJoint
end
function JointWrapper:getDownJoint()
    return self.downJoint
end
function JointWrapper:getUpJoint()
    return self.upJoint
end
function JointWrapper:setRightJoint(value)
    self.rightJoint = value
end
function JointWrapper:setLeftJoint(value)
    self.leftJoint = value
end
function JointWrapper:setDownJoint(value)
    self.downJoint = value
end
function JointWrapper:setUpJoint(value)
    self.upJoint = value
end