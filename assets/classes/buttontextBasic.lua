--[[
ButtonTextBasic
A simple Button class with a Pixel and/or text. Ideal for in game action.
This code is CC0
github: mokalux
v 0.1.1: 2020-06-08 remove useless variables
v 0.1.0: 2020-04-02 init (based on the initial gideros generic button class)
]]
--[[
-- SAMPLES
	local mybtnquit = ButtonTextBasic.new({
		pixelcolorup=mypixelcolorup,
		text="X", font=g_font1, fontsize=32, textcolorup=mytextcolorup, textcolordown=mytextcolordown,
	})
	mybtnquit:setPosition(myappright - mybtnquit:getWidth() / 2, myapptop + mybtnquit:getHeight() / 2)
	self:addChild(mybtnquit)
	mybtnquit:addEventListener("clicked", function() self:goMenu() end)
]]
ButtonTextBasic = Core.class(Sprite)

function ButtonTextBasic:init(xparams)
	-- the params
	self.params = xparams or {}
	-- pixel?
	self.params.pixelcolorup = xparams.pixelcolorup or nil -- color
	self.params.pixelcolordown = xparams.pixelcolordown or self.params.pixelcolorup -- color
	self.params.pixelalpha = xparams.pixelalpha or 1 -- number
	self.params.pixelscalex = xparams.pixelscalex or 1 -- number
	self.params.pixelscaley = xparams.pixelscaley or 1 -- number
	self.params.pixelpaddingx = xparams.pixelpaddingx or 12 -- number
	self.params.pixelpaddingy = xparams.pixelpaddingy or 12 -- number
	-- text?
	self.params.text = xparams.text or nil -- string
	self.params.font = xparams.font or nil -- ttf font path
	self.params.fontsize = xparams.fontsize or 16 -- number
	self.params.textcolorup = xparams.textcolorup or 0x0 -- color
	self.params.textcolordown = xparams.textcolordown or self.params.textcolorup -- color
	self.params.textscalex = xparams.textscalex or 1 -- number
	self.params.textscaley = xparams.textscaley or self.params.textscalex -- number
	-- EXTRAS
	self.params.isautoscale = xparams.isautoscale or 1 -- number (default 1 = true)
	self.params.defaultpadding = xparams.defaultpadding or 12 -- number
	-- LET'S GO!
	if self.params.isautoscale == 0 then self.params.isautoscale = false else self.params.isautoscale = true end
	-- warnings
	if not self.params.pixelcolorup and not self.params.text then
		print("*** WARNING: YOUR BUTTON IS EMPTY! ***")
	else
		-- mouse catcher
		self.catcher = Pixel.new(0x0, 0, 1, 1)
		self:addChild(self.catcher)
		-- sprite holder
		self.sprite = Sprite.new()
		self:addChild(self.sprite)
		self:setButton()
	end
	-- update visual state
	self.focus = false
	self:updateVisualState(false)
	-- event listeners
	self:addEventListener(Event.MOUSE_DOWN, self.onMouseDown, self)
	self:addEventListener(Event.MOUSE_MOVE, self.onMouseMove, self)
	self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)
end

-- FUNCTIONS
function ButtonTextBasic:setButton()
	-- text
	local textwidth, textheight
	if self.params.text then
		local font
		if self.params.font ~= nil then
	--		font = TTFont.new(self.params.font, self.params.fontsize, "", true, 1) -- filtering, outline (number)
			font = TTFont.new(self.params.font, self.params.fontsize, "")
		end
		if self.text ~= nil then
			self.text:setButton(self.params.text)
		else
			self.text = TextField.new(font, self.params.text, self.params.text)
		end
		self.text:setAnchorPoint(0.5, 0.5)
		self.text:setScale(self.params.textscalex, self.params.textscaley)
		self.text:setTextColor(self.params.textcolorup)
		textwidth, textheight = self.text:getWidth(), self.text:getHeight()
	end
	-- first add pixel
	if self.params.pixelcolorup then
		if self.params.isautoscale and self.params.text then
			self.pixel = Pixel.new(
				self.params.pixelcolor, self.params.pixelalpha,
				textwidth + self.params.pixelpaddingx,
				textheight + self.params.pixelpaddingy)
		else
			self.pixel = Pixel.new(
				self.params.pixelcolor, self.params.pixelalpha,
				self.params.pixelpaddingx,
				self.params.pixelpaddingy)
		end
		self.pixel:setAnchorPoint(0.5, 0.5)
		self.pixel:setScale(self.params.pixelscalex, self.params.pixelscaley)
		self.sprite:addChild(self.pixel)
	end
	-- finally add text on top of all
	if self.params.text then self.sprite:addChild(self.text) end
	-- mouse catcher
	self.catcher:setDimensions(self.sprite:getWidth() + 8 * 2.5, self.sprite:getHeight() + 8 * 2.5) -- magik
	self.catcher:setAnchorPoint(0.5, 0.5)
end

-- VISUAL STATE
function ButtonTextBasic:updateVisualState(xstate)
	if xstate then -- button down state
		if self.params.pixelcolorup ~= nil then self.pixel:setColor(self.params.pixelcolordown) end
		if self.params.text ~= nil then self.text:setTextColor(self.params.textcolordown) end
	else -- button up state
		if self.params.pixelcolorup ~= nil then self.pixel:setColor(self.params.pixelcolorup) end
		if self.params.text ~= nil then self.text:setTextColor(self.params.textcolorup) end
	end
end

-- MOUSE LISTENERS
function ButtonTextBasic:onMouseDown(e)
	if self:hitTestPoint(e.x, e.y) then
		self.focus = true
		self:updateVisualState(true)
		e:stopPropagation()
	end
end
function ButtonTextBasic:onMouseMove(e)
	if self:hitTestPoint(e.x, e.y) then
		self.focus = true
		e:stopPropagation()
	else
		self.focus = false
--		e:stopPropagation() -- you may want to delete this line
	end
	self:updateVisualState(self.focus)
end
function ButtonTextBasic:onMouseUp(e)
	if self.focus then
		self.focus = false
		self:dispatchEvent(Event.new("clicked")) -- button is clicked, dispatch "clicked" event
		e:stopPropagation()
	end
end
