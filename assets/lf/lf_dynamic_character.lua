LF_Dynamic_Character = Core.class(Sprite)

function LF_Dynamic_Character:init(xworld, xspritesheet, xcols, xrows, xbodyoffx, xbodyoffy, xBIT, xCOLBIT, xTYPE)
	-- settings
	self.world = xworld
	self.speed = 7 -- 7 5 4.25 6 8
	self.jumpspeed = 8 * 4
	self.isleft, self.isright, self.isup, self.isdown, self.isspace = false, false, false, false, false -- controls
	-- animations
	self.currentanim = ""
	self.frame = 0
	self.animspeed = 1 / 14 -- 1/6 1/10 1/12
	self.animtimer = self.animspeed
	-- retrieve all anims in spritesheet
	local spritesheettex = Texture.new(xspritesheet)
	local w, h = spritesheettex:getWidth() / xcols, spritesheettex:getHeight() / xrows
	print(xBIT.." size", w, h)
	local spritesheetimgs = {}
	for r = 1, xrows do
		for c = 1, xcols do
			local spritesheettexregion = TextureRegion.new(spritesheettex, (c - 1) * w, (r - 1) * h, w, h)
			spritesheetimgs[#spritesheetimgs + 1] = spritesheettexregion
		end
	end
	-- anims table
	self.anims = {}
	-- create anims function
	local function createAnim(xanimname, xstart, xfinish, xspritesheetimgs)
		self.anims[xanimname] = {}
		for i = xstart, xfinish do
			self.anims[xanimname][#self.anims[xanimname] + 1] = xspritesheetimgs[i]
		end
	end
	-- create anims states
	if xBIT == G_BITPLAYER then
--[[
		createAnim("idle", 1, 6, spritesheetimgs)
		createAnim("jump_up", 15, 17, spritesheetimgs)
		createAnim("jump_down", 18, 20, spritesheetimgs)
		createAnim("run", 7, 14, spritesheetimgs)
		createAnim("wall", 41, 41, spritesheetimgs)
		createAnim("ladder", 37, 40, spritesheetimgs)
		createAnim("ladderidle", 40, 40, spritesheetimgs)
		createAnim("hurt", 30, 31, spritesheetimgs)
		createAnim("dead", 32, 36, spritesheetimgs)
]]
		createAnim("idle", 1, 5, spritesheetimgs)
		createAnim("jump_up", 12, 14, spritesheetimgs)
		createAnim("jump_down", 15, 17, spritesheetimgs)
		createAnim("run", 6, 11, spritesheetimgs)
		createAnim("wall", 41, 41, spritesheetimgs)
		createAnim("ladder", 34, 37, spritesheetimgs)
		createAnim("ladderidle", 35, 35, spritesheetimgs)
		createAnim("hurt", 27, 28, spritesheetimgs)
		createAnim("dead", 27, 33, spritesheetimgs)
	elseif xBIT == G_BITENEMY then
		createAnim("idle", 1, 5, spritesheetimgs)
		createAnim("jump_up", 12, 14, spritesheetimgs)
		createAnim("jump_down", 15, 17, spritesheetimgs)
		createAnim("run", 6, 11, spritesheetimgs)
		createAnim("wall", 12, 14, spritesheetimgs)
		createAnim("ladder", 34, 37, spritesheetimgs)
		createAnim("ladderidle", 34, 34, spritesheetimgs)
		createAnim("hurt", 27, 28, spritesheetimgs)
		createAnim("dead", 29, 33, spritesheetimgs)
	elseif xBIT == G_BITNPC then
		createAnim("idle", 1, 5, spritesheetimgs)
		createAnim("jump_up", 12, 14, spritesheetimgs)
		createAnim("jump_down", 15, 17, spritesheetimgs)
		createAnim("run", 6, 11, spritesheetimgs)
		createAnim("wall", 41, 41, spritesheetimgs)
		createAnim("ladder", 34, 37, spritesheetimgs)
		createAnim("ladderidle", 35, 35, spritesheetimgs)
		createAnim("hurt", 27, 28, spritesheetimgs)
		createAnim("dead", 27, 33, spritesheetimgs)
	else
		print("ERROR LF_Dynamic_Character:init about line 65!")
	end
	-- sprite & bitmap
	local mysprite = Sprite.new()
	self.bitmap = Bitmap.new(spritesheetimgs[1]) -- starting bmp texture
	self.bitmap:setAnchorPoint(0.5, 0.5)
	self.bitmap:setPosition(w / 2, h / 2)
	mysprite:addChild(self.bitmap)
	self:addChild(mysprite)
	-- body
	self.body = xworld:createBody { type = b2.DYNAMIC_BODY }
	self.body:setFixedRotation(true)
	self.body.type = xTYPE
	self.body.lives = 3
	self.body.nrg = 10
	self.body.flip = 1
	self.body.camzoomtrigger = false
	self.body.isdirty = false
	self.body.isdead = false
	self.body.numfloorcontacts = 0 -- is on floor
	self.body.nummpfcontacts = 0 -- is on moving platform
	self.body.numptpfcontacts = 0 -- is on passthrough platform
	self.body.numladdercontacts = 0 -- is on ladder
	self.body.canjump = true
	self.body.isgoingdownplatform = false
	self.body.wasonptpf = false
	self.body.isonnme = false
	self.body.timer = 0
	-- body fixture
	local cx, cy = w / 2 + xbodyoffx, h / 2 + xbodyoffy
	local shape = b2.CircleShape.new(cx, cy, w / 4) -- (centerx, centery, radius)
	local r = 0
	if self.body.type == G_ENEMY01 then r = 0 end -- can adjust bounciness for different nme behavior
	local fixture = self.body:createFixture {
		shape = shape, density = 80, restitution = r, friction = 1 -- friction: 0.9
	}
	local filterData = { categoryBits = xBIT, maskBits = xCOLBIT, groupIndex = 0 }
	fixture:setFilterData(filterData)
	-- ground sensor
	local shapeG = b2.PolygonShape.new()
--	shapeG:setAsBox(w / 1.75, h / 3.5, cx, cy + h / 2, 0) -- (half width, half height, centerx, centery, angle)
	shapeG:setAsBox(w / 4, h / 3.5, cx, cy + h / 2, 0) -- (half width, half height, centerx, centery, angle)
	local fixtureG = self.body:createFixture {
		shape = shapeG, density = 0, restitution = 0, friction = 0, isSensor = true
	}
	local filterDataG = { categoryBits = xBIT, maskBits = G_BITSOLID, groupIndex = 0 }
	fixtureG:setFilterData(filterDataG)
	-- ladder sensor
	local shapeL = b2.CircleShape.new(cx, cy - w / 6, w / 4)
	local fixtureL = self.body:createFixture {
		shape = shapeL, density = 0, restitution = 0, friction = 0, isSensor = true
	}
	local filterDataL = { categoryBits = xBIT, maskBits = G_LADDER, groupIndex = 0 }
	fixtureL:setFilterData(filterDataL)
	-- player
	if xBIT == G_BITPLAYER then
----		self.body:setBullet(true)
		self.body:setSleepingAllowed(false)
	end
	-- nme01 sees player sensor
	if xBIT == G_BITENEMY then
		local shapesensor = b2.CircleShape.new(cx, cy, w * 2) -- (centerx, centery, radius)
		local fixturesensor = self.body:createFixture { shape = shapesensor, friction = 0, isSensor = true }
		local filterDataSensor = { categoryBits = xBIT, maskBits = G_BITPLAYER, groupIndex = 0 }
		fixturesensor:setFilterData(filterDataSensor)
		filterDataSensor = nil
		fixturesensor = nil
		shapesensor = nil
	end
	-- clean?
	filterDataL = nil
	fixtureL = nil
	shapeL = nil
	filterDataG = nil
	fixtureG = nil
	shapeG = nil
	filterData = nil
	fixture = nil
	shape = nil
	mysprite = nil
	spritesheetimgs = nil
	spritesheettex = nil
	-- nrg bar
	self.nrgbarbg = Pixel.new(0xffffff, 1, self.body.nrg * 2, 4)
	self.nrgbarbg:setAnchorPoint(0.5, 0.5)
	self.nrgbarbg:setX(w / 2)
	self.nrgbar = Pixel.new(0x00ff00, 0.85, self.body.nrg * 2, 4)
	self.nrgbar:setAnchorPoint(0.5, 0.5)
	self.nrgbar:setX(w / 2)
	self:addChild(self.nrgbarbg)
	self:addChild(self.nrgbar)
	-- audio
	self.sndjump = Sound.new("audio/jump.wav")
	self.sndshoot = Sound.new("audio/shoot.wav")
	self.audiojump = self.sndjump:play()
	self.audioshoot = self.sndshoot:play()
	self.audiojump:setVolume(0)
	self.audioshoot:setVolume(0)
	-- listeners
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	if xBIT == G_BITPLAYER then
		self:addEventListener(Event.KEY_DOWN, self.onKeyDown, self)
		self:addEventListener(Event.KEY_UP, self.onKeyUp, self)
	end
end

-- update
function LF_Dynamic_Character:onEnterFrame(e)
	if not self.body.isdead then
		local posx, posy = self.body:getPosition()
		local vx, vy = self.body:getLinearVelocity()
		-- was hit?
		if self.body.isdirty then
			self.body.nrg -= 1
			self.nrgbar:setWidth(self.body.nrg * 2) -- magik XXX
			self.currentanim = "hurt"
			self.body.timer = 14 -- magik XXX
			vy = -5 -- -6, -8, magik XXX
			-- MOVE IT ALL
			self.body:setLinearVelocity(vx, vy) -- not the best but will do
			self:setPosition(posx, posy)
			self.bitmap:setScaleX(self.body.flip) -- left/right facing
			self.body.isdirty = false
		elseif self.body.isonnme then
			vy = -16 -- magik XXX
			-- MOVE IT ALL
			self.body:setLinearVelocity(vx, vy) -- not the best but will do
			self:setPosition(posx, posy)
			self.bitmap:setScaleX(self.body.flip) -- left/right facing
		end
		if self.body.nrg <= 0 then
			self.body.lives -= 1
			self.body.nrg = 10 -- magik XXX
		end
		if self.body.lives <= 0 then -- dead
			self.currentanim = "dead"
			self.body.timer = 60
			self.body.isdead = true
			return
		end
		-- ANIM STATES
		-- HURT ALL
		if self.body.timer > 0 then -- funny hit anim :-)
			self.body.timer -= 1
		-- FLOOR
		elseif self.body.numfloorcontacts > 0 or self.body.nummpfcontacts > 0 or self.body.numptpfcontacts > 0 then
			if vx >= -0.001 and vx <= 0.001 then
				self.currentanim = "idle"
			elseif vx ~= 0 then
				if self.body.nummpfcontacts > 0 and not self.isleft and not self.isright then
					self.currentanim = "idle"
				else
					self.currentanim = "run"
				end
			end
		-- LADDER
		elseif self.body.numladdercontacts > 0 and self.body.numfloorcontacts <= 0 then
			if vx == 0 and vy == 0 then
				self.currentanim = "ladderidle"
			else
				self.currentanim = "ladder"
			end
		-- AIR
		else
			if vy < 0 then
				self.currentanim = "jump_up"
			elseif vy > 0 then
				self.currentanim = "jump_down"
			end
		end
		-- ANIM LOOP
		self:animLoop(e)

		-- CONTROLS
		-- FLOOR ONLY
		if self.body.numfloorcontacts > 0 and self.body.numladdercontacts <= 0 then
			self.body.wasonptpf = false
			if self.body:getGravityScale() ~= 1 then self.body:setGravityScale(1) end -- reset gravity
			if self.isleft and not self.isright then -- LEFT
				vx = -self.speed self.body.flip = -1
			elseif self.isright and not self.isleft then -- RIGHT
				vx = self.speed self.body.flip = 1
			end
			if self.isup and not self.isdown and self.body.canjump then -- UP
--				print("floor only")
				if self.body.type == G_PLAYER and not self.audiojump:isPlaying() then
					self.audiojump = self.sndjump:play() self.audiojump:setVolume(0.2)
				end
				vy -= self.jumpspeed * 0.15-- 0.15, 0.25, 0.3 -- magik XXX
				if vy <= -self.jumpspeed / 1.8 then -- 1.9, 2 -- magik XXX
					vy = -self.jumpspeed / 1.8 -- 1.9, 2 -- magik XXX
					self.body.canjump = false
				end
--			elseif self.isdown and not self.isup then -- DOWN
--				print("floor only, nothing to doh!")
			end
		-- MOVING PLATFORM ONLY
		elseif self.body.nummpfcontacts > 0 and self.body.numladdercontacts <= 0 then
			self.body.wasonptpf = false
			if self.body:getGravityScale() ~= 1 then self.body:setGravityScale(1) end -- reset gravity
			if self.isleft and not self.isright then -- LEFT
				vx = -self.speed self.body.flip = -1
			elseif self.isright and not self.isleft then -- RIGHT
				vx = self.speed self.body.flip = 1
			end
			if self.isup and not self.isdown and self.body.canjump then -- UP
--				print("moving platform only up")
				if self.body.type == G_PLAYER and not self.audiojump:isPlaying() then
					self.audiojump = self.sndjump:play() self.audiojump:setVolume(0.2)
				end
				vy -= self.jumpspeed * 0.15 -- 0.25, 0.3 -- magik XXX
				if vy <= -self.jumpspeed / 1.8 then -- 2 -- magik XXX
					vy = -self.jumpspeed / 1.8
					self.body.canjump = false
				end
--			elseif self.isdown and not self.isup then -- DOWN
--				print("moving platform only down, nothing to doh!")
			end
		-- PASSTHROUGH PLATFORM ONLY
		elseif self.body.numptpfcontacts > 0 and self.body.numladdercontacts <= 0 then
			self.body.wasonptpf = true
			if self.body:getGravityScale() ~= 1 then self.body:setGravityScale(1) end -- reset gravity
			if self.isleft and not self.isright then -- LEFT
				vx = -self.speed self.body.flip = -1
			elseif self.isright and not self.isleft then -- RIGHT
				vx = self.speed self.body.flip = 1
			end
			if self.isup and not self.isdown and self.body.canjump then -- UP
				if self.body.type == G_PLAYER and not self.audiojump:isPlaying() then
					self.audiojump = self.sndjump:play() self.audiojump:setVolume(0.2)
				end
--				print("passthrough platform only up")
				vy -= self.jumpspeed * 0.15 -- 0.15, 0.25, 0.3 -- magik XXX
				if vy <= -self.jumpspeed / 1.8 then -- 1.9, 2 -- magik XXX
					vy = -self.jumpspeed / 1.8 -- 1.9
					self.body.canjump = false
				end
			elseif self.isdown and not self.isup then -- DOWN
--				print("passthrough platform only down")
				vy = self.jumpspeed * 0.175 -- 0.3, 0.15, 0.5, magik XXX
				self.body.isgoingdownplatform = true
			end
		-- LADDER ONLY
		elseif self.body.numladdercontacts > 0 and (self.body.numfloorcontacts <= 0 and self.body.nummpfcontacts <= 0 and self.body.numptpfcontacts <= 0) then
			self.body.wasonptpf = false
			if self.body:getGravityScale() ~= 0 then self.body:setGravityScale(0) end -- set 0 gravity
			if self.isleft and not self.isright then -- LEFT
				vx = -self.speed / 2 -- 4
				self.body.flip = -1
			elseif self.isright and not self.isleft then -- RIGHT
				vx = self.speed / 2 -- 4
				self.body.flip = 1
			else -- IDLE
				vx = 0
			end
			if self.isup and not self.isdown then -- UP
--				print("ladder only up")
				vy = -self.jumpspeed / 6 -- 6, magik XXX
			elseif self.isdown and not self.isup then -- DOWN
--				print("ladder only down")
				vy = self.jumpspeed / 6 -- magik XXX
			else -- IDLE
				vy = 0
			end
			-- jump off ladder only
			if (self.isleft or self.isright) and self.isup then
				self.body.jumpoffladder = true -- to modify/refactor XXX
			end
		-- LADDER AND GROUND
		elseif self.body.numladdercontacts > 0 and self.body.numfloorcontacts > 0 then
			self.body.wasonptpf = false
			if self.body:getGravityScale() ~= 1 then self.body:setGravityScale(1) end -- reset gravity
			if self.isleft and not self.isright then -- LEFT
				vx = -self.speed self.body.flip = -1
			elseif self.isright and not self.isleft then -- RIGHT
				vx = self.speed self.body.flip = 1
			end
			if self.isup and not self.isdown then -- UP
--				print("ladder and ground up")
				vy = -self.jumpspeed / 6 -- magik XXX
--			elseif self.isdown and not self.isup then -- DOWN
--				print("ladder and ground down, nothing to doh!")
			end
		-- LADDER AND PASSTHROUGH PLATFORM
		elseif self.body.numladdercontacts > 0 and self.body.numptpfcontacts > 0 then
			self.body.wasonptpf = false
			if self.body:getGravityScale() ~= 1 then self.body:setGravityScale(1) end -- reset gravity
			if self.isleft and not self.isright then -- LEFT
				vx = -self.speed self.body.flip = -1
			elseif self.isright and not self.isleft then -- RIGHT
				vx = self.speed self.body.flip = 1
			end
			if self.isup and not self.isdown then -- UP
--				print("ladder and passthrough platform up")
				vy = -self.jumpspeed / 3 -- 2, 6, magik XXX
			elseif self.isdown and not self.isup then -- DOWN
--				print("ladder and passthrough platform down")
				vy = self.jumpspeed / 6 -- magik XXX
				self.body.isgoingdownplatform = true
			end
		-- AIR
		elseif self.body.numfloorcontacts <= 0 and self.body.nummpfcontacts <= 0 and self.body.numladdercontacts <= 0 then
--			print("air only")
			if self.body:getGravityScale() ~= 1 then self.body:setGravityScale(1) end -- reset gravity
			if self.isleft and not self.isright then -- LEFT
				vx = -self.speed self.body.flip = -1
			elseif self.isright and not self.isleft then -- RIGHT
				vx = self.speed self.body.flip = 1
			else
				vx /= 2 -- stops left/right movement if no left/right keys pressed
			end
			if self.isup or self.isdown then -- UP or DOWN
				self.body.canjump = false -- prevents double jump when pressing up in the air
--				self.isdown = false -- prevents going down pt platform when pressing down in the air
			end
		-- NESPRESSO?
		else
			print("****** nespresso, what else? ******")
		end

		-- MOVE IT ALL
		self.body:setLinearVelocity(vx, vy) -- not the best but will do
		self:setPosition(posx, posy)
		self.bitmap:setScaleX(self.body.flip) -- left/right facing

		-- SHOOT
		if self.isspace then
			self.sndshoot:play()
			local bullet
			if self.body.type == G_PLAYER then
				bullet = LF_Dynamic_Character_Bullet.new(self.world,
						"gfx/ui/btn_02_up.png", 0.5, 0.25, true,
						0.01, 0, 0,
						0.15 * self.body.flip, 0, posx + self:getWidth() / 2, posy + self:getHeight() / 2,
						G_BITPLAYERBULLET, playerbulletcollisions, G_PLAYER_BULLET)
			end
			if self.body.type == G_ENEMY01 then
				bullet = LF_Dynamic_Character_Bullet.new(self.world,
						"gfx/ui/btn_02_up.png", 0.5, 0.25, true,
						0.01, 0, 0,
						0.15 * self.body.flip, 0, posx + self:getWidth() / 2, posy + self:getHeight() / 2,
						G_BITENEMYBULLET, nmebulletcollisions, G_ENEMY_BULLET)
			end
			self:getParent():addChild(bullet)
			self.isspace = false -- android fix here?
		end
	end

	-- DEATH?
	if self.body.type == G_PLAYER and self.body.isdead then
		local vx, vy = 1 * -self.body.flip, -4
		local posx, posy = self.body:getPosition()
		-- MOVE IT ALL
		self.body:setLinearVelocity(vx, vy) -- not the best but will do
		self:setPosition(posx, posy)
		self.bitmap:setScaleX(self.body.flip) -- left/right facing
		self:setAnchorPoint(0.5, 0.5) self:setScale(3)
		self:animLoop(e)
		self.body.timer -= 1
		if self.body.timer <= 0 then
			self.body.timer = 0
			scenemanager:changeScene("levelX", 3) -- magik XXX
		end
	end
	for k, v in pairs(self.world.nmes) do
		if v.isdead then
			local vx, vy = 0.2 * -v.flip, 0 -- -2
			local posx, posy = v:getPosition()
			-- MOVE IT ALL
			v:setLinearVelocity(vx, vy) -- not the best but will do
			k:setPosition(posx, posy)
			self:animLoop(e)
			v.timer -= 0.4
			if v.timer <= 0 then
				v.timer = 0
				self.world:destroyBody(v)
				k:getParent():removeChild(k)
				self.world.nmes[k] = nil
				v = nil
				k = nil -- useful???
			end
		end
	end
end

-- functions
function LF_Dynamic_Character:animLoop(e)
	if self.currentanim ~= "" then
		self.animtimer = self.animtimer - e.deltaTime
		if self.animtimer <= 0 then
			self.frame += 1
			self.animtimer = self.animspeed
			if self.body.isdead then
				if self.frame > #self.anims[self.currentanim] then
					self.frame = #self.anims[self.currentanim]
				end
			else
				if self.frame > #self.anims[self.currentanim] then
					self.frame = 1
				end
			end
			self.bitmap:setTextureRegion(self.anims[self.currentanim][self.frame])
		end
	end
end

-- keys listeners
function LF_Dynamic_Character:onKeyDown(e)
	-- ghosting
	if e.keyCode == KeyCode.LEFT then self.isleft = true end
	if e.keyCode == KeyCode.RIGHT then self.isright = true end
	if e.keyCode == KeyCode.UP then self.isup = true end
	if e.keyCode == KeyCode.DOWN then self.isdown = true end
	if e.keyCode == KeyCode.SPACE then self.isspace = true end

	if e.keyCode == KeyCode.J then self.isleft = true end
	if e.keyCode == KeyCode.L then self.isright = true end
	if e.keyCode == KeyCode.I then self.isup = true end
	if e.keyCode == KeyCode.K then self.isdown = true end
	if e.keyCode == KeyCode.W then self.isspace = true end
end

function LF_Dynamic_Character:onKeyUp(e)
	-- ghosting
	if e.keyCode == KeyCode.LEFT then self.isleft = false end
	if e.keyCode == KeyCode.RIGHT then self.isright = false end
	if e.keyCode == KeyCode.UP then self.isup = false if self.body then self.body.canjump = true end end
	if e.keyCode == KeyCode.DOWN then self.isdown = false end
	if e.keyCode == KeyCode.SPACE then self.isspace = false end

	if e.keyCode == KeyCode.J then self.isleft = false end
	if e.keyCode == KeyCode.L then self.isright = false end
	if e.keyCode == KeyCode.I then self.isup = false if self.body then self.body.canjump = true end end
	if e.keyCode == KeyCode.K then self.isdown = false end
	if e.keyCode == KeyCode.W then self.isspace = false end
end
