LevelX = Core.class(Sprite)

function LevelX:init()
	-- setup (bg, audio, ...)
	if g_currentlevel == 1 then
		self:addChild(BG.new(0x2E6EA6, 0x9BDAF2, 0x2E6EA6, 0x9BDAF2))
--		local ambientsound = Sound.new("audio/amb_waterfall.ogg")
--		self.channel = ambientsound:play(0, true)
	elseif g_currentlevel == 2 then
		self:addChild(BG.new(0xFF7303, 0x2D0BB3, 0xFF7303, 0x2D0BB3))
--		local ambientsound = Sound.new("audio/amb_waterfall.ogg")
--		self.channel = ambientsound:play(0, true)
	elseif g_currentlevel == 3 then
		self:addChild(BG.new(0x9BF2EA, 0x9BF2EA, 0x6C4ED9, 0x6C4ED9))
--		local ambientsound = Sound.new("audio/amb_waterfall.ogg")
--		self.channel = ambientsound:play(0, true)
	else
		self:addChild(BG.new(0x0, 0x0, 0x0, 0x0))
	end
	-- liquidfun
	self.world = b2.World.new(0, 48, true) -- gravity x, gravity y, doSleep?
	self.world.nmes = {}
	self.world.coins = {}
	-- let's go!
	self.counter = 0 -- AI
	self.tiled_level = Tiled_Levels.new(self.world, tiled_levels[g_currentlevel]) -- THE CORE
	self.ui = UI.new()
	self:addChild(self.tiled_level)
	self:addChild(self.ui)
--[[
	-- debug
	local debugdraw = b2.DebugDraw.new()
	debugdraw:setFlags(b2.DebugDraw.SHAPE_BIT + b2.DebugDraw.JOINT_BIT + b2.DebugDraw.PAIR_BIT)
	self.world:setDebugDraw(debugdraw)
	self.tiled_level.camera:addChild(debugdraw)
	self.world.isdebug = true -- sprite alpha to 0.5 for better visiblity
]]
	-- mobile controls
