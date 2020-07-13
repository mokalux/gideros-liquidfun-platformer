LF_Particles = Core.class(Sprite)

function LF_Particles:init(xworld, xcamera, xparams)
	local params = xparams or {}
	params.x = xparams.x or 0
	params.y = xparams.y or 0
	params.coords = xparams.coords or nil
	params.width = xparams.width or 32
	params.height = xparams.height or 32
	params.tex = xparams.tex or nil
	params.radius = xparams.radius or 6
	-- calculate polygon width and height
	if params.coords then
		local minx, maxx, miny, maxy = 0, 0, 0, 0
		for k, v in pairs(params.coords) do
			if v.x < minx then minx = v.x end
			if v.y < miny then miny = v.y end
			if v.x > maxx then maxx = v.x end
			if v.y > maxy then maxy = v.y end
		end
		params.width, params.height = maxx - minx, maxy - miny -- the polygon dimensions
	end
	-- particles
	local ps = xworld:createParticleSystem( { radius = params.radius } )
	if params.tex then ps:setTexture(Texture.new(params.tex)) end
	local shape = b2.PolygonShape.new()
	shape:setAsBox(params.width / 2, params.height / 2)
	ps:createParticleGroup( {
		shape = shape,
		position = { x = params.x, y = params.y},
		color = 0xffffff, alpha=0.05,
		flags=b2.ParticleSystem.FLAG_POWDER,
	} )
	xcamera:addChild(ps)
end
