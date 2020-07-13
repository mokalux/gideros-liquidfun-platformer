Tiled_Levels = Core.class(Sprite)

function Tiled_Levels:init(xworld, xtiledlevel)
	self.camera = Sprite.new()
	self.bg = Sprite.new() -- bg deco
	self.mg = Sprite.new() -- mg level + sensors
	self.fg = Sprite.new() -- fg deco
	self.camera:addChild(self.bg)
	self.camera:addChild(self.mg)
	self.camera:addChild(self.fg)
	self:addChild(self.camera)
	-- functions to build the tiled levels shapes
	-- BG DECO LAYER
	local function tileddeco(xobject, xlevelsetup)
		local tablebase = {}
		if xobject.shape == "ellipse" then
			tablebase = {
				x = xobject.x, y = xobject.y,
				w = xobject.width, h = xobject.height, rotation = xobject.rotation,
				isdeco = true,
			}
			for k, v in pairs(xlevelsetup) do tablebase[k] = v end
			myshape = Tiled_LF_Ellipse.new(xworld, tablebase)
		elseif xobject.shape == "polygon" then
			tablebase = {
				x = xobject.x, y = xobject.y,
				coords = xobject.polygon, rotation = xobject.rotation,
				isdeco = true,
			}
			for k, v in pairs(xlevelsetup) do tablebase[k] = v end
			myshape = Tiled_LF_Polygon.new(xworld, tablebase)
		elseif xobject.shape == "rectangle" then
			tablebase = {
				x = xobject.x, y = xobject.y,
				w = xobject.width, h = xobject.height, rotation = xobject.rotation,
				isdeco = true,
			}
			for k, v in pairs(xlevelsetup) do tablebase[k] = v end
			myshape = Tiled_LF_Rectangle.new(xworld, tablebase)
		else
			print("*** CANNOT PROCESS THIS SHAPE! ***", xobject.shape, xobject.name)
			return
		end
		myshape:setPosition(xobject.x, xobject.y)
		self.bg:addChild(myshape)
	end
	-- MG LEVEL LAYER
	local function tiledlevel(xobject, xlevelsetup)
		local tablebase = {}
		if xobject.shape == "ellipse" then
			tablebase = {
				x = xobject.x, y = xobject.y,
				w = xobject.width, h = xobject.height, rotation = xobject.rotation,
			}
			for k, v in pairs(xlevelsetup) do tablebase[k] = v end
			myshape = Tiled_LF_Ellipse.new(xworld, tablebase)
		elseif xobject.shape == "polygon" then
			tablebase = {
				x = xobject.x, y = xobject.y,
				coords = xobject.polygon, rotation = xobject.rotation,
			}
			for k, v in pairs(xlevelsetup) do tablebase[k] = v end
			myshape = Tiled_LF_Polygon.new(xworld, tablebase)
		elseif xobject.shape == "rectangle" then
			tablebase = {
				x = xobject.x, y = xobject.y,
				w = xobject.width, h = xobject.height, rotation = xobject.rotation,
			}
			for k, v in pairs(xlevelsetup) do tablebase[k] = v end
			myshape = Tiled_LF_Rectangle.new(xworld, tablebase)
		else
			print("*** CANNOT PROCESS THIS SHAPE! ***", xobject.shape, xobject.name)
			return
		end
		myshape:setPosition(xobject.x, xobject.y)
		self.mg:addChild(myshape)
		-- lists
		if xobject.name == "coin" then xworld.coins[#xworld.coins + 1] = myshape.body end
		return myshape
	end
	-- MG SENSORS LAYER
	local function tiledsensors(xobject, xlevelsetup)
		local tablebase = {}
		if xobject.shape == "ellipse" then
			tablebase = {
				x = xobject.x, y = xobject.y,
				w = xobject.width, h = xobject.height, rotation = xobject.rotation,
				issensor = true,
			}
			for k, v in pairs(xlevelsetup) do tablebase[k] = v end
			myshape = Tiled_LF_Ellipse.new(xworld, tablebase)
		elseif xobject.shape == "polygon" then
			tablebase = {
				x = xobject.x, y = xobject.y,
				coords = xobject.polygon, rotation = xobject.rotation,
				issensor = true,
			}
			for k, v in pairs(xlevelsetup) do tablebase[k] = v end
			myshape = Tiled_LF_Polygon.new(xworld, tablebase)
		elseif xobject.shape == "rectangle" then
			tablebase = {
				x = xobject.x, y = xobject.y,
				w = xobject.width, h = xobject.height, rotation = xobject.rotation,
				issensor = true,
			}
			for k, v in pairs(xlevelsetup) do tablebase[k] = v end
			myshape = Tiled_LF_Rectangle.new(xworld, tablebase)
		else
			print("*** CANNOT PROCESS THIS SHAPE! ***", xobject.shape, xobject.name)
			return
		end
		myshape:setPosition(xobject.x, xobject.y)
		self.mg:addChild(myshape)
	end
	-- FG DECO LAYER
	local function tiledfg(xobject, xlevelsetup)
		local tablebase = {}
		if xobject.shape == "ellipse" then
			tablebase = {
				x = xobject.x, y = xobject.y,
				w = xobject.width, h = xobject.height, rotation = xobject.rotation,
				isdeco = true,
			}
			for k, v in pairs(xlevelsetup) do tablebase[k] = v end
			myshape = Tiled_LF_Ellipse.new(xworld, tablebase)
		elseif xobject.shape == "polygon" then
			tablebase = {
				x = xobject.x, y = xobject.y,
				coords = xobject.polygon, rotation = xobject.rotation,
				isdeco = true,
			}
			for k, v in pairs(xlevelsetup) do tablebase[k] = v end
			myshape = Tiled_LF_Polygon.new(xworld, tablebase)
		elseif xobject.shape == "rectangle" then
			tablebase = {
				x = xobject.x, y = xobject.y,
				w = xobject.width, h = xobject.height, rotation = xobject.rotation,
				isdeco = true,
			}
			for k, v in pairs(xlevelsetup) do tablebase[k] = v end
			myshape = Tiled_LF_Rectangle.new(xworld, tablebase)
		else
			print("*** CANNOT PROCESS THIS SHAPE! ***", xobject.shape, xobject.name)
			return
		end
		myshape:setPosition(xobject.x, xobject.y)
		self.fg:addChild(myshape)
	end

	-- parse the tiled levels
	local mapwidth, mapheight = xtiledlevel.width * xtiledlevel.tilewidth, xtiledlevel.height * xtiledlevel.tileheight
	print("map size", mapwidth, mapheight, "app size", myappwidth, myappheight, "all in pixels.")
	local layers = xtiledlevel.layers
	local myshape -- shapes from Tiled
	local mytable -- intermediate table for obj params
	for i = 1, #layers do
		local layer = layers[i]

		-- BG DECO LAYER
		if layer.name == "bg" then -- deco
			local objects = layer.objects
			local levelsetup = {}

			for i = 1, #objects do
				local object = objects[i]
				local objectName = object.name
				myshape, mytable = nil, nil
				if objectName == "" then -- default = white
					mytable = {color=0xFFFFFF}
				elseif objectName == "tex01" then
					if g_currentlevel == 1 then mytable = {tex="gfx/levels/Black Rock.jpg"}
					elseif g_currentlevel == 2 then mytable = {tex="gfx/levels/Corroded Techno Tiles.jpg"}
					elseif g_currentlevel == 3 then mytable = {tex="gfx/levels/Midnight Stone.jpg"}
					else mytable = {color=0xFF0000}
					end
				elseif objectName == "tex02" then
					if g_currentlevel == 1 then mytable = {tex="gfx/levels/Segmented Stone Wall.jpg"}
					elseif g_currentlevel == 2 then mytable = {tex="gfx/levels/Chamomile - Copy.jpg"}
					elseif g_currentlevel == 3 then mytable = {tex="gfx/levels/Midnight Stone.jpg"}
					else mytable = {color=0xFF0000}
					end
				elseif objectName == "tex03" then
					if g_currentlevel == 1 then mytable = {color=0xFF0000}
					elseif g_currentlevel == 2 then mytable = {tex="gfx/levels/Roses Mixed 128.jpg"}
					elseif g_currentlevel == 3 then mytable = {tex="gfx/levels/Chamomile Meadow.jpg"}
					else mytable = {color=0xFF0000}
					end
				elseif objectName == "tex04" then
					if g_currentlevel == 1 then mytable = {color=0xFF0000}
					elseif g_currentlevel == 2 then mytable = {color=0xFF0000, scalex=4, scaley=4}
					elseif g_currentlevel == 3 then mytable = {tex="gfx/levels/cave_ground01_512.png"}
					else mytable = {color=0xFF0000}
					end
				elseif objectName:sub(1, 6) == "ladder" then
					if objectName == "ladder01" then
						if g_currentlevel == 1 then mytable = {tex="gfx/levels/ladder01.png"}
						elseif g_currentlevel == 2 then mytable = {color=0xFF0000, scalex=4, scaley=4}
						elseif g_currentlevel == 3 then mytable = {color=0xFF0000, scalex=4, scaley=4}
						else mytable = {color=0xFF0000}
						end
					end
				end
				if mytable then
					levelsetup = {isshape=true}
					for k, v in pairs(mytable) do levelsetup[k] = v end
					tileddeco(object, levelsetup)
				end

				-- BG FX
				if objectName == "flow" then
					myshape = Tiled_Flow.new(xworld, {
						tex = "gfx/fx/water_flow04.png", flowspeedy=2,
						w = object.width, h = object.height, rotation = object.rotation,
					})
				elseif objectName == "river" then
					myshape = Tiled_Flow.new(xworld, {
						tex = "gfx/fx/water_flow04.png",
						w = object.width, h = object.height, rotation = object.rotation,
						flowspeedx = 0.3,
					})
				elseif objectName == "lava" then
					if object.shape == "ellipse" then
						myshape = LF_Particles.new(xworld, self.camera, {
							w = object.width, h = object.height, rotation = object.rotation,
						})
					elseif object.shape == "polygon" then
						myshape = LF_Particles.new(xworld, self.camera, {
							x = object.x, y = object.y,
							coords = object.polygon, rotation = object.rotation,
							tex = "gfx/ui/btn_02_up.png",
						})
					elseif object.shape == "rectangle" then
						myshape = LF_Particles.new(xworld, self.camera, {
							x = object.x, y = object.y,
							w = object.width, h = object.height, rotation = object.rotation,
							tex = "gfx/ui/btn_02_up.png",
						})
					end
				elseif objectName == "windmill" then
					myshape = Tiled_WindMill.new(xworld, {
						x=object.x, y=object.y, tex="gfx/fx/windmill_wing01b.png",
							scalex=1, scaley=1, rotationspeed = 0.25
					})
				end
				if myshape then
					myshape:setPosition(object.x, object.y)
					self.bg:addChild(myshape)
				end
			end

		-- LEVEL LAYER
		elseif layer.name == "mg" then
			local levelsetup = {}
			local objects = layer.objects
			for i = 1, #objects do
				local object = objects[i]
				local objectName = object.name
				myshape, mytable = nil, nil

				if objectName:sub(1, 6) == "ground" then
					if objectName == "ground01" then
						if g_currentlevel == 1 then mytable = {tex="gfx/levels/Fluorite Cavern.jpg"}
						elseif g_currentlevel == 2 then mytable = {tex="gfx/levels/Grassy Stone Path - Copy (2).jpg"}
						elseif g_currentlevel == 3 then mytable = {tex="gfx/levels/Grassy Stone Path - Copy (2).jpg"}
						else mytable = {color=0xFF0000}
						end
					elseif objectName == "ground02" then
						if g_currentlevel == 1 then mytable = {tex="gfx/levels/Grassy Stone Path - Copy (2).jpg"}
						elseif g_currentlevel == 2 then mytable = {tex="gfx/levels/Chamomile Meadow.jpg"}
						elseif g_currentlevel == 3 then mytable = {tex="gfx/levels/Grassy Stone Path - Copy (2).jpg"}
						else mytable = {color=0xFF0000}
						end
					elseif objectName == "ground03" then
						if g_currentlevel == 1 then mytable = {}
						elseif g_currentlevel == 2 then mytable = {}
						elseif g_currentlevel == 3 then mytable = {tex="gfx/levels/wall03.png"}
						else mytable = {color=0xFF0000}
						end
					else
						mytable = {color=0xFF0000}
					end
					levelsetup = {
						isshape=true,
						density=1024*3, restitution=0, friction=1,
						BIT=G_BITSOLID, COLBIT=solidcollisions, TYPE=G_GROUND,
					}
					for k, v in pairs(mytable) do levelsetup[k] = v end
					tiledlevel(object, levelsetup)
				elseif objectName:sub(1, 4) == "wall" then
					if objectName == "wall01" then
						if g_currentlevel == 1 then mytable = {tex="gfx/levels/Fluorite Cavern.jpg"}
						elseif g_currentlevel == 2 then mytable = {tex="gfx/levels/Corroded Techno Tiles.jpg", scalex=0.5, scaley=0.5}
						elseif g_currentlevel == 3 then mytable = {tex="gfx/levels/Corroded Techno Tiles.jpg", scalex=0.5, scaley=0.5}
						else mytable = {color=0xFF0000}
						end
					elseif objectName == "wall02" then
						if g_currentlevel == 1 then mytable = {tex="gfx/levels/Fluorite Cavern.jpg"}
						elseif g_currentlevel == 2 then mytable = {tex="gfx/levels/Corroded Techno Tiles.jpg", scalex=0.5, scaley=0.5}
						elseif g_currentlevel == 3 then mytable = {tex="gfx/levels/Corroded Techno Tiles.jpg", scalex=0.5, scaley=0.5}
						else mytable = {color=0xFF0000}
						end
					else
						mytable = {color=0xFF0000}
					end
					levelsetup = {isshape=true,
						density=1024*2, restitution=0, friction=0,
						BIT=G_BITSOLID, COLBIT=solidcollisions, TYPE=G_WALL,
					}
					for k, v in pairs(mytable) do levelsetup[k] = v end
					tiledlevel(object, levelsetup)
				elseif objectName:sub(1, 7) == "ceiling" then
					if objectName == "ceiling01" then
						if g_currentlevel == 1 then mytable = {tex="gfx/levels/cave01_128.png"}
						else mytable = {color=0xFF0000}
						end
					elseif objectName == "ceiling02" then
						if g_currentlevel == 1 then mytable = {tex="gfx/levels/Zinnias.jpg"}
						else mytable = {color=0xFF0000}
						end
					else
						mytable = {color=0xFF0000}
					end
					levelsetup = {isshape=true,
						density=1024*1, restitution=0, friction=0,
						BIT=G_BITSOLID, COLBIT=solidcollisions, TYPE=G_WALL,
					}
					for k, v in pairs(mytable) do levelsetup[k] = v end
					tiledlevel(object, levelsetup)
				elseif objectName:sub(1, 4) == "ptpf" then
					if objectName == "ptpf01" then
						if g_currentlevel == 1 then mytable = {tex="gfx/levels/ladder01.png"}
						elseif g_currentlevel == 2 then mytable = {color=0xff0000}
						else mytable = {color=0xFF0000}
						end
					elseif objectName == "ptpf02" then
						if g_currentlevel == 1 then mytable = {tex="gfx/levels/ladder01.png"}
						elseif g_currentlevel == 2 then mytable = {color=0xff0000}
						else mytable = {color=0xFF0000}
						end
					else
						mytable = {color=0xFF0000}
					end
					levelsetup = {
						isshape=true,
						restitution=0, friction=1,
						BIT=G_BITSOLID, COLBIT=solidcollisions, TYPE=G_PTPLATFORM,
					}
					for k, v in pairs(mytable) do levelsetup[k] = v end
					tiledlevel(object, levelsetup)
				elseif objectName:sub(1,6) == "mpf_h_" then
					if g_currentlevel == 1 then mytable = {tex="gfx/ui/btn_01_up.png"}
					elseif g_currentlevel == 3 then mytable = {tex="gfx/ui/btn_01_up.png"}
					else mytable = {color=0xFF0000}
					end
					levelsetup = {
						isshape=true,
						restitution=0, friction=1, density=1024*32,
						BIT=G_BITSOLID, COLBIT=solidcollisions, TYPE=G_MPLATFORM,
						type=b2.DYNAMIC_BODY,
					}
					for k, v in pairs(mytable) do levelsetup[k] = v end
					myshape = tiledlevel(object, levelsetup)
					-- final
					local distance = tonumber(string.match(objectName, "%d+"))
					local ll, ul
					if string.find(objectName, "_r_") then
						ll, ul = 0, distance * 32
					else
						ll, ul = -distance * 32, 0
					end
					local mpfh = Tiled_LF_Joint_Prismatic_Mpf.new(xworld, myshape, nil, {
						x=object.x, y=object.y,
						xaxis=1, yaxis=0, lowerlimit=ll, upperlimit=ul,
						speed=3,
					})
					self.mg:addChild(mpfh)
				elseif objectName:sub(1,6) == "mpf_v_" then
					if g_currentlevel == 1 then mytable = {tex="gfx/ui/btn_01_up.png"}
					elseif g_currentlevel == 3 then mytable = {color=0x00FF00}
					else mytable = {color=0xFF0000}
					end
					-- for the joint
					levelsetup = {
						issensor=true,
						restitution=0, friction=1, density=1024*8,
						BIT=G_BITSOLID, COLBIT=solidcollisions, TYPE=G_MPLATFORM,
						type=b2.DYNAMIC_BODY,
					}
					for k, v in pairs(mytable) do levelsetup[k] = v end
					myshape = tiledlevel(object, levelsetup)
					-- the actual platform
					levelsetup = {
						isshape=true,
						restitution=0, friction=1,
						BIT=G_BITSOLID, COLBIT=solidcollisions, TYPE=G_MPLATFORM,
						type=b2.SOLID_BODY,
					}
					for k, v in pairs(mytable) do levelsetup[k] = v end
					local myshape2 = tiledlevel(object, levelsetup)
					-- final
					local distance = tonumber(string.match(objectName, "%d+"))
					local ll, ul
					if string.find(objectName, "_d_") then
						ll, ul = 0, distance * 32
					else
						ll, ul = -distance * 32, 0
					end
					local mpfv = Tiled_LF_Joint_Prismatic_Mpf.new(xworld, myshape, myshape2, {
						x=object.x, y=object.y,
						xaxis=0, yaxis=1, lowerlimit=ll, upperlimit=ul,
						speed=2,
					})
					self.mg:addChild(mpfv)

				elseif objectName == "coin" then
					if g_currentlevel == 1 then mytable = {tex="gfx/collectibles/coin02.png"}
					else mytable = {tex="gfx/collectibles/coin02.png"}
					end
					levelsetup = {isbmp=true,
						restitution=0, friction=0,
						BIT=G_BITSENSOR, COLBIT=G_BITPLAYER, TYPE=G_COIN,
						type=b2.KINEMATIC_BODY,
						lvx=0.5, lvy=0.5, isdestructible=true, issensor=true,
					}
					for k, v in pairs(mytable) do levelsetup[k] = v end
					tiledlevel(object, levelsetup)
				end

				-- PLAYER & OTHERS
				if objectName == "player" then
					self.player = LF_Dynamic_Character.new(xworld,
						"gfx/player/girl-2.png", 6, 7, 0, 8,
						G_BITPLAYER, playercollisions, G_PLAYER)
					self.player.body.lives = 1 -- XXX
					self.player.body:setPosition(object.x, object.y) -- position the body, the bitmap will follow in enterframe
					self.mg:addChild(self.player)
				elseif objectName == "nme01" then
					self.nme01 = LF_Dynamic_Character.new(xworld,
						"gfx/nmes/cavemen/lion.png", 6, 7, 0, 2,
						G_BITENEMY, nmecollisions, G_ENEMY01)
					self.nme01.speed = 3
					self.nme01.jumpspeed = 8 * 2.5
					self.nme01.body.lives = 1
					self.nme01.body.nrg = 3
					self.nme01.body:setPosition(object.x, object.y) -- position the body, the bitmap will follow in enterframe
					self.mg:addChild(self.nme01)
					xworld.nmes[self.nme01] = self.nme01.body
				elseif objectName == "npc01" then
					self.npc01 = LF_Dynamic_Character.new(xworld,
						"gfx/player/girl-2.png", 6, 7, 0, 8,
						G_BITNPC, npccollisions, G_NPC01)
					self.npc01.body:setPosition(object.x, object.y) -- position the body, the bitmap will follow in enterframe
					self.mg:addChild(self.npc01)
				end
			end

		-- SENSORS LAYER
		elseif layer.name == "sensors" then
			local objects = layer.objects
			local levelsetup = {}
			for i = 1, #objects do
				local object = objects[i]
				local objectName = object.name

				if objectName == "cam_pos" then
					levelsetup = {BIT=G_BITSENSOR, COLBIT=G_BITPLAYER, TYPE=G_CAM_POS}
				elseif objectName == "cam_zoomX05" then
					levelsetup = {BIT=G_BITSENSOR, COLBIT=G_BITPLAYER, TYPE=G_CAM_ZOOMX05}
				elseif objectName == "cam_zoomX1" then
					levelsetup = {BIT=G_BITSENSOR, COLBIT=G_BITPLAYER, TYPE=G_CAM_ZOOMX1}
				elseif objectName == "ladder" then
					levelsetup = {BIT=G_BITSENSOR, COLBIT=laddercollisions, TYPE=G_LADDER}
				elseif objectName == "bump_yp4" then -- bump y axis 4 tiles up (4*64)
					levelsetup = {BIT=G_BITSENSOR, COLBIT=G_BITPLAYER, TYPE=G_BUMP_YP4}
				elseif objectName == "bump_yp5" then -- bump y axis 5 tiles up (5*64)
					levelsetup = {BIT=G_BITSENSOR, COLBIT=G_BITPLAYER, TYPE=G_BUMP_YP5}
				elseif objectName == "exit" then
					levelsetup = {BIT=G_BITSENSOR, COLBIT=G_BITPLAYER, TYPE=G_EXIT}
				elseif objectName == "dead" then
					levelsetup = {BIT=G_BITSENSOR, COLBIT=deadcollisions, TYPE=G_DEAD}
				end
				tiledsensors(object, levelsetup)
			end

		-- FG DECO LAYER
		elseif layer.name == "fg" then -- deco
			local objects = layer.objects
			local levelsetup = {}
			for i = 1, #objects do
				local object = objects[i]
				local objectName = object.name
				myshape, mytable = nil, nil

				if objectName == "" then -- default = white or change?
					mytable = {tex="gfx/levels/Zinnias - Copy.jpg"}
				elseif objectName == "tex01" then -- any object
					if g_currentlevel == 1 then mytable = {tex="gfx/levels/Segmented Stone Wall.jpg"}
					elseif g_currentlevel == 2 then mytable = {tex="gfx/levels/Swirly Gray Marble.jpg"}
					else mytable = {color=0xFF0000}
					end
				elseif objectName == "tex02" then -- any object
					if g_currentlevel == 1 then mytable = {tex="gfx/levels/Segmented Stone Wall.jpg"}
					elseif g_currentlevel == 2 then mytable = {tex="gfx/levels/Segmented Stone Wall.jpg"}
					else mytable = {color=0xFF0000}
					end
				elseif objectName == "tex03" then -- any object
					if g_currentlevel == 1 then mytable = {tex="gfx/levels/Zinnias.jpg"}
					elseif g_currentlevel == 2 then mytable = {tex="gfx/levels/Zinnias - Copy.jpg"}
					else mytable = {color=0xFF0000}
					end
				end
				if mytable then
					levelsetup = {isshape=true}
					for k, v in pairs(mytable) do levelsetup[k] = v end
					tiledfg(object, levelsetup)
				end

				-- FG FX
				if objectName == "flow" then -- elipse, polygon, rectangle :-)
					myshape = Tiled_Flow.new(xworld, {
						tex = "gfx/fx/water_flow02.png", flowspeedy=2,
						w = object.width, h = object.height, rotation = object.rotation,
					})
				elseif objectName == "windmill" then
					myshape = Tiled_WindMill.new(xworld, {
						x=object.x, y=object.y, tex="gfx/fx/windmill_wing01b.png",
							scalex=1, scaley=1, rotationspeed = 0.25
					})
				elseif objectName == "opacity01" then
					myshape = Tiled_GradientPane.new({
						width = object.width, height = object.height,
						gradientcolor1 = 0x0, gradientcolor1alpha = 0.75, angle = 0,
					})
				elseif objectName == "gradient01" then
					myshape = Tiled_GradientPane.new({
						width = object.width, height = object.height,
						type="2colorsgradient",
						gradientcolor1 = 0x0, gradientcolor1alpha = 0.75,
						gradientcolor2 = 0x0, gradientcolor2alpha = 0,
						angle = 45*4,
					})
				elseif objectName == "gradient02" then
					myshape = Tiled_GradientPane.new({
						width = object.width, height = object.height,
--[[
						type="1colorgradient",
						gradientcolor1 = 0x0, gradientcolor1alpha = 0.75,
						gradientcolor2 = 0xFF0000, gradientcolor2alpha = 0.5,
						angle = 45*4,
]]
						type="4colorsgradient",
						gradientcolor1 = 0x000000, gradientcolor1alpha = 0.75,
						gradientcolor2 = 0x00ffff, gradientcolor2alpha = 0.1,
						gradientcolor3 = 0xffffff, gradientcolor3alpha = 0.1,
						gradientcolor4 = 0x000000, gradientcolor4alpha = 0.75,
					})
				end
				if myshape then
					myshape:setPosition(object.x, object.y)
					self.fg:addChild(myshape)
				end
			end

		else
			print("WHAT?!", layer.name)
		end
	end
end
