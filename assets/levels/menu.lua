Menu = Core.class(Sprite)

function Menu:init()
	-- THEME
	local colortheme01 = {0x0, 0xffffff, 0xF2B705, 0xF29F05, 0xBF3604, 0x591E08, 0x0D0D0D}
	local colortheme02 = {0x0, 0xffffff, 0x6085A6, 0xF2B66D, 0xF26D3D, 0x401309, 0xA63921} -- Sunrise over the planet Earth concept with a bright sun and flare and city lights panoramic
	local colortheme03 = {0x0, 0xffffff, 0xFFB6A8, 0xE89A99, 0xFFB5D8, 0xE899E5, 0xE9A8FF}
	local colortheme04 = {0x0, 0xffffff, 0x114CA8, 0x2F4A75, 0x00C9DB, 0xE06538, 0xA82411}
	self.colortheme = colortheme02 -- choose color theme here (mostly for ui buttons)
	-- BG
	application:setBackgroundColor(self.colortheme[3])
	local mybgbmp = Bitmap.new(Texture.new("gfx/bgs/bg_space_orangeV2d.png"))
	mybgbmp:setAnchorPoint(0.5, 0.5)
	mybgbmp:setScale(1.5)
	mybgbmp:setPosition(myappwidth / 2, myappheight / 2)
	self:addChild(mybgbmp)
	-- TITLE
	local myfont = TTFont.new(g_font1, 44, "")
	local myfonto = TTFont.new(g_font1, 44, "", true, 1)
	local cf = CompositeFont.new{
		{font=myfonto, color=0x0, x=2, y=3},
		{font=myfont},
	}
	local mytitle = TextField.new(cf, "GIDEROS\n LF PLATFORMER")
	mytitle:setAnchorPoint(0.5, 0.5)
	mytitle:setPosition(myappwidth / 2, 2.75 * myappheight / 10 + myapptop)
	mytitle:setTextColor(self.colortheme[4])
	mytitle:setRotation(-5)
	self:addChild(mytitle)
	-- BUTTONS THEME
	local mypixelcolorup = self.colortheme[4]
	local mypixelcolordown = self.colortheme[5]
	local mytextcolorup = self.colortheme[5]
	local mytextcolordown = self.colortheme[6]
	local mytextcolordisabled = self.colortheme[7]
	-- BUTTON 1
	local mybtn01 = ButtonTextP9UDDT.new({
		text=" START  ", font=g_font1, fontsize=52, textcolorup=mytextcolorup, textcolordown=mytextcolordown,
		pixelcolorup=mypixelcolorup, pixelcolordown=mypixelcolordown,
		tooltiptext="you mad?",
	})
	mybtn01:setPosition(6.5 * myappwidth / 10, 5.5 * myappheight / 10 + myapptop)
	self:addChild(mybtn01)
	mybtn01:addEventListener("clicked", function() self:goNext() end)
	-- BUTTON 2
	local mybtn02 = ButtonTextP9UDDT.new({
		pixelcolorup=mypixelcolorup,
		text="OPTIONS", font=g_font1, fontsize=32, textcolorup=mytextcolorup, textcolordown=mytextcolordown,
	})
	mybtn02:setPosition(2 * myappwidth / 10, 7.5 * myappheight / 10 + myapptop)
	self:addChild(mybtn02)
	mybtn02:addEventListener("clicked", function() self:goNext() end)
	mybtn02:setDisabled(true)
	-- BUTTON QUIT
	local mybtnquit = ButtonTextP9UDDT.new({
		imgup="gfx/ui/btn_01_up.png", imgdown="gfx/ui/btn_01_down.png",imgdisabled="gfx/ui/btn_01_disabled.png",
		text="QUIT", font=g_font1, fontsize=32, textcolorup=mytextcolorup, textcolordown=mytextcolordown,
		tooltiptext="QUIT?",
	})
	mybtnquit:setPosition(2 * myappwidth / 10, 8.75 * myappheight / 10 + myapptop)
	self:addChild(mybtnquit)
	mybtnquit:addEventListener("clicked", function() self:goExit() end)
	mybtnquit:setDisabled(true)
	-- mokalux
	local myfont = TTFont.new(g_font1, 24)
	local mokalux = TextField.new(myfont, "(c)mokalux 2020 ")
	mokalux:setTextColor(0xffffff)
	mokalux:setPosition(myappwidth - mokalux:getWidth(), myappheight + myapptop)
	self:addChild(mokalux)
	-- LISTENERS
	self:addEventListener("enterBegin", self.onTransitionInBegin, self)
	self:addEventListener("enterEnd", self.onTransitionInEnd, self)
	self:addEventListener("exitBegin", self.onTransitionOutBegin, self)
	self:addEventListener("exitEnd", self.onTransitionOutEnd, self)
end

-- GAME LOOP
function Menu:onEnterFrame(e)
end

-- EVENT LISTENERS
function Menu:onTransitionInBegin()
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

function Menu:onTransitionInEnd()
	self:myKeysPressed()
end

function Menu:onTransitionOutBegin()
--	self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:removeAllListeners()
end

function Menu:onTransitionOutEnd()
end

-- KEYS HANDLER
function Menu:myKeysPressed()
	self:addEventListener(Event.KEY_DOWN, function(e)
		if e.keyCode == KeyCode.ENTER then self:goNext() end
	end)
	self:addEventListener(Event.KEY_UP, function(e)
		if e.keyCode == KeyCode.BACK or e.keyCode == KeyCode.ESC then self:goExit() end
	end)
end

function Menu:goNext()
--	scenemanager:changeScene("introX", 2)
	-- passing the color theme over to the intro class
	scenemanager:changeScene("introX", 2, nil, nil, {userData = self.colortheme})
end

function Menu:goExit()
	application:exit()
end
