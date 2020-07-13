Tiled_LF_Rectangle = Core.class(Sprite)

function Tiled_LF_Rectangle:init(xworld, xparams)
	-- params
	local params = xparams or {}
	params.x = xparams.x or nil
	params.y = xparams.y or nil
	params.w = xparams.w or 32
	params.h = xparams.h or 32
	params.color = xparams.color or 0xff0000
	params.alpha = xparams.alpha or 1
	params.tex = xparams.tex or nil
	params.isdeco = xparams.isdeco or nil
	params.isshape = xparams.isshape or nil
	params.isbmp = xparams.isbmp or nil
	params.ispixel = xparams.ispixel or nil
	params.scalex = xparams.scalex or 1
	params.scaley = xparams.scaley or 1
	params.rotation = xparams.rotation or 0
	params.type = xparams.type or nil -- default = b2.STATIC_BODY
	params.isdestructible = xparams.isdestructible or nil
	params.fixedrotation = xparams.fixedrotation or true
	params.density = xparams.density or nil
	params.restitution = xparams.restitution or nil
	params.friction = xparams.friction or nil
	params.issensor = xparams.issensor or false
	params.gravityscale = xparams.gravityscale or 1
	params.lvx = xparams.lvx or nil
	params.lvy = xparams.lvy or nil
	params.minposx = xparams.minposx or nil
	params.minposy = xparams.minposy or nil
	params.maxposx = xparams.maxposx or nil
	params.maxposy = xparams.maxposy or nil
	params.BIT = xparams.BIT or nil
	params.COLBIT = xparams.COLBIT or nil
	params.TYPE = xparams.TYPE or nil
	-- image
	if params.BIT == G_BITSENSOR or params.issensor then
		-- no image for sensors
	else
		if params.isshape then
			self.img = Shape.new()
			if params.tex then
				local tex = Texture.new(params.tex, false, {wrap = Texture.REPEAT})
				local matrix = Matrix.new(params.scalex, 0, 0, params.scaley, 0, 0)
				self.img:setFillStyle(Shape.TEXTURE, tex, matrix)
				tex = nil
			else
				self.img:setFillStyle(Shape.SOLID, params.color)
			end
			--self.img:setLineStyle(2)
			self.img:beginPath()
			self.img:moveTo(0, 0)
			self.img:lineTo(params.w, 0)
			self.img:lineTo(params.w, params.h)
			self.img:lineTo(0, params.h)
			self.img:lineTo(0, 0)
			self.img:endPath()
			if params.rotation < 0 then self.img:setAnchorPoint(0, -0.5) end
			if params.rotation > 0 then self.img:setAnchorPoint(0, 0.5) end
			self.img:setRotation(params.rotation)
			self.img:setAlpha(params.alpha)
		end
		if params.isbmp then
			if not params.tex then print("!!!YOU MUST PROVIDE A TEXTURE FOR THE BITMAP!!!") return end
			local tex = Texture.new(params.tex, false)
			self.img = Bitmap.new(tex)
			self.img.isbmp = true
			self.img.w, self.img.h = params.w, params.h
			if params.rotation < 0 then self.img:setAnchorPoint(0, 0.5) end
