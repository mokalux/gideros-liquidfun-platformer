-- that is for the windmill
LF_Revolute_Joint = Core.class(Sprite)

function LF_Revolute_Joint:init(xworld, xposx, xposy)
	-- the center
	local platbodydef = { type = b2.STATIC_BODY, position = { x = xposx, y = xposy } }
	local platbody = xworld:createBody(platbodydef)
	local platshape = b2.PolygonShape.new()
	platshape:setAsBox(3, 3)
	local platfixturedef = { shape = platshape, density = 1, friction = 0, isSensor = true }
	local fixture = platbody:createFixture(platfixturedef)
	-- the helixes
	local circlebodydef = { type = b2.DYNAMIC_BODY, position = { x = xposx + 64, y = xposy -32 } }
	local circlebody = xworld:createBody(circlebodydef)
	local circleshape = b2.CircleShape.new()
	circleshape:set(0, 0, 32)
	local circlefixturedef = { shape = circleshape, density = 0.1, friction = 0, isSensor = true }
	circlebody:createFixture(circlefixturedef)
	-- the joint
	local revolutejointdef = b2.createRevoluteJointDef(platbody, circlebody, xposx, xposy)
	local revolutejoint = xworld:createJoint(revolutejointdef)
	revolutejoint:enableMotor(true)
	revolutejoint:setMaxMotorTorque(64)
	revolutejoint:setMotorSpeed(1)
	-- listeners
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

function LF_Revolute_Joint:onEnterFrame(e)
end