--	if application:getDeviceInfo() == "Android" or application:getDeviceInfo() == "Web" then
	if application:getDeviceInfo() == "Android" then
		self.mobile = MobileX.new(self.tiled_level.player)
		self.ui:addChild(self.mobile)
	end
	-- ui
	self.ui.playerlivestf:setText("LIVES: "..self.tiled_level.player.body.lives)
	self.ui.playercointf:setText("COINS: "..#self.world.coins)
	-- camera setup
	self.cam_zoom_out = 1
	self.cam_zoom_default = 1.25
	self.cam_zoom_in = 1.5
	if g_currentlevel == 1 then
		self.cam_zoom_out = 1 self.cam_zoom_default = 1.5 self.cam_zoom_in = 2
	elseif g_currentlevel == 2 then
	elseif g_currentlevel == 3 then
	end
	self.cam_zoom_to = self.cam_zoom_default
	self.cameraspeed = 8*2
	self.tiled_level.camera:setScale(self.cam_zoom_to)
	self.posx, self.posy = self.tiled_level.player.body:getWorldCenter()
	self.tiled_level.camera:setAnchorPosition(
		self.posx - myappwidth / 4, self.posy - (myappheight / 2 / self.tiled_level.camera:getScale()))
	-- listeners
	self:addEventListener("enterBegin", self.onTransitionInBegin, self)
	self:addEventListener("enterEnd", self.onTransitionInEnd, self)
	self:addEventListener("exitBegin", self.onTransitionOutBegin, self)
	self:addEventListener("exitEnd", self.onTransitionOutEnd, self)
	self.world:addEventListener(Event.BEGIN_CONTACT, self.onBeginContact, self)
	self.world:addEventListener(Event.END_CONTACT, self.onEndContact, self)
	self.world:addEventListener(Event.PRE_SOLVE, self.onPreSolveContact, self)
	self.world:addEventListener(Event.POST_SOLVE, self.onPostSolveContact, self)
end

-- GAME LOOP
function LevelX:onEnterFrame(e)
	self.counter += 1 -- for AI
	-- liquidfun step
	self.world:step(e.deltaTime, 4, 2) -- 4,2 8,3 1,1
	-- nme AI
	for k, v in pairs(self.world.nmes) do
		if v and v.issensor and not v.isdead then
			local x, y = self.tiled_level.player.body:getPosition()
			local x1, y1 = v:getPosition()
			if x1 > x + 64 then
				k.isleft = true k.isright = false
			elseif x1 < x - 64 then
				k.isright = true k.isleft = false
			end
			if y1 > y + 24 then -- magik XXX
				k.isup = true k.isdown = false
			elseif y1 < y - 24 then -- magik XXX
				k.isdown = true k.isup = false
			end
			if self.counter % (1 * 60) == 0 then k.isspace = true end
		elseif v ~= nil and not v.issensor then -- idle? or choose an up/down movement?
			k.isleft = false k.isright = false k.isup = false k.isdown = false k.isspace = false
		end
	end
	-- npc ai
	if self.tiled_level.npc01 then
		if self.counter % (2 * 60) == 0 then self.tiled_level.npc01.isright = true self.tiled_level.npc01.isleft = false end
		if self.counter % (4 * 60) == 0 then self.tiled_level.npc01.isright = false self.tiled_level.npc01.isleft = true end
	end
	-- camera zoom
	if self.tiled_level.player.body.camzoomtrigger then
		self:setCamZoom(self.cam_zoom_to, self.cameraspeed * 2)
		self.tiled_level.player.body.camzoomtrigger = false
	end
	-- camera follow
	self.posx, self.posy = self.tiled_level.player.body:getWorldCenter()
	_, self.camanchory = self.tiled_level.camera:getAnchorPosition()
	self.tiled_level.camera:setAnchorPosition(
		self.posx - myappwidth / 4, self.cam_posy_current - (myappheight / 2 / self.tiled_level.camera:getScale()))
	self:setCamPosY(
		self.camanchory, self.cam_posy_current - (myappheight / 2 / self.tiled_level.camera:getScale()) , self.cameraspeed * 3)
	-- the ui
	if self.tiled_level.player.body.isdirty then
		self.ui.playerlivestf:setText("LIVES: "..self.tiled_level.player.body.lives)
	end
end

-- camera functions
function LevelX:setCamPosY(currenty, targety, duration)
	local movieclip = MovieClip.new{
		{1, duration, self.tiled_level.camera,
			{
				anchorY = {currenty, targety, "outBack"},
--				anchorY = {currenty, targety, "linear"},
			}
		}
	}
end

function LevelX:setCamZoom(targetzoom, duration)
	local movieclip = MovieClip.new{
		{1, duration, self.tiled_level.camera,
			{
--				scale = {self.tiled_level.camera:getScale(), targetzoom, "outBack"},
				scale = {self.tiled_level.camera:getScale(), targetzoom, "linear"},
			}
		}
	}
end

-- collisions handler
function LevelX:onBeginContact(e)
	local fixtureA, fixtureB = e.fixtureA, e.fixtureB
	local bodyA = e.fixtureA:getBody()
	local bodyB = e.fixtureB:getBody()
	-- PLAYER
	if (bodyA.type == G_PLAYER and bodyB.type == G_GROUND) or (bodyA.type == G_GROUND and bodyB.type == G_PLAYER) then
		if bodyA.type == G_PLAYER then bodyA.numfloorcontacts += 1
		else bodyB.numfloorcontacts += 1
		end
	elseif (bodyA.type == G_PLAYER and bodyB.type == G_MPLATFORM) or (bodyA.type == G_MPLATFORM and bodyB.type == G_PLAYER) then
		if bodyA.type == G_PLAYER then bodyA.nummpfcontacts += 1
		else bodyB.nummpfcontacts += 1
		end
	elseif (bodyA.type == G_PLAYER and bodyB.type == G_PTPLATFORM) or (bodyA.type == G_PTPLATFORM and bodyB.type == G_PLAYER) then
		if bodyA.type == G_PLAYER then bodyA.numptpfcontacts += 1 bodyA.isgoingdownplatform = false
		else bodyB.numptpfcontacts += 1 bodyB.isgoingdownplatform = false
		end
	elseif (bodyA.type == G_PLAYER and bodyB.type == G_LADDER) or (bodyA.type == G_LADDER and bodyB.type == G_PLAYER) then
		if bodyA.type == G_PLAYER then bodyA.numladdercontacts += 1
		else bodyB.numladdercontacts += 1
		end
	elseif (bodyA.type == G_PLAYER and bodyB.type == G_COIN) or (bodyA.type == G_COIN and bodyB.type == G_PLAYER) then
		if bodyA.type == G_COIN then bodyA.isdirty = true
		else bodyB.isdirty = true
		end
		self.ui.playercointf:setText("COINS: "..#self.world.coins - 1)
	elseif (bodyA.type == G_PLAYER and bodyB.type == G_EXIT) or (bodyA.type == G_EXIT and bodyB.type == G_PLAYER) then
		if bodyA.type == G_PLAYER then bodyB.isdirty = true
		else bodyA.isdirty = true
		end
	elseif (bodyA.type == G_PLAYER and bodyB.type == G_DEAD) or (bodyA.type == G_DEAD and bodyB.type == G_PLAYER) then
		if bodyA.type == G_PLAYER then bodyA.isdead = true
		else bodyB.isdead = true
		end
	end
	-- CAMERA
	if (bodyA.type == G_PLAYER and bodyB.type == G_CAM_POS) or (bodyA.type == G_CAM_POS and bodyB.type == G_PLAYER) then
		if bodyA.type == G_CAM_POS then _, self.cam_posy_current = bodyA:getWorldCenter() -- cam tiled position
		else _, self.cam_posy_current = bodyB:getWorldCenter() -- cam tiled position
		end
	elseif (bodyA.type == G_PLAYER and bodyB.type == G_CAM_ZOOMX05) or (bodyA.type == G_CAM_ZOOMX05 and bodyB.type == G_PLAYER) then
		if bodyA.type == G_CAM_ZOOMX05 then bodyB.camzoomtrigger = true
		else bodyA.camzoomtrigger = true
		end
		self.cam_zoom_to = self.cam_zoom_out
	elseif (bodyA.type == G_PLAYER and bodyB.type == G_CAM_ZOOMX1) or (bodyA.type == G_CAM_ZOOMX1 and bodyB.type == G_PLAYER) then
		if bodyA.type == G_CAM_ZOOMX1 then bodyB.camzoomtrigger = true
		else bodyA.camzoomtrigger = true
		end
		self.cam_zoom_to = self.cam_zoom_default
	elseif (bodyA.type == G_PLAYER and bodyB.type == G_CAM_ZOOMX2) or (bodyA.type == G_CAM_ZOOMX2 and bodyB.type == G_PLAYER) then
		if bodyA.type == G_CAM_ZOOMX2 then bodyB.camzoomtrigger = true
		else bodyA.camzoomtrigger = true
		end
		self.cam_zoom_to = self.cam_zoom_in
	end
	-- BUMPS
	if bodyA.type == G_BUMP_YP4 or bodyB.type == G_BUMP_YP4 or bodyA.type == G_BUMP_YP5 or bodyB.type == G_BUMP_YP5 then
		if (bodyA.type == G_PLAYER and bodyB.type == G_BUMP_YP4) or (bodyA.type == G_BUMP_YP4 and bodyB.type == G_PLAYER) then
			if bodyA.type == G_PLAYER then bodyA:setLinearVelocity(0, 0) bodyA:applyLinearImpulse(0, -64*16*4, bodyA:getWorldCenter())
			else bodyB:setLinearVelocity(0, 0) bodyB:applyLinearImpulse(0, -64*16*4, bodyA:getWorldCenter())
			end
		elseif (bodyA.type == G_PLAYER and bodyB.type == G_BUMP_YP5) or (bodyA.type == G_BUMP_YP5 and bodyB.type == G_PLAYER) then
			if bodyA.type == G_PLAYER then bodyA:setLinearVelocity(0, 0) bodyA:applyLinearImpulse(0, -64*16*5, bodyA:getWorldCenter())
			else bodyB:setLinearVelocity(0, 0) bodyB:applyLinearImpulse(0, -64*16*5, bodyA:getWorldCenter())
			end
		end
	end
	-- BULLETS
	if bodyA.type == G_PLAYER_BULLET or bodyB.type == G_PLAYER_BULLET or bodyA.type == G_ENEMY_BULLET or bodyB.type == G_ENEMY_BULLET then
		if (bodyA.type == G_PLAYER_BULLET and bodyB.type == G_ENEMY01) or (bodyA.type == G_ENEMY01 and bodyB.type == G_PLAYER_BULLET) then
			if bodyA.type == G_ENEMY01 then bodyA.isdirty = true
			else bodyB.isdirty = true
			end
		elseif (bodyA.type == G_ENEMY_BULLET and bodyB.type == G_PLAYER) or (bodyA.type == G_PLAYER and bodyB.type == G_ENEMY_BULLET) then
			if bodyA.type == G_PLAYER then bodyA.isdirty = true
			else bodyB.isdirty = true
			end
		end
		if bodyA.type == G_PLAYER_BULLET or bodyB.type == G_PLAYER_BULLET or bodyA.type == G_ENEMY_BULLET or bodyB.type == G_ENEMY_BULLET then
			if bodyA.type == G_MPLATFORM then bodyB.isdirty = true -- add kinematics body exceptions here
			elseif bodyB.type == G_MPLATFORM then bodyA.isdirty = true -- and here (otherwise they get bullet destroyed!)
			else bodyA.isdirty = true bodyB.isdirty = true
			end
		end
	end
	-- NME
	if bodyA.type == G_ENEMY01 or bodyB.type == G_ENEMY01 then
		if (bodyA.type == G_ENEMY01 and bodyB.type == G_GROUND) or (bodyA.type == G_GROUND and bodyB.type == G_ENEMY01) then
			if bodyA.type == G_ENEMY01 then bodyA.numfloorcontacts += 1
			else bodyB.numfloorcontacts += 1
			end
		elseif (bodyA.type == G_ENEMY01 and bodyB.type == G_MPLATFORM) or (bodyA.type == G_MPLATFORM and bodyB.type == G_ENEMY01) then
			if bodyA.type == G_ENEMY01 then bodyA.nummpfcontacts += 1
			else bodyB.nummpfcontacts += 1
			end
		elseif (bodyA.type == G_ENEMY01 and bodyB.type == G_PTPLATFORM) or (bodyA.type == G_PTPLATFORM and bodyB.type == G_ENEMY01) then
			if bodyA.type == G_ENEMY01 then bodyA.numptpfcontacts += 1
			else bodyB.numptpfcontacts += 1
			end
		elseif (bodyA.type == G_ENEMY01 and bodyB.type == G_LADDER) or (bodyA.type == G_LADDER and bodyB.type == G_ENEMY01) then
			if bodyA.type == G_ENEMY01 then bodyA.numladdercontacts += 1
			else bodyB.numladdercontacts += 1
			end
		elseif (bodyA.type == G_ENEMY01 and bodyB.type == G_PLAYER) or (bodyA.type == G_PLAYER and bodyB.type == G_ENEMY01) then
			if bodyA.type == G_ENEMY01 then
				bodyA:setSleepingAllowed(false) bodyA.issensor = true
				if not fixtureA:isSensor() and not fixtureB:isSensor() then
					local _, vy = bodyB:getLinearVelocity()
					if vy > 8 then bodyA.isdirty = true bodyB.isonnme = true -- magik XXX
					else bodyB.isdirty = true end
				end
			else
				bodyB:setSleepingAllowed(false) bodyB.issensor = true
				if not fixtureB:isSensor() and not fixtureA:isSensor() then
					local _, vy = bodyA:getLinearVelocity()
					if vy > 8 then bodyB.isdirty = true bodyA.isonnme = true -- magik XXX
					else bodyA.isdirty = true end
				end
			end
		end
	end
	-- NPC
	if bodyA.type == G_NPC01 or bodyB.type == G_NPC01 then
		if (bodyA.type == G_NPC01 and bodyB.type == G_GROUND) or (bodyA.type == G_GROUND and bodyB.type == G_NPC01) then
			if bodyA.type == G_NPC01 then bodyA.numfloorcontacts += 1
			else bodyB.numfloorcontacts += 1
			end
		elseif (bodyA.type == G_NPC01 and bodyB.type == G_MPLATFORM) or (bodyA.type == G_MPLATFORM and bodyB.type == G_NPC01) then
			if bodyA.type == G_NPC01 then bodyA.nummpfcontacts += 1
			else bodyB.nummpfcontacts += 1
			end
		elseif (bodyA.type == G_NPC01 and bodyB.type == G_PTPLATFORM) or (bodyA.type == G_PTPLATFORM and bodyB.type == G_NPC01) then
			if bodyA.type == G_NPC01 then bodyA.numptpfcontacts += 1
			else bodyB.numptpfcontacts += 1
			end
		elseif (bodyA.type == G_NPC01 and bodyB.type == G_LADDER) or (bodyA.type == G_LADDER and bodyB.type == G_NPC01) then
			if bodyA.type == G_NPC01 then bodyA.numladdercontacts += 1
			else bodyB.numladdercontacts += 1
			end
		end
	end
end

function LevelX:onEndContact(e)
	local bodyA = e.fixtureA:getBody()
	local bodyB = e.fixtureB:getBody()
	-- PLAYER
	if (bodyA.type == G_PLAYER and bodyB.type == G_GROUND) or (bodyA.type == G_GROUND and bodyB.type == G_PLAYER) then
		if bodyA.type == G_PLAYER then bodyA.numfloorcontacts -= 1
		else bodyB.numfloorcontacts -= 1
		end
	elseif (bodyA.type == G_PLAYER and bodyB.type == G_MPLATFORM) or (bodyA.type == G_MPLATFORM and bodyB.type == G_PLAYER) then
		if bodyA.type == G_PLAYER then bodyA.nummpfcontacts -= 1
		else bodyB.nummpfcontacts -= 1
		end
	elseif (bodyA.type == G_PLAYER and bodyB.type == G_PTPLATFORM) or (bodyA.type == G_PTPLATFORM and bodyB.type == G_PLAYER) then
		if bodyA.type == G_PLAYER then bodyA.numptpfcontacts -= 1
		else bodyB.numptpfcontacts -= 1
		end
		if self.tiled_level.player.body.wasonptpf then -- XXX
			self.tiled_level.player.isdown = false
		end
	elseif (bodyA.type == G_PLAYER and bodyB.type == G_LADDER) or (bodyA.type == G_LADDER and bodyB.type == G_PLAYER) then
		if bodyA.type == G_PLAYER then
			local _, vy = bodyA:getLinearVelocity() -- new 200607
			bodyA.numladdercontacts -= 1
			if vy < -8 then bodyA.canjump = false end -- new 200607
			if bodyA.jumpoffladder then
				bodyA:applyLinearImpulse(64 * bodyA.flip, -64*16*1.5, bodyA:getWorldCenter())
				bodyA.jumpoffladder = false
			end
		else
			local _, vy = bodyB:getLinearVelocity() -- new 200607
			bodyB.numladdercontacts -= 1
			if vy < -8 then bodyB.canjump = false end -- new 200607
			if bodyB.jumpoffladder then
				bodyB:applyLinearImpulse(64 * bodyB.flip, -64*16*1.5, bodyB:getWorldCenter())
				bodyB.jumpoffladder = false
			end
		end
	end
	-- NME
	if (bodyA.type == G_ENEMY01 and bodyB.type == G_GROUND) or (bodyA.type == G_GROUND and bodyB.type == G_ENEMY01) then
		if bodyA.type == G_ENEMY01 then bodyA.numfloorcontacts -= 1
		else bodyB.numfloorcontacts -= 1
		end
	elseif (bodyA.type == G_ENEMY01 and bodyB.type == G_MPLATFORM) or (bodyA.type == G_MPLATFORM and bodyB.type == G_ENEMY01) then
		if bodyA.type == G_ENEMY01 then bodyA.nummpfcontacts -= 1
		else bodyB.nummpfcontacts -= 1
		end
	elseif (bodyA.type == G_ENEMY01 and bodyB.type == G_PTPLATFORM) or (bodyA.type == G_PTPLATFORM and bodyB.type == G_ENEMY01) then
		if bodyA.type == G_ENEMY01 then bodyA.numptpfcontacts -= 1
		else bodyB.numptpfcontacts -= 1
		end
	elseif (bodyA.type == G_ENEMY01 and bodyB.type == G_LADDER) or (bodyA.type == G_LADDER and bodyB.type == G_ENEMY01) then
		if bodyA.type == G_ENEMY01 then bodyA.numladdercontacts -= 1
		else bodyB.numladdercontacts -= 1
		end
	end
	if (bodyA.type == G_ENEMY01 and bodyB.type == G_PLAYER) or (bodyA.type == G_PLAYER and bodyB.type == G_ENEMY01) then
		if bodyA.type == G_ENEMY01 then bodyA:setSleepingAllowed(true) bodyB.isonnme = false
		else bodyB:setSleepingAllowed(true) bodyA.isonnme = false
		end
	end
	-- NPC
	if (bodyA.type == G_NPC01 and bodyB.type == G_GROUND) or (bodyA.type == G_GROUND and bodyB.type == G_NPC01) then
		if bodyA.type == G_NPC01 then bodyA.numfloorcontacts -= 1
		else bodyB.numfloorcontacts -= 1
		end
	elseif (bodyA.type == G_NPC01 and bodyB.type == G_MPLATFORM) or (bodyA.type == G_MPLATFORM and bodyB.type == G_NPC01) then
		if bodyA.type == G_NPC01 then bodyA.nummpfcontacts -= 1
		else bodyB.nummpfcontacts -= 1
		end
	elseif (bodyA.type == G_NPC01 and bodyB.type == G_PTPLATFORM) or (bodyA.type == G_PTPLATFORM and bodyB.type == G_NPC01) then
		if bodyA.type == G_NPC01 then bodyA.numptpfcontacts -= 1
		else bodyB.numptpfcontacts -= 1
		end
	elseif (bodyA.type == G_NPC01 and bodyB.type == G_LADDER) or (bodyA.type == G_LADDER and bodyB.type == G_NPC01) then
		if bodyA.type == G_NPC01 then bodyA.numladdercontacts -= 1
		else bodyB.numladdercontacts -= 1
		end
	end
end

function LevelX:onPreSolveContact(e)
	local bodyA = e.fixtureA:getBody()
	local bodyB = e.fixtureB:getBody()
	local platform, player
	if bodyA.type == G_PTPLATFORM then platform = bodyA player = bodyB
	else platform = bodyB player = bodyA
	end
	if not platform then return end
	-- PLAYER
	if player.isgoingdownplatform then
		e.contact:setEnabled(false)
		return
	end
	-- pass through platform
	local _, vy = player:getLinearVelocity()
	local _, posy = player:getPosition()
	local _, pospy = platform:getPosition()
	if vy < -1 then -- going up = no collision, -1 otherwise wiggles
		e.contact:setEnabled(false)
		if vy >= 0 then -- above then going down then collision
			e.contact:setEnabled(true)
		else
			player.isgoingdownplatform = true
			e.contact:setEnabled(false)
		end
	end
end

function LevelX:onPostSolveContact(e)
end

-- EVENT LISTENERS
function LevelX:onTransitionInBegin()
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

function LevelX:onTransitionInEnd()
--	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:myKeysPressed()
end

function LevelX:onTransitionOutBegin()
--	self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:removeAllListeners()
	if self.channel then self.channel:stop() end
end

function LevelX:onTransitionOutEnd()
end

-- KEYS HANDLER
function LevelX:myKeysPressed()
	self:addEventListener(Event.KEY_UP, function(e)
		if e.keyCode == KeyCode.BACK or e.keyCode == KeyCode.ESC then self:goMenu() end
	end)
end

function LevelX:goMenu()
	scenemanager:changeScene("menu", 1)
end
