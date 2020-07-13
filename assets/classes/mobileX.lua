-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX --
--[[
   v.3.1
   (c)Oleg Simonenko
	simartinfo.blogspot.com
	github.com/razorback456/gideros_tools
]]

ButtonOleg = gideros.class(Sprite)

function ButtonOleg:init(xtext, xcolor, xscalex, xscaley, xalpha)
	self.textalpha = xalpha or 0
	self.text = TextField.new(nil, xtext)
	self.text:setTextColor(xcolor or 0x0)
	self.text:setScale(xscalex, xscaley)
	self.text:setAlpha(self.textalpha)
	self:addChild(self.text)
	-- listeners
	self:addEventListener(Event.TOUCHES_BEGIN, self.onTouchesBegin, self)
	self:addEventListener(Event.TOUCHES_MOVE, self.onTouchesMove, self)
	self:addEventListener(Event.TOUCHES_END, self.onTouchesEnd, self)
end

function ButtonOleg:onTouchesBegin(e)
	if self:hitTestPoint(e.touch.x, e.touch.y) then
		self:dispatchEvent(Event.new("clickDown"))
--		if self.textalpha then self.text:setAlpha(self.textalpha + 0.2) end
	end
end

function ButtonOleg:onTouchesMove(e)
	if self:hitTestPoint(e.touch.x, e.touch.y) then
		local clickMove = Event.new("clickMove")
		self:dispatchEvent(clickMove)
--		if self.textalpha then self.text:setAlpha(self.textalpha + 0.2) end
	end
end

function ButtonOleg:onTouchesEnd(e)
	if self:hitTestPoint(e.touch.x, e.touch.y) then
		self:dispatchEvent(Event.new("clickUp"))
--		if self.textalpha then self.text:setAlpha(self.textalpha - 0.2) end
	end
end

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX --
MobileX = Core.class(Sprite)

function MobileX:init(xhero)
	-- local variables
	local scalex, scaley = 14,14
	local alpha = 0.15 -- 0.15
	-- left pad buttons
	local btnup = ButtonOleg.new("O", 0xffffff, scalex, scaley, alpha) -- UP (B)
	btnup:setPosition(8, myappbot - 1 * btnup:getHeight())
	self:addChild(btnup)
	local btndown = ButtonOleg.new("O", 0xffffff, scalex, scaley, alpha) -- DOWN (A)
	btndown:setPosition(8, myappbot)
	self:addChild(btndown)
	local btnX = ButtonOleg.new("X", 0xff0000, scalex, scaley, alpha) -- SPACE (X)
	btnX:setPosition(8 + btnX:getWidth(), myappbot - btnX:getHeight() / 2)
	self:addChild(btnX)
	-- buttons CANCELLER -- LEFT PAD
	local btnscanceller1 = ButtonOleg.new("O", 0xffffff, 96, 32, nil) -- nil
	btnscanceller1:setAnchorPoint(0.5, 0.5)
	btnscanceller1:setPosition(0, myappbot + 0.5 * btnscanceller1:getHeight())
	self:addChild(btnscanceller1)

	-- right pad buttons
	local btnleft = ButtonOleg.new("O", 0xffffff, scalex + 5, scaley + 3, alpha) -- LEFT
	btnleft:setPosition(myappright - 2 * btnleft:getWidth() - 8, myappbot)
	self:addChild(btnleft)
	local btnright = ButtonOleg.new("O", 0xffffff, scalex + 5, scaley + 3, alpha) -- RIGHT
	btnright:setPosition(myappright - btnright:getWidth() - 8, myappbot)
	self:addChild(btnright)
	-- buttons CANCELLER -- RIGHT PAD
	local btnscanceller2 = ButtonOleg.new("O", 0xffffff, 96, 32, nil) -- nil
	btnscanceller2:setAnchorPoint(0.5, 0.5)
	btnscanceller2:setPosition(myappright, myappbot + 0.5 * btnscanceller2:getHeight())
	self:addChild(btnscanceller2)

	-- listeners
	-- CANCELLERS
	btnscanceller1:addEventListener("clickMove", function(e) -- BUTTON CANCELLER 1
--		e:stopPropagation()
		xhero.isup = false
		xhero.isdown = false
		xhero.isspace = false
	end)
	btnscanceller2:addEventListener("clickMove", function(e) -- BUTTON CANCELLER 2
--		e:stopPropagation()
		xhero.isright = false
		xhero.isleft = false
	end)

	-- BUTTONS
	btnup:addEventListener("clickDown", function(e) -- UP O
		e:stopPropagation()
		xhero.isup = true
	end)
	btnup:addEventListener("clickMove", function(e)
		xhero.isup = true
--		xhero.isup = false
	end)
	btnup:addEventListener("clickUp", function(e)
		e:stopPropagation()
		xhero.isup = false
		xhero.body.canjump = true
	end)

	btndown:addEventListener("clickDown", function(e) -- DOWN O
		e:stopPropagation()
		xhero.isdown = true
	end)
	btndown:addEventListener("clickMove", function(e)
		xhero.isdown = true
--		xhero.isdown = false
	end)
	btndown:addEventListener("clickUp", function(e)
		e:stopPropagation()
		xhero.isdown = false
	end)

	btnX:addEventListener("clickDown", function(e) -- SPACE X
		e:stopPropagation()
		xhero.isspace = true
	end)
	btnX:addEventListener("clickMove", function(e)
--		xhero.isspace = true
		xhero.isspace = false
	end)
	btnX:addEventListener("clickUp", function(e)
		e:stopPropagation()
		xhero.isspace = false
	end)

	btnleft:addEventListener("clickDown", function(e) -- LEFT O
		e:stopPropagation()
		xhero.isleft = true
	end)
	btnleft:addEventListener("clickMove", function(e)
		xhero.isleft = true
	end)
	btnleft:addEventListener("clickUp", function(e)
		e:stopPropagation()
		xhero.isleft = false
	end)

	btnright:addEventListener("clickDown", function(e) -- RIGHT O
		e:stopPropagation()
		xhero.isright = true
	end)
	btnright:addEventListener("clickMove", function(e)
		xhero.isright = true
	end)
	btnright:addEventListener("clickUp", function(e)
		e:stopPropagation()
		xhero.isright = false
	end)
end
