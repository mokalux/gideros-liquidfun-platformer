return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "2020.03.18",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 64,
  height = 32,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 11,
  nextobjectid = 378,
  properties = {},
  tilesets = {
    {
      name = "color_32",
      firstgid = 1,
      filename = "color_32.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 4,
      image = "colors_32.png",
      imagewidth = 128,
      imageheight = 128,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 16,
      tiles = {}
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "game_screen",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 251,
          name = "",
          type = "",
          shape = "polygon",
          x = 416,
          y = 640,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 416, y = 0 },
            { x = 416, y = -224 },
            { x = -416, y = -224 },
            { x = -416, y = 224 },
            { x = 416, y = 224 },
            { x = 416, y = 0 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "sensors",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      tintcolor = { 0, 0, 0 },
      properties = {},
      objects = {
        {
          id = 246,
          name = "exit",
          type = "",
          shape = "polygon",
          x = 112,
          y = 336,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 16, y = 0 },
            { x = 16, y = 16 },
            { x = -16, y = 16 },
            { x = -16, y = -16 },
            { x = 16, y = -16 },
            { x = 16, y = 0 }
          },
          properties = {}
        },
        {
          id = 248,
          name = "",
          type = "",
          shape = "polygon",
          x = 480,
          y = 640,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 192, y = 0 },
            { x = 192, y = 192 },
            { x = -192, y = 192 },
            { x = -192, y = 0 }
          },
          properties = {}
        },
        {
          id = 344,
          name = "",
          type = "",
          shape = "polygon",
          x = 816,
          y = 576,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 80, y = 0 },
            { x = 80, y = 192 },
            { x = -80, y = 192 },
            { x = -80, y = 0 }
          },
          properties = {}
        },
        {
          id = 345,
          name = "",
          type = "",
          shape = "polygon",
          x = 784,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 44, y = 0 },
            { x = 44, y = 192 },
            { x = -44, y = 192 },
            { x = -44, y = 0 }
          },
          properties = {}
        },
        {
          id = 346,
          name = "",
          type = "",
          shape = "polygon",
          x = 576,
          y = 224,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 96, y = 0 },
            { x = 96, y = 192 },
            { x = -96, y = 192 },
            { x = -96, y = 0 }
          },
          properties = {}
        },
        {
          id = 348,
          name = "",
          type = "",
          shape = "polygon",
          x = 952,
          y = 384,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 40, y = 0 },
            { x = 40, y = 192 },
            { x = -40, y = 192 },
            { x = -40, y = 0 }
          },
          properties = {}
        },
        {
          id = 354,
          name = "",
          type = "",
          shape = "polygon",
          x = 1064,
          y = 352,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 40, y = 0 },
            { x = 40, y = 192 },
            { x = -40, y = 192 },
            { x = -40, y = 0 }
          },
          properties = {}
        },
        {
          id = 355,
          name = "",
          type = "",
          shape = "polygon",
          x = 1904,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 48, y = 0 },
            { x = 48, y = 192 },
            { x = -48, y = 192 },
            { x = -48, y = 0 }
          },
          properties = {}
        },
        {
          id = 356,
          name = "",
          type = "",
          shape = "polygon",
          x = 1776,
          y = 128,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 40, y = 0 },
            { x = 40, y = 192 },
            { x = -40, y = 192 },
            { x = -40, y = 0 }
          },
          properties = {}
        },
        {
          id = 357,
          name = "",
          type = "",
          shape = "polygon",
          x = 936,
          y = 160,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 40, y = 0 },
            { x = 40, y = 192 },
            { x = -40, y = 192 },
            { x = -40, y = 0 }
          },
          properties = {}
        },
        {
          id = 358,
          name = "",
          type = "",
          shape = "polygon",
          x = 1776,
          y = 352,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 48, y = 0 },
            { x = 48, y = 192 },
            { x = -48, y = 192 },
            { x = -48, y = 0 }
          },
          properties = {}
        },
        {
          id = 359,
          name = "bump_yp5",
          type = "",
          shape = "polygon",
          x = 1904,
          y = 448,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 8, y = 0 },
            { x = 8, y = 32 },
            { x = -8, y = 32 },
            { x = -8, y = 0 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "level",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 95,
          name = "player",
          type = "",
          shape = "polygon",
          x = 176,
          y = 712,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 48, y = 0 },
            { x = 48, y = 36 },
            { x = -48, y = 36 },
            { x = -48, y = -36 },
            { x = 48, y = -36 },
            { x = 48, y = 0 }
          },
          properties = {}
        },
        {
          id = 8,
          name = "wall_no",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 64,
          height = 768,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "wall_no",
          type = "",
          shape = "rectangle",
          x = 1952,
          y = 0,
          width = 96,
          height = 480,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 98,
          name = "",
          type = "",
          shape = "polygon",
          x = -151.777,
          y = 736,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = -0.222917, y = 32 },
            { x = 855.777, y = 32 },
            { x = 855.777, y = 64 },
            { x = 0, y = 64 }
          },
          properties = {}
        },
        {
          id = 333,
          name = "wall_no",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 672,
          width = 96,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 334,
          name = "",
          type = "",
          shape = "rectangle",
          x = 712,
          y = 672,
          width = 80,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 335,
          name = "wall_no",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 576,
          width = 96,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 336,
          name = "",
          type = "",
          shape = "rectangle",
          x = 808,
          y = 576,
          width = 80,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 337,
          name = "wall_no",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 480,
          width = 96,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 338,
          name = "",
          type = "",
          shape = "rectangle",
          x = 904,
          y = 480,
          width = 80,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 343,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 352,
          width = 608,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 349,
          name = "",
          type = "",
          shape = "rectangle",
          x = 992,
          y = 480,
          width = 1248,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 350,
          name = "wall_no",
          type = "",
          shape = "rectangle",
          x = 1760,
          y = 256,
          width = 96,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 351,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1768,
          y = 256,
          width = 80,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 352,
          name = "",
          type = "",
          shape = "rectangle",
          x = 928,
          y = 256,
          width = 832,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 353,
          name = "",
          type = "",
          shape = "polygon",
          x = 928,
          y = 256,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -256, y = 96 },
            { x = -256, y = 128 },
            { x = 0, y = 32 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "deco",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 276,
          name = "flow",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 448,
          width = 64,
          height = 320,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 287,
          name = "bark",
          type = "",
          shape = "polygon",
          x = 376,
          y = 768,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 16, y = -64 },
            { x = 16, y = -128 },
            { x = 48, y = -128 },
            { x = 64, y = -64 },
            { x = 48, y = 0 }
          },
          properties = {}
        },
        {
          id = 297,
          name = "leaf",
          type = "",
          shape = "ellipse",
          x = 336,
          y = 552,
          width = 115,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 360,
          name = "",
          type = "",
          shape = "polygon",
          x = -112,
          y = 432,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = -40, y = 528 },
            { x = 1104, y = 432 },
            { x = 1104, y = 144 },
            { x = 1008, y = 144 },
            { x = 1008, y = 240 },
            { x = 912, y = 240 },
            { x = 912, y = 336 },
            { x = 816, y = 336 },
            { x = 816, y = 368 },
            { x = -40, y = 368 }
          },
          properties = {}
        },
        {
          id = 361,
          name = "",
          type = "",
          shape = "rectangle",
          x = 992,
          y = 512,
          width = 1248,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 362,
          name = "",
          type = "",
          shape = "rectangle",
          x = 928,
          y = 288,
          width = 832,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 363,
          name = "",
          type = "",
          shape = "polygon",
          x = 928,
          y = 288,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -256, y = 96 },
            { x = -256, y = 160 },
            { x = 0, y = 64 }
          },
          properties = {}
        },
        {
          id = 364,
          name = "",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 384,
          width = 608,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 365,
          name = "wall",
          type = "",
          shape = "rectangle",
          x = -152,
          y = 0,
          width = 152,
          height = 768,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 367,
          name = "wall",
          type = "",
          shape = "rectangle",
          x = 2048,
          y = 0,
          width = 192,
          height = 480,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 368,
          name = "ceiling",
          type = "",
          shape = "polygon",
          x = 96,
          y = 24,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = -32, y = 0 },
            { x = 8, y = 80 },
            { x = 56, y = 120 },
            { x = 96, y = 104 },
            { x = 128, y = 96 },
            { x = 160, y = 56 },
            { x = 176, y = 8 },
            { x = 248, y = 16 },
            { x = 272, y = 40 },
            { x = 320, y = 104 },
            { x = 360, y = 136 },
            { x = 392, y = 112 },
            { x = 440, y = 80 },
            { x = 496, y = 64 },
            { x = 544, y = 64 },
            { x = 600, y = 80 },
            { x = 680, y = 96 },
            { x = 784, y = 80 },
            { x = 880, y = 64 },
            { x = 944, y = 40 },
            { x = 968, y = 104 },
            { x = 1024, y = 104 },
            { x = 1048, y = 48 },
            { x = 1112, y = 32 },
            { x = 1176, y = 56 },
            { x = 1248, y = 80 },
            { x = 1320, y = 80 },
            { x = 1392, y = 56 },
            { x = 1464, y = 40 },
            { x = 1528, y = 80 },
            { x = 1624, y = 96 },
            { x = 1664, y = 40 },
            { x = 1752, y = 64 },
            { x = 1832, y = 88 },
            { x = 1856, y = -16 },
            { x = 56, y = -24 }
          },
          properties = {}
        },
        {
          id = 369,
          name = "liane",
          type = "",
          shape = "polygon",
          x = 152,
          y = 112,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 8, y = 56 },
            { x = 8, y = 88 },
            { x = 32, y = -16 }
          },
          properties = {}
        },
        {
          id = 370,
          name = "liane",
          type = "",
          shape = "polygon",
          x = 240,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 16, y = 88 },
            { x = 24, y = 144 },
            { x = 24, y = 208 },
            { x = 40, y = 104 },
            { x = 48, y = 48 },
            { x = 40, y = 0 }
          },
          properties = {}
        },
        {
          id = 371,
          name = "liane",
          type = "",
          shape = "polygon",
          x = 496,
          y = 96,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 16, y = 104 },
            { x = 32, y = 0 }
          },
          properties = {}
        },
        {
          id = 372,
          name = "liane",
          type = "",
          shape = "polygon",
          x = 624,
          y = 56,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 24, y = 152 },
            { x = 32, y = 96 },
            { x = 48, y = 8 }
          },
          properties = {}
        },
        {
          id = 373,
          name = "liane",
          type = "",
          shape = "polygon",
          x = 928,
          y = 56,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 16, y = 88 },
            { x = 32, y = 8 }
          },
          properties = {}
        },
        {
          id = 374,
          name = "liane",
          type = "",
          shape = "polygon",
          x = 1336,
          y = 80,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 8, y = 88 },
            { x = 24, y = 0 },
            { x = 8, y = -8 },
            { x = -8, y = 0 }
          },
          properties = {}
        },
        {
          id = 375,
          name = "liane",
          type = "",
          shape = "polygon",
          x = 1512,
          y = 56,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 80 },
            { x = 16, y = 40 },
            { x = 24, y = -8 }
          },
          properties = {}
        },
        {
          id = 376,
          name = "liane",
          type = "",
          shape = "polygon",
          x = 1648,
          y = 72,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 16, y = 104 },
            { x = 24, y = 8 }
          },
          properties = {}
        },
        {
          id = 377,
          name = "liane",
          type = "",
          shape = "polygon",
          x = 1856,
          y = 64,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 16, y = 104 },
            { x = 24, y = 8 }
          },
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 64,
      height = 32,
      id = 10,
      name = "x_level",
      visible = true,
      opacity = 0.2,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJztmIsKgzAMRcsYK8z+//duhRXuQqvdMLkp5kDwFcWjIa3mlFJ+x+NCkTtR2dI3dbuI7RrPTrRzy2QO4sl/E+vyXnvPAM8rkHeUI/2tGPlXtrR/rzIHczF/JqfhyV/S88f98vgo3xO/+B+xgq/kTP8VCX+uf683aob0Y/nvzR80g+0vvRnzHAT3W9Sf9GaD/hb158W7gf4WdeiF+2fJ7v8sPPi3nmPVe0bjIdPfsveMxkMP/t7+f2iBNc9yZvvPvHMG4a/j/0/NM5D+N4gzrhv+vv215hirzJO1v3m8+7PHYrZ/EATBVXkB/OIWoA=="
    }
  }
}
