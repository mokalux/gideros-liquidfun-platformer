LF_Revolute_Joint = Core.class(Sprite)

function LF_Revolute_Joint:init(xworld)
	local platbodydef = { type = b2.STATIC_BODY, position = { x = 1400, y = 64 } }
	local platbody = self.world:createBody(platbodydef)
	local platshape = b2.PolygonShape.new()
	platshape:setAsBox(32, 32)
	local platfixturedef = { shape = platshape, density = 1, friction = 1 }
	platbody:createFixture(platfixturedef)

	local circlebodydef = { type = b2.DYNAMIC_BODY, position = { x = 1500, y = -32 } }
	local circlebody = self.world:createBody(circlebodydef)
	local circleshape = b2.CircleShape.new()
	circleshape:set(0, 0, 32)
	local circlefixturedef = { shape = circleshape, density = 0.1, friction = 1 }
	circlebody:createFixture(circlefixturedef)

--	local revolutejointdef = b2.createRevoluteJointDef(boxbody, circlebody, 0, 0)
	local revolutejointdef = b2.createRevoluteJointDef(platbody, circlebody, 1400, 64)
	local revolutejoint = xworld:createJoint(revolutejointdef)
end