--			if params.rotation > 0 then self.img:setAnchorPoint(0, 0.5) end
			self.img:setScale(params.scalex, params.scaley)
			self.img:setRotation(params.rotation)
			self.img:setAlpha(params.alpha)
			tex = nil
		end
		if params.ispixel then
			if params.tex then
				local tex = Texture.new(params.tex, false, {wrap = TextureBase.REPEAT})
				self.img = Pixel.new(tex, params.w, params.h)
				self.img.ispixel = true
				self.img.w, self.img.h = params.w, params.h
				self.img:setScale(params.scalex, params.scaley)
				if params.rotation < 0 then self.img:setAnchorPoint(0, -0.5) end
				if params.rotation > 0 then self.img:setAnchorPoint(0, 0.5) end
				self.img:setRotation(params.rotation)
				self.img:setAlpha(params.alpha)
				tex = nil
			else
				self.img = Pixel.new(params.color, 1, params.w, params.h)
				self.img.ispixel = true
				self.img.w, self.img.h = params.w, params.h
				self.img:setScale(params.scalex, params.scaley)
				self.img:setRotation(params.rotation)
				self.img:setAlpha(params.alpha)
			end
		end
		-- debug
		if self.img then
			if xworld.isdebug then self.img:setAlpha(0.5) end
			self:addChild(self.img)
		end
		-- listeners?
		if params.isdeco and (not params.isdestructible or params.isdestructible == nil) then
			if params.lvx or params.lvy then
				self.lvx, self.lvy = params.lvx or 0, params.lvy or 0
				self.minposx, self.minposy = params.minposx or (params.x - 4 * 2), params.minposy or (params.y - 4 * 2)
				self.maxposx, self.maxposy = params.maxposx or (params.x + 4 * 2), params.maxposy or (params.y + 4 * 2)
				self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
			end
			return
		end
	end
	-- body
	self.body = xworld:createBody { type = params.type }
	self.body:setGravityScale(params.gravityscale)
	self.body.type = params.TYPE
	self.body:setFixedRotation(params.fixedrotation)
	local shape = b2.PolygonShape.new()
	shape:setAsBox(params.w/2, params.h/2, params.w/2, params.h/2, ^<params.rotation) -- (half w, half h, centerx, centery, rotation)
	local fixture = self.body:createFixture {
		shape = shape,
		density = params.density, restitution = params.restitution, friction = params.friction, isSensor = params.issensor
	}
	if self.body.type == G_CAM_POS then fixture:setSensor(true) end
	local filterData = { categoryBits = params.BIT, maskBits = params.COLBIT, groupIndex = 0 }
	fixture:setFilterData(filterData)
	filterData = nil
	fixture = nil
	shape = nil
	tex = nil
	-- listeners?
	if params.TYPE == G_EXIT then params.isdestructible = true end
	if params.isdestructible or params.lvx or params.lvy then
		self.world = xworld
		if params.isdestructible then self.isdestructible = params.isdestructible end
		if params.lvx or params.lvy then
			self.lvx, self.lvy = params.lvx or 0, params.lvy or 0
			self.minposx, self.minposy = params.minposx or (params.x - 8 * 4), params.minposy or (params.y - 8 * 4)
			self.maxposx, self.maxposy = params.maxposx or (params.x + 8 * 4), params.maxposy or (params.y + 8 * 4)
		end
		self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	end
end

function Tiled_LF_Rectangle:onEnterFrame()
	if self.body then
		if self.body.isdirty then -- destructible
			self.world:destroyBody(self.body)
			self:getParent():removeChild(self)
			if self.body.type == G_COIN then table.remove(self.world.coins) end
			if self.body.type == G_EXIT then
				g_currentlevel += 1
				if g_currentlevel > #tiled_levels then g_currentlevel = 1 end -- magik XXX
				scenemanager:changeScene("levelX", 3) -- magik XXX
			end
			self.body = nil
			self.img = nil
			return
		end
		if self.lvx or self.lvy then -- moving
			local x, y = self.body:getPosition()
			if x >= self.maxposx then self.lvx = -self.lvx end
			if x <= self.minposx then self.lvx = -self.lvx end
			if y >= self.maxposy then self.lvy = -self.lvy end
			if y <= self.minposy then self.lvy = -self.lvy end
			self.body:setLinearVelocity(self.lvx, self.lvy)
			if self.img then
				self.img:setPosition(self.body:getPosition())
				self.img:setRotation(self.body:getAngle() * 180 / math.pi)
			end
		end
	else -- deco
		if not self.isdestructible and self.img then
			local x, y = self.img:getPosition()
			if x >= self.maxposx then self.lvx = -self.lvx end
			if x <= self.minposx then self.lvx = -self.lvx end
			if y >= self.maxposy then self.lvy = -self.lvy end
			if y <= self.minposy then self.lvy = -self.lvy end
			if self.img then
				self.img:setPosition(x + self.lvx, y + self.lvy)
				self.img:setRotation(0 * 180 / math.pi) -- 0.2 * 180...
			end
		end
	end
end

function Tiled_LF_Rectangle:setPosition(xposx, xposy)
	if self.body then
		self.body:setPosition(xposx, xposy)
		if self.img then self.img:setPosition(self.body:getPosition()) end
	else
		if self.img then self.img:setPosition(xposx, xposy) end
	end
end
