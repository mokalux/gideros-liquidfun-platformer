LF_Bridge = Core.class(Sprite)

function LF_Bridge:init(xworld, xtexture, xposx, xposy, xposxend, xposyend, xw, xh)
	self.bridgeactors = {}
	-- create ground body
	local bridgeground = xworld:createBody({})
	bridgeground:setPosition(xposx, xposy)
	-- this box shape will be used while creating the bridge elements
	local shape = b2.PolygonShape.new()
	shape:setAsBox(xw, xh)
	-- and our fixture definition
	local fixtureDef = {shape = shape, density = 32, friction = 0.2}
	-- start to create the bridge
	local prevBody = bridgeground
--	local stepsx = math.floor(math.abs(xposxend - xposx) / xw) / 2
	local stepsx = math.abs(xposxend - xposx) / xw / 2
--	print(stepsx)
	for i = 1, stepsx - 1, 0.9 do
		local bodyDef = {type = b2.DYNAMIC_BODY, position = {x = xposx + i * xw * 2, y = xposy + 0}}
		local body = xworld:createBody(bodyDef)
		body:createFixture(fixtureDef)
		local bitmap = Bitmap.new(Texture.new(xtexture, true))
		bitmap:setAnchorPoint(0.5, 0.5)
		self:addChild(bitmap)
		self.bridgeactors[body] = bitmap
		-- attach each pair of bridge elements with revolute joint
		local jointDef = b2.createRevoluteJointDef(prevBody, body, xposx + i * xw * 2, xposy - 4)
		xworld:createJoint(jointDef)
		prevBody = body
	end
	-- attach last bridge element to the ground body
--	local jointDef = b2.createRevoluteJointDef(prevBody, bridgeground, xposx + (stepsx + 1) * xw * 2, xposy - 8)
	local jointDef = b2.createRevoluteJointDef(prevBody, bridgeground, xposx + stepsx * xw * 2, xposy - 12)
--	local jointDef = b2.createRevoluteJointDef(prevBody, bridgeground, xposxend, xposyend)
	xworld:createJoint(jointDef)
	
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

function LF_Bridge:onEnterFrame(e)
	for body, sprite in pairs(self.bridgeactors) do
		sprite:setPosition(body:getPosition())
		sprite:setRotation(body:getAngle() * 180 / math.pi)
	end
end
