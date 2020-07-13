IntroX = Core.class(Sprite)

function IntroX:init(xcolortheme)
	-- theme
	local colortheme = xcolortheme
	-- bg (animated, ...)
	self:addChild(BG.new(nil, nil, "gfx/bgs/bg_space_orangeV2d.png", 16))
	-- movie clip
	self.frames = {}
	self.totalframes = 30
	local tex
	for i = 1, self.totalframes do
		if i < 10 then tex = Texture.new("gfx/cutscenes/intro/mkgix01.000"..i..".png", false)
		elseif i < 100 then tex = Texture.new("gfx/cutscenes/intro/mkgix01.00"..i..".png", false)
		end
		self.frames[i] = tex
	end
	self.counter = 1
	self.bmp = Bitmap.new(self.frames[self.counter])
	self.bmp:setAnchorPoint(0.5, 0.5)
	self.bmp:setPosition(myappwidth / 2, myappheight / 2)
	self:addChild(self.bmp)
	-- BUTTONS THEME
	local mypixelcolorup = colortheme[4]
	local mypixelcolordown = colortheme[5]
	local mytextcolorup = colortheme[5]
	local mytextcolordown = colortheme[6]
	local mytextcolordisabled = colortheme[7]
	-- a button to continue
	local mybtn01 = ButtonTextP9UDDT.new({
		text=" CONTINUE  ", font=g_font1, fontsize=52, textcolorup=mytextcolorup, textcolordown=mytextcolordown,
		pixelcolorup=mypixelcolorup,
		tooltiptext="you really mad?",
	})
	mybtn01:setPosition(myappwidth / 2, 8 * myappheight / 10)
	self:addChild(mybtn01)
	mybtn01:addEventListener("clicked", function() self:goNext() end)
	-- listeners
	self:addEventListener("enterBegin", self.onTransitionInBegin, self)
	self:addEventListener("enterEnd", self.onTransitionInEnd, self)
	self:addEventListener("exitBegin", self.onTransitionOutBegin, self)
	self:addEventListener("exitEnd", self.onTransitionOutEnd, self)
end

-- GAME LOOP
function IntroX:onEnterFrame(e)
	self.counter += e.deltaTime * 24
	if self.counter > self.totalframes then self.counter = 1 end
	self.bmp:setTexture(self.frames[math.floor(self.counter)])
end

-- EVENT LISTENERS
function IntroX:onTransitionInBegin()
	self:myKeysPressed()
end

function IntroX:onTransitionInEnd()
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

function IntroX:onTransitionOutBegin()
--	self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:removeAllListeners()
end

function IntroX:onTransitionOutEnd()
end

-- KEYS HANDLER
function IntroX:myKeysPressed()
	self:addEventListener(Event.KEY_DOWN, function(e)
		if e.keyCode == KeyCode.BACK or e.keyCode == KeyCode.ESC then self:goMenu() end
	end)
	self:addEventListener(Event.KEY_UP, function(e)
		if e.keyCode == KeyCode.ENTER then self:goNext() end
	end)
end

function IntroX:goNext()
	scenemanager:changeScene("levelX", 3)
end

function IntroX:goMenu()
	scenemanager:changeScene("menu", 1)
end
