BG = Core.class(Sprite)

function BG:init(xcolor01, xcolor02, xcolor03, xcolor04, xbgtex, xsteps)
	if xcolor02 then -- gradient BG
		local bg = Pixel.new(0xffffff, 1, myappwidth * 1.5, myappheight * 1.5)
		bg:setAnchorPoint(0.5, 0.5)
		bg:setScale(1.5)
		bg:setPosition(myappwidth / 2, myappheight / 2)
--		bg:setColor(xcolor01, 1, xcolor02, 1, 90)
		bg:setColor(xcolor01, 1, xcolor02, 1, xcolor03, 1, xcolor04, 1)
		self:addChild(bg)
	elseif xcolor01 then
		application:setBackgroundColor(xcolor)
	end
	if xbgtex then
		local tex = Texture.new(xbgtex, false, {wrap = TextureBase.REPEAT})
		self.bg = Pixel.new(tex)
		self.bg:setAnchorPoint(0.5, 0.5)
		self.bg:setScale(1.5)
		self.bg:setPosition(myappwidth / 2, myappheight / 2)
		self:addChild(self.bg)
		if xsteps then -- scrolling bg
			self.timer = 0
			self.steps = xsteps
			-- listenners
			self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
		end
	end
end

function BG:onEnterFrame(e)
	self.timer += self.steps * e.deltaTime
	self.bg:setTexturePosition(self.timer, 0)
end
