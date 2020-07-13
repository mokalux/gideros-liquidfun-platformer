TextFieldX = Core.class(Sprite)

function TextFieldX:init(xfont, xtext, xscalex, xscaley)
	self.tf = TextField.new(xfont, xtext)
	self.tf:setScale(xscalex or 1, xscaley or 1)
	self.tf:setTextColor(0xffffff)
	self:addChild(self.tf)
end

function TextFieldX:setText(xtext)
	self.tf:setText(xtext)
end
