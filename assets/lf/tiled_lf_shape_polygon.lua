Tiled_LF_Polygon = Core.class(Sprite)

function Tiled_LF_Polygon:init(xworld, xparams)
	-- params
	local params = xparams or {}
	params.x = xparams.x or nil
	params.y = xparams.y or nil
	params.coords = xparams.coords or nil
	params.color = xparams.color or 0xff0000
	params.tex = xparams.tex or nil
	params.isshape = xparams.isshape or nil
	params.isbmp = xparams.isbmp or nil
	params.ispixel = xparams.ispixel or nil
	params.isdeco = xparams.isdeco or nil
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
--	if params.BIT == G_BITSENSOR then
	if params.BIT == G_BITSENSOR and not params.TYPE == G_COIN then
		-- no image for sensors
	else
		if params.isshape then
			if params.tex then
				local tex = Texture.new(params.tex, false, {wrap = TextureBase.REPEAT})
				self.img = Shape.new()
				local matrix = Matrix.new(params.scalex, 0, 0, params.scaley, 0, 0)
				self.img:setFillStyle(Shape.TEXTURE, tex, matrix)
				self.img:beginPath()
				self.img:moveTo(params.coords[1].x, params.coords[1].y)
				for p = 2, #params.coords do
					self.img:lineTo(params.coords[p].x, params.coords[p].y)
				end
				self.img:closePath()
				self.img:endPath()
				self.img:setRotation(params.rotation)
				self.w, self.h = self.img:getWidth(), self.img:getHeight()
				tex = nil
			else
				self.img = Shape.new()
				self.img:setFillStyle(Shape.SOLID, params.color)
				self.img:beginPath()
				self.img:moveTo(params.coords[1].x, params.coords[1].y)
				for p = 2, #params.coords do
					self.img:lineTo(params.coords[p].x, params.coords[p].y)
				end
				self.img:closePath()
				self.img:endPath()
				self.img:setRotation(params.rotation)
				self.w, self.h = self.img:getWidth(), self.img:getHeight()
			end
		end
		if params.isbmp then
			if not params.tex then print("!!!YOU MUST PROVIDE A TEXTURE FOR THE BITMAP!!!") return end
			-- calculate polygon width and height
			local minx, maxx, miny, maxy = 0, 0, 0, 0
			for k, v in pairs(params.coords) do
				--print("polygon coords", k, v.x, v.y)
				if v.x < minx then minx = v.x end
				if v.y < miny then miny = v.y end
				if v.x > maxx then maxx = v.x end
				if v.y > maxy then maxy = v.y end
			end
			local pw, ph = maxx - minx, maxy - miny -- the polygon dimensions
			local tex = Texture.new(params.tex, false)
			self.img = Bitmap.new(tex)
			self.img.isbmp = true
			self.img.w, self.img.h = pw, ph
			self.img:setAnchorPoint(0.5, 0.5)
			if params.rotation > 0 then self.img:setAnchorPoint(0, 0.5) end
			if params.rotation < 0 then self.img:setAnchorPoint(0.5, 1) end
			self.img:setScale(params.scalex, params.scaley)
			self.img:setRotation(params.rotation)
			tex = nil
		end
		if params.ispixel then
			if params.tex then
				-- calculate polygon width and height
				local minx, maxx, miny, maxy = 0, 0, 0, 0
				for k, v in pairs(params.coords) do
					--print("polygon coords", k, v.x, v.y)
					if v.x < minx then minx = v.x end
					if v.y < miny then miny = v.y end
					if v.x > maxx then maxx = v.x end
					if v.y > maxy then maxy = v.y end
				end
				local pw, ph = maxx - minx, maxy - miny -- the polygon dimensions
				local tex = Texture.new(params.tex, false, {wrap = TextureBase.REPEAT})
				self.img = Pixel.new(tex, pw, ph)
				self.img.ispixel = true
				self.img.w, self.img.h = pw, ph
				self.img:setAnchorPoint(0, -0.5) -- 0.5, 0.5
				if params.rotation > 0 then self.img:setAnchorPoint(0, 0.5) end
				if params.rotation < 0 then self.img:setAnchorPoint(0.5, 1) end
				self.img:setScale(params.scalex, params.scaley)
				self.img:setRotation(params.rotation)
				self.img:setTexturePosition(0, 0)
				tex = nil
			else
				-- calculate polygon width and height
				local minx, maxx, miny, maxy = 0, 0, 0, 0
				for k, v in pairs(params.coords) do
					--print("polygon coords", k, v.x, v.y)
					if v.x < minx then minx = v.x end
					if v.y < miny then miny = v.y end
					if v.x > maxx then maxx = v.x end
					if v.y > maxy then maxy = v.y end
				end
				local pw, ph = maxx - minx, maxy - miny -- the polygon dimensions
				self.img = Pixel.new(params.color, 1, pw, ph)
				self.img.ispixel = true
				self.img.w, self.img.h = pw, ph
				self.img:setScale(params.scalex, params.scaley)
				self.img:setRotation(params.rotation)
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
			end
			return
		end
	end
	-- body
	self.body = xworld:createBody {type = params.type}
	self.body.type = params.TYPE
	self.body.isdirty = false
	self.body:setFixedRotation(params.fixedrotation)
	local shape = b2.ChainShape.new()
	local cs = {}
	for c = 1, #params.coords do
		cs[#cs+1] = params.coords[c].x * params.scalex
		cs[#cs+1] = params.coords[c].y * params.scaley
	end
	shape:createLoop(unpack(cs)) -- XXX
	local fixture = self.body:createFixture {
		shape = shape,
		density = params.density, restitution = params.restitution, friction = params.friction, isSensor = params.issensor
	}
	if params.BIT == G_BITSENSOR then fixture:setSensor(true) end
	local filterData = { categoryBits = params.BIT, maskBits = params.COLBIT, groupIndex = 0 }
	fixture:setFilterData(filterData)
	filterData = nil
	fixture = nil
	cs = nil
	shape = nil
	tex = nil
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

function Tiled_LF_Polygon:onEnterFrame()
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
		if not self.isdestructible then
			local x, y = self.img:getPosition()
			if x >= self.maxposx then self.lvx = -self.lvx end
			if x <= self.minposx then self.lvx = -self.lvx end
			if y >= self.maxposy then self.lvy = -self.lvy end
			if y <= self.minposy then self.lvy = -self.lvy end
			if self.img then
				self.img:setPosition(x + self.lvx, y + self.lvy)
				self.img:setRotation(self.img:getRotation() + 0 * 180 / math.pi)
			end
		end
	end
end

function Tiled_LF_Polygon:setPosition(xposx, xposy)
	if self.body then
		self.body:setPosition(xposx, xposy)
		if self.img then self.img:setPosition(self.body:getPosition()) end
	else
		if self.img then self.img:setPosition(xposx, xposy) end
	end
end
