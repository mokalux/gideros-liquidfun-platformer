LF_Prismatic_Joint = Core.class(Sprite)

function LF_Prismatic_Joint:init(xworld)
	-- prismatic joint
	local pjground = self.world:createBody{}
	--function LF_Body:init(xworld, xtype, xtexture, xscalex, xscaley, xfixedrotation, xdensity, xrestitution, xfriction)
	self.dummy = LF_Dynamic_Contour.new(self.world, "gfx/platforms/mytile32.png", 3, 1, true, 5, 0, 1)
	self.dummy.body:setPosition(1260, 0)
	self.dummy.body:setGravityScale(0)
	local pjdef = b2.createPrismaticJointDef(pjground, self.dummy.body, 0, 0, 0, 1)
	self.pj = xworld:createJoint(pjdef)
	self.pj:setLimits(-96, 96)
	self.pj:enableLimit(true)
	self.pj:setMaxMotorForce(16)
	self.pj:setMotorSpeed(-1)
	self.pj:enableMotor(true)
	self.gamelayer:addChild(self.dummy)
end

--[[
	local pposx, pposy = self.dummy.body:getPosition()
	self.dummy:setPosition(pposx, pposy)
	self.dummy:setRotation(self.dummy.body:getAngle() * 180 / math.pi)
	local pjll, pjhl = self.pj:getLimits()
	if self.pj:getJointTranslation() <= pjll + 10 then
		self.pj:setMotorSpeed(1) -- going down
	end
	if self.pj:getJointTranslation() >= pjhl - 10 then
		self.pj:setMotorSpeed(-4) -- going up
	end
]]
