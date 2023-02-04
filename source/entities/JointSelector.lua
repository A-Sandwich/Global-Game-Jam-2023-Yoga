class('JointSelector').extends(AnimatedSprite)


function JointSelector:init(torso, head, hip, leftShoulder, leftArm, rightShoulder, rightArm, rightUpperLeg, rightLowerLeg, leftUpperLeg, leftLowerLeg)
    self.imgTable = playdate.graphics.imagetable.new("assets/images/rootChakra-table-32-32")
    JointSelector.super.init(self, self.imgTable) -- this is critical
    
    -- Adding custom a animation state (Optional)
    self:addState('idle',1,9,{ tickStep = 5 })

    -- Playing the animation
    self:playAnimation()
    self:setCenter(0.5, 0.5)
    self.torso = JointWrapper(torso, nil, nil, nil, nil)
    self.head = JointWrapper(head, nil, self.torso, nil, nil)
    
    self.hip = JointWrapper(hip, self.torso, nil, nil, nil)
    self.leftArm = {
        JointWrapper(leftShoulder, nil, nil, nil, self.torso),
        JointWrapper(leftArm, nil, nil, nil, nil)
    }
    self.leftArm[1]:setLeftJoint(self.leftArm[2])
    self.leftArm[1]:setDownJoint(self.leftArm[2])
    
    self.leftArm[2]:setUpJoint(self.leftArm[1])
    self.leftArm[2]:setRightJoint(self.torso)
    self.leftArm[1]:setRightJoint(self.torso)

    self.leftLeg = {
        JointWrapper(leftUpperLeg, self.leftArm[2], nil, nil, nil),
        JointWrapper(leftLowerLeg, nil, nil, nil, nil)
    }
    self.leftLeg[1]:setDownJoint(self.leftLeg[2])
    self.leftLeg[2]:setUpJoint(self.leftLeg[1])
    self.leftLeg[2]:setDownJoint(self.leftArm[1])
    self.leftArm[1]:setUpJoint(self.leftLeg[2])
    self.leftArm[2]:setDownJoint(self.leftLeg[1])
    self.leftLeg[2]:setDownJoint(self.leftArm[1])
    
    self.rightArm = {
        JointWrapper(rightShoulder, nil, nil, self.torso, nil),
        JointWrapper(rightArm, nil, nil, nil, nil)
    }
    self.rightArm[1]:setRightJoint(self.rightArm[2])
    self.rightArm[1]:setDownJoint(self.rightArm[2])
    self.rightArm[2]:setLeftJoint(self.rightArm[1])
    self.rightArm[2]:setUpJoint(self.rightArm[1])
    self.leftArm[2]:setLeftJoint(self.rightArm[2])
    

    self.rightLeg = {
        JointWrapper(rightUpperLeg, self.rightArm[2], nil, nil, self.hip),
        JointWrapper(rightLowerLeg, nil, self.rightArm[1], nil, nil)
    }
    self.rightLeg[1]:setDownJoint(self.rightLeg[2])
    self.rightLeg[2]:setUpJoint(self.rightLeg[1])
    self.rightLeg[2]:setRightJoint(self.leftLeg[2])
    self.rightArm[2]:setRightJoint(self.rightLeg[1])
    self.rightArm[2]:setDownJoint(self.rightLeg[1])
    self.rightArm[1]:setUpJoint(self.rightLeg[2])
    self.leftLeg[2]:setLeftJoint(self.rightLeg[2])
    self.rightLeg[2]:setLeftJoint(self.leftLeg[2])
    self.leftLeg[2]:setRightJoint(self.rightLeg[2])
    self.leftLeg[1]:setRightJoint(self.hip)

    
    self.hip:setLeftJoint(self.leftLeg[1])
    self.hip:setRightJoint(self.rightLeg[1])
    self.hip:setDownJoint(self.torso)
    self.head:setUpJoint(self.hip)

    self.torso:setUpJoint(self.head)
    self.torso:setDownJoint(self.hip)
    self.torso:setRightJoint(self.rightArm[1])
    self.torso:setLeftJoint(self.leftArm[1])

    self.currentJoint = self.torso
end

function JointSelector:getNextJoint(isUp, isDown, isLeft, isRight)
    
    if isUp and self.currentJoint:getUpJoint() ~= nil then
        self.currentJoint = self.currentJoint:getUpJoint()
    end
    if isDown and self.currentJoint:getDownJoint() ~= nil then
        self.currentJoint = self.currentJoint:getDownJoint()
    end
    if isLeft and self.currentJoint:getLeftJoint() ~= nil then
        self.currentJoint = self.currentJoint:getLeftJoint()
    end
    if isRight and self.currentJoint:getRightJoint() ~= nil then
        self.currentJoint = self.currentJoint:getRightJoint()
    end
    
    return self.currentJoint.joint
end