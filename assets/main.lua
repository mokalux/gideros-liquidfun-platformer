-- plugins
require "scenemanager"
require "easing"
require "liquidfun"
-- screen size
myappleft, myapptop, myappright, myappbot = application:getLogicalBounds()
myappwidth, myappheight = myappright - myappleft, myappbot - myapptop
-- fonts
g_font1 = "fonts/KenPixel Blocks.ttf"
-- LIQUID FUN: here we store all possible contact TYPE -- NO LIMIT :-)
G_GROUND = 2^0 -- solids...
G_WALL = 2^1
G_MPLATFORM = 2^2
G_PTPLATFORM = 2^3
G_PLAYER = 2^4 -- player...
G_PLAYER_BULLET = 2^5
G_ENEMY01 = 2^6
G_ENEMY_BULLET = 2^7
G_ENEMY_SENSOR = 2^8
G_NPC01 = 2^9
G_EXIT = 2^10 -- sensors...
G_DEAD = 2^11
G_CAM_POS = 2^12
G_CAM_ZOOMX1 = 2^13
G_CAM_ZOOMX05 = 2^14
G_CAM_ZOOMX2 = 2^15
G_LADDER = 2^16
G_COIN = 2^17
G_BUMP_YP4 = 2^18
G_BUMP_YP5 = 2^19
-- LIQUID FUN: here we define some category BITS (that is those objects can collide) -- 2^15 = MAX
G_BITSOLID = 2^0
G_BITPLAYER = 2^1
G_BITPLAYERBULLET = 2^2
G_BITENEMY = 2^3
G_BITENEMYBULLET = 2^4
G_BITNPC = 2^5
G_BITSENSOR = 2^6
-- and their appropriate masks (that is what can collide with what)
solidcollisions = G_BITPLAYER + G_BITPLAYERBULLET + G_BITENEMY + G_BITENEMYBULLET + G_BITNPC
playercollisions = G_BITSOLID + G_BITENEMY + G_BITENEMYBULLET + G_BITSENSOR
playerbulletcollisions = G_BITSOLID + G_BITENEMY + G_BITENEMYBULLET
nmecollisions = G_BITSOLID + G_BITPLAYER + G_BITPLAYERBULLET + G_BITSENSOR
nmebulletcollisions = G_BITSOLID + G_BITPLAYER + G_BITPLAYERBULLET
npccollisions = G_BITSOLID
-- tiled levels
tiled_levels = {}
tiled_levels[1] = loadfile("tiled/t_level_a000_the_cave.lua")()
tiled_levels[2] = loadfile("tiled/t_level_a050_the_farm.lua")()
tiled_levels[3] = loadfile("tiled/t_level_a100_river_and_windmill.lua")()
-- level info
g_currentlevel = 1 -- 1, 2, 3
-- scene manager
scenemanager = SceneManager.new({
	["menu"] = Menu,
	["introX"] = IntroX,
	["levelX"] = LevelX,
})
stage:addChild(scenemanager)
scenemanager:changeScene("menu")
--scenemanager:changeScene("levelX")
