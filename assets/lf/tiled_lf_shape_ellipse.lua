Tiled_LF_Ellipse = Core.class(Sprite)

function Tiled_LF_Ellipse:init(xworld, xparams)
	-- params
	local params = xparams or {}
	params.x = xparams.x or nil
	params.y = xparams.y or nil
	params.w = xparams.w or 32
	params.h = xparams.h or 32
	params.steps = xparams.steps or 64 -- 24
	params.color = xparams.color or 0xff0000
	params.tex = xparams.tex or nil
	params.isdeco = xparams.isdeco or nil
	params.isshape = xparams.isshape or nil
	params.isbmp = xparams.isbmp or nil
	params.ispixel = xparams.ispixel or nil
	params.isflow = xparams.isflow or nil -- niagara effect?
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
	if params.BIT == G_BITSENSOR then
		-- no image for sensors
	else
		local sin, cos, d2r = math.sin, math.cos, math.pi / 180
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
			self.img:setLineStyle(0) -- 2
			self.img:beginPath()
			for i = 0, 360, 360 / params.steps  do
				self.img:lineTo((params.w / 2) + params.w / 2 * sin(i * d2r), (params.h / 2) + params.h / 2 * cos(i * d2r))
			end
			self.img:endPath()
			self.img:setRotation(params.rotation)
		end
		if params.isbmp then
			if not params.tex then print("!!!YOU MUST PROVIDE A TEXTURE FOR THE BITMAP!!!") return end
			local tex = Texture.new(params.tex, false)
			self.img = Bitmap.new(tex)
			self.img.w, self.img.h = params.w, params.h
			if params.rotation > 0 then self.img:setAnchorPoint(0, 0.5) end
			if params.rotation < 0 then self.img:setAnchorPoint(0.5, 1) end
			self.img:setScale(params.scalex, params.scaley)
			self.img:setRotation(params.rotation)
--			print("bmp", params.w, params.h)
			tex = nil
		end
		if params.ispixel then
			if params.tex then
				local tex = Texture.new(params.tex, false, {wrap = TextureBase.REPEAT})
				self.img = Pixel.new(tex, params.w, params.h)
				self.img.ispixel = true
				self.img.w, self.img.h = params.w, params.h
				self.img:setScale(params.scalex, params.scaley)
				self.img:setRotation(params.rotation)
--				print("pixel", params.w, params.h, params.rotation)
				tex = nil
			else
				self.img = Pixel.new(0xff0000, 1, params.w, params.h)
				self.img.ispixel = true
				self.img.w, self.img.h = params.w, params.h
				self.img:setScale(params.scalex, params.scaley)
				self.img:setRotation(params.rotation)
