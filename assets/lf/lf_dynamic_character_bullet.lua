LF_Dynamic_Character_Bullet = Core.class(Sprite)

function LF_Dynamic_Character_Bullet:init(xworld,
		xtexture, xscalex, xscaley, xfixedrotation,
		xdensity, xrestitution, xfriction,
		xlvx, xlvy, xstartx, xstarty,
		xBIT, xCOLBIT, xTYPE)
	self.world = xworld
	-- the image
	local texture = Texture.new(xtexture, true, {wrap = Texture.REPEAT})
	self.bitmap = Bitmap.new(texture)
	self.bitmap:setAnchorPoint(0.5, 0.5)
	self.bitmap:setScale(xscalex, xscaley)
	self:addChild(self.bitmap)
	-- the body
	self.body = xworld:createBody { type = b2.DYNAMIC_BODY }
	self.body.type = xTYPE
	self.body.isdirty = false
	self.body:setGravityScale(0)
	self.body:setPosition(xstartx, xstarty)
	self.body:setFixedRotation(xfixedrotation)
	self.shape = b2.PolygonShape.new()
	self.shape:setAsBox(self.bitmap:getWidth() / 2, self.bitmap:getHeight() / 2)
	local fixture = self.body:createFixture {
		shape = self.shape, 
		density = xdensity, restitution = xrestitution, friction = xfriction
	}
	local filterData = {categoryBits=xBIT, maskBits=xCOLBIT, groupIndex = 0 }
	fixture:setFilterData(filterData)
	fixture = nil
	self.body:applyLinearImpulse(xlvx, xlvy, self.body:getWorldCenter()) -- physics
	-- listeners
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

-- game loop
function LF_Dynamic_Character_Bullet:onEnterFrame(e)
	if self.body ~= nil then
		if self.body.isdirty then
			self.world:destroyBody(self.body)
			self:getParent():removeChild(self)
			self.body = nil
			return
		end
		self.bitmap:setPosition(self.body:getPosition())
	end
end
