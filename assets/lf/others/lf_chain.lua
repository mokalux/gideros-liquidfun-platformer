LF_Chain = Core.class(Sprite)

function LF_Chain:init()
	-- a chain (rope)
	self.chainactors = {}
	-- create ground body
	local chainground = self.world:createBody({})
	-- this box shape will be used while creating the chain elements
	local shape = b2.PolygonShape.new()
	shape:setAsBox(2, 2)
	-- and our fixture definition
	local fixtureDef = { shape = shape, density = 20, friction = 0.2 }
	-- start to create the chain
	local prevBody = chainground
	for i = 1, 8 do
		local bodyDef = { type = b2.DYNAMIC_BODY, position = { x = 1600 + i * 24, y = 0 } }
		local body = self.world:createBody(bodyDef)
		body:createFixture(fixtureDef)
		local bitmap = Bitmap.new(Texture.new("gfx/npcs/ghost.png", true))
		bitmap:setAnchorPoint(0.5, 0.5)
		bitmap:setScale(0.5)
--		self.gamelayer:addChild(bitmap)
		self.chainactors[body] = bitmap
		-- attach each pair of chain elements with revolute joint
		local jointDef = b2.createRevoluteJointDef(prevBody, body, 1600 + i * 24, 0)
		jointDef.collideConnected = false
		self.world:createJoint(jointDef)
		prevBody = body
	end
end

	-- the chain
--[[
	for body, sprite in pairs(self.chainactors) do
		sprite:setPosition(body:getPosition())
		sprite:setRotation(body:getAngle() * 180 / math.pi)
	end
]]