--				print("pixel", params.w, params.h, params.rotation)
			end
		end
		-- debug
		if self.img then
			if xworld.isdebug then self.img:setAlpha(0.5) end
			self:addChild(self.img)
		end
		-- listeners?
		if params.isdeco and not params.isdestructible then
			if params.lvx or params.lvy then
				self.lvx, self.lvy = params.lvx or 0, params.lvy or 0
				self.minposx, self.minposy = params.minposx or (params.x - 8 * 4), params.minposy or (params.y - 8 * 2)
				self.maxposx, self.maxposy = params.maxposx or (params.x + 8 * 4), params.maxposy or (params.y + 8 * 2)
				self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
			elseif params.isflow then -- niagara
				self.isflow = true
				self.flow = 0
				self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
			end
			return
		end
	end
	-- body
	self.body = xworld:createBody { type = params.type } -- b2.STATIC_BODY, b2.KINEMATIC_BODY, b2.DYNAMIC_BODY
	self.body.isdirty = false
	self.body.type = params.TYPE
	self.body:setFixedRotation(params.fixedrotation)
	if params.w < params.h then -- capsule up
		local shape = b2.CircleShape.new(params.w / 2, params.w / 2, params.w / 2) -- (centerx, centery, radius)
		local shape2 = b2.CircleShape.new(params.w / 2, params.h - (params.w / 2), params.w / 2) -- (centerx, centery, radius)
		local shape3 = b2.EdgeShape.new(0, params.w / 2, 0, params.h - (params.w / 2)) -- (x1,y1,x2,y2)
		local shape4 = b2.EdgeShape.new(params.w, params.w / 2, params.w, params.h - (params.w / 2)) -- (x1,y1,x2,y2)
		local fixture = self.body:createFixture {
			shape = shape,
			density = params.density, restitution = params.restitution, friction = params.friction, isSensor = params.issensor
		}
		local fixture2 = self.body:createFixture {
			shape = shape2,
			density = params.density, restitution = params.restitution, friction = params.friction, isSensor = params.issensor
		}
		local fixture3 = self.body:createFixture {
			shape = shape3,
			density = params.density, restitution = params.restitution, friction = params.friction, isSensor = params.issensor
		}
		local fixture4 = self.body:createFixture {
			shape = shape4,
			density = params.density, restitution = params.restitution, friction = params.friction, isSensor = params.issensor
		}
		if self.body.type == G_CAM_POS then
			fixture:setSensor(true) fixture2:setSensor(true) fixture3:setSensor(true) fixture4:setSensor(true)
		end
		local filterData = { categoryBits = params.BIT, maskBits = params.COLBIT, groupIndex = 0 }
		fixture:setFilterData(filterData)
		fixture2:setFilterData(filterData)
		fixture3:setFilterData(filterData)
		fixture4:setFilterData(filterData)
		filterData = nil
		fixture, fixture2, fixture3, fixture4 = nil, nil,nil, nil
		shape, shape2, shape3, shape4 = nil, nil, nil, nil
	elseif params.w > params.h then -- capsule laid
		print("capsule laid")
		local shape = b2.CircleShape.new(params.h / 2, params.h / 2, params.h / 2) -- (centerx, centery, radius)
		local shape2 = b2.CircleShape.new(params.w - (params.h / 2), params.h / 2, params.h / 2)
		local shape3 = b2.EdgeShape.new(params.h / 2, 0, params.w - (params.h / 2), 0) -- (x1,y1,x2,y2)
		local shape4 = b2.EdgeShape.new(params.h / 2, params.h, params.w - (params.h / 2), params.h) -- (x1,y1,x2,y2)
		local fixture = self.body:createFixture {
			shape = shape,
			density = params.density, restitution = params.restitution, friction = params.friction, isSensor = params.issensor
		}
		local fixture2 = self.body:createFixture {
			shape = shape2,
			density = params.density, restitution = params.restitution, friction = params.friction, isSensor = params.issensor
		}
		local fixture3 = self.body:createFixture {
			shape = shape3,
			density = params.density, restitution = params.restitution, friction = params.friction, isSensor = params.issensor
		}
		local fixture4 = self.body:createFixture {
			shape = shape4,
			density = params.density, restitution = params.restitution, friction = params.friction, isSensor = params.issensor
		}
		local filterData = { categoryBits = params.BIT, maskBits = params.COLBIT, groupIndex = 0 }
		fixture:setFilterData(filterData)
		fixture2:setFilterData(filterData)
		fixture3:setFilterData(filterData)
		fixture4:setFilterData(filterData)
		-- clean
		filterData = nil
		fixture, fixture2, fixture3, fixture4 = nil, nil,nil, nil
		shape, shape2, shape3, shape4 = nil, nil, nil, nil
	else -- circle
		local shape = b2.CircleShape.new(params.w / 2, params.h / 2, params.w / 2) -- (centerx, centery, radius)
		local fixture = self.body:createFixture {
			shape = shape,
			density = params.density, restitution = params.restitution, friction = params.friction, isSensor = params.issensor
		}
		local filterData = { categoryBits = params.BIT, maskBits = params.COLBIT, groupIndex = 0 }
		fixture:setFilterData(filterData)
		filterData = nil
		fixture = nil
		shape = nil
	end
	-- listeners?
	if params.TYPE == G_EXIT then params.isdestructible = true end
	if params.isdestructible or params.lvx or params.lvy then
		self.world = xworld
		if params.isdestructible then self.isdestructible = params.isdestructible end
		if params.lvx or params.lvy then
			self.lvx, self.lvy = params.lvx or 0, params.lvy or 0
			self.minposx, self.minposy = params.minposx or (params.x - 4 * 2), params.minposy or (params.y - 4 * 2)
			self.maxposx, self.maxposy = params.maxposx or (params.x + 4 * 2), params.maxposy or (params.y + 4 * 2)
		end
		self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	end
end

function Tiled_LF_Ellipse:onEnterFrame()
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
		if not self.isdestructible and not self.isflow then
			local x, y = self.img:getPosition()
			if x >= self.maxposx then self.lvx = -self.lvx end
			if x <= self.minposx then self.lvx = -self.lvx end
			if y >= self.maxposy then self.lvy = -self.lvy end
			if y <= self.minposy then self.lvy = -self.lvy end
			if self.img then
				self.img:setPosition(x + self.lvx, y + self.lvy)
				self.img:setRotation(0 * 180 / math.pi)
			end
		end
		if self.isflow then self.flow += 3 self.img:setTexturePosition(0, self.flow) end
	end
end

function Tiled_LF_Ellipse:setPosition(xposx, xposy)
	if self.body then
		self.body:setPosition(xposx, xposy)
		if self.img then self.img:setPosition(self.body:getPosition()) end
	else
		if self.img then self.img:setPosition(xposx, xposy) end
	end
end
