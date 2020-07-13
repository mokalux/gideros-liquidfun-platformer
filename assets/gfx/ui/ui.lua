UI = Core.class(Sprite)

function UI:init(xparams)
	local xparams = xparams or {}
	local params = xparams or {}
	params.pixelcolorup = xparams.pixelcolorup or 0x0
	params.pixelcolordown = xparams.pixelcolordown or 0xffffff
	params.textcolorup = xparams.textcolorup or 0xffffff
	params.textcolordown = xparams.textcolordown or 0x0
	-- the ui
	self.playerlivestf = TextFieldX.new(nil, "LIVES: "..3, 3, 3) -- magik
	self.playerlivestf:setPosition(4, myapptop + self.playerlivestf:getHeight() + 8)
	self:addChild(self.playerlivestf)
	self.playercointf = TextFieldX.new(nil, "COINS: "..0, 3, 3) -- magik
	self.playercointf:setPosition(4 + self.playerlivestf:getWidth() + 64, myapptop + self.playercointf:getHeight() + 8)
	self:addChild(self.playercointf)
	-- quit button
	local mybtnquit = ButtonTextBasic.new({
		pixelcolorup=params.pixelcolorup, pixelcolordown=params.pixelcolordown,
		text="X", font=g_font1, fontsize=32,
		textcolorup=params.textcolorup, textcolordown=params.textcolordown,
	})
	mybtnquit:setPosition(myappright - mybtnquit:getWidth() / 2, myapptop + mybtnquit:getHeight() / 2)
	self:addChild(mybtnquit)
	mybtnquit:addEventListener("clicked", function() self:goMenu() end)
end

function UI:goMenu()
	scenemanager:changeScene("menu", 1)
end
