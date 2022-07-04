extends Node
var cols=[
Color(0.94,0.97,1),
Color(0.98,0.92,0.84),
Color(0,1,1),
Color(0.5,1,0.83),
Color(0.94,1,1),
Color(0.96,0.96,0.86),
Color(1,0.89,0.77),
Color(0,0,0),
Color(1,0.92,0.8),
Color(0,0,1),
Color(0.54,0.17,0.89),
Color(0.65,0.16,0.16),
Color(0.87,0.72,0.53),
Color(0.37,0.62,0.63),
Color(0.5,1,0),
Color(0.82,0.41,0.12),
Color(1,0.5,0.31),
Color(0.39,0.58,0.93),
Color(1,0.97,0.86),
Color(0.86,0.08,0.24),
Color(0,1,1),
Color(0,0,0.55),
Color(0,0.55,0.55),
Color(0.72,0.53,0.04),
Color(0.66,0.66,0.66),
Color(0,0.39,0),
Color(0.74,0.72,0.42),
Color(0.55,0,0.55),
Color(0.33,0.42,0.18),
Color(1,0.55,0),
Color(0.6,0.2,0.8),
Color(0.55,0,0),
Color(0.91,0.59,0.48),
Color(0.56,0.74,0.56),
Color(0.28,0.24,0.55),
Color(0.18,0.31,0.31),
Color(0,0.81,0.82),
Color(0.58,0,0.83),
Color(1,0.08,0.58),
Color(0,0.75,1),
Color(0.41,0.41,0.41),
Color(0.12,0.56,1),
Color(0.7,0.13,0.13),
Color(1,0.98,0.94),
Color(0.13,0.55,0.13),
Color(1,0,1),
Color(0.86,0.86,0.86),
Color(0.97,0.97,1),
Color(1,0.84,0),
Color(0.85,0.65,0.13),
Color(0.75,0.75,0.75),
Color(0,1,0),
Color(0.68,1,0.18),
Color(0.94,1,0.94),
Color(1,0.41,0.71),
Color(0.8,0.36,0.36),
Color(0.29,0,0.51),
Color(1,1,0.94),
Color(0.94,0.9,0.55),
Color(0.9,0.9,0.98),
Color(1,0.94,0.96),
Color(0.49,0.99,0),
Color(1,0.98,0.8),
Color(0.68,0.85,0.9),
Color(0.94,0.5,0.5),
Color(0.88,1,1),
Color(0.98,0.98,0.82),
Color(0.83,0.83,0.83),
Color(0.56,0.93,0.56),
Color(1,0.71,0.76),
Color(1,0.63,0.48),
Color(0.13,0.7,0.67),
Color(0.53,0.81,0.98),
Color(0.47,0.53,0.6),
Color(0.69,0.77,0.87),
Color(1,1,0.88),
Color(0,1,0),
Color(0.2,0.8,0.2),
Color(0.98,0.94,0.9),
Color(1,0,1),
Color(0.69,0.19,0.38),
Color(0.4,0.8,0.67),
Color(0,0,0.8),
Color(0.73,0.33,0.83),
Color(0.58,0.44,0.86),
Color(0.24,0.7,0.44),
Color(0.48,0.41,0.93),
Color(0,0.98,0.6),
Color(0.28,0.82,0.8),
Color(0.78,0.08,0.52),
Color(0.1,0.1,0.44),
Color(0.96,1,0.98),
Color(1,0.89,0.88),
Color(1,0.89,0.71),
Color(1,0.87,0.68),
Color(0,0,0.5),
Color(0.99,0.96,0.9),
Color(0.5,0.5,0),
Color(0.42,0.56,0.14),
Color(1,0.65,0),
Color(1,0.27,0),
Color(0.85,0.44,0.84),
Color(0.93,0.91,0.67),
Color(0.6,0.98,0.6),
Color(0.69,0.93,0.93),
Color(0.86,0.44,0.58),
Color(1,0.94,0.84),
Color(1,0.85,0.73),
Color(0.8,0.52,0.25),
Color(1,0.75,0.8),
Color(0.87,0.63,0.87),
Color(0.69,0.88,0.9),
Color(0.63,0.13,0.94),
Color(0.4,0.2,0.6),
Color(1,0,0),
Color(0.74,0.56,0.56),
Color(0.25,0.41,0.88),
Color(0.55,0.27,0.07),
Color(0.98,0.5,0.45),
Color(0.96,0.64,0.38),
Color(0.18,0.55,0.34),
Color(1,0.96,0.93),
Color(0.63,0.32,0.18),
Color(0.75,0.75,0.75),
Color(0.53,0.81,0.92),
Color(0.42,0.35,0.8),
Color(0.44,0.5,0.56),
Color(1,0.98,0.98),
Color(0,1,0.5),
Color(0.27,0.51,0.71),
Color(0.82,0.71,0.55),
Color(0,0.5,0.5),
Color(0.85,0.75,0.85),
Color(1,0.39,0.28),
Color(0.25,0.88,0.82),
Color(0.93,0.51,0.93),
Color(0.5,0.5,0.5),
Color(0,0.5,0),
Color(0.5,0,0),
Color(0.5,0,0.5),
Color(0.96,0.87,0.7),
Color(1,1,1),
Color(0.96,0.96,0.96),
Color(1,1,0),
Color(0.6,0.8,0.2)]
var colnames=[
"aliceblue",
"antiquewhite",
"aqua",
"aquamarine",
"azure",
"beige",
"bisque",
"black",
"blanchedalmond",
"blue",
"blueviolet",
"brown",
"burlywood",
"cadetblue",
"chartreuse",
"chocolate",
"coral",
"cornflower",
"cornsilk",
"crimson",
"cyan",
"darkblue",
"darkcyan",
"darkgoldenrod",
"darkgray",
"darkgreen",
"darkkhaki",
"darkmagenta",
"darkolivegreen",
"darkorange",
"darkorchid",
"darkred",
"darksalmon",
"darkseagreen",
"darkslateblue",
"darkslategray",
"darkturquoise",
"darkviolet",
"deeppink",
"deepskyblue",
"dimgray",
"dodgerblue",
"firebrick",
"floralwhite",
"forestgreen",
"fuchsia",
"gainsboro",
"ghostwhite",
"gold",
"goldenrod",
"gray",
"green",
"greenyellow",
"honeydew",
"hotpink",
"indianred",
"indigo",
"ivory",
"khaki",
"lavender",
"lavenderblush",
"lawngreen",
"lemonchiffon",
"lightblue",
"lightcoral",
"lightcyan",
"lightgoldenrod",
"lightgray",
"lightgreen",
"lightpink",
"lightsalmon",
"lightseagreen",
"lightskyblue",
"lightslategray",
"lightsteelblue",
"lightyellow",
"lime",
"limegreen",
"linen",
"magenta",
"maroon",
"mediumaquamarine",
"mediumblue",
"mediumorchid",
"mediumpurple",
"mediumseagreen",
"mediumslateblue",
"mediumspringgreen",
"mediumturquoise",
"mediumvioletred",
"midnightblue",
"mintcream",
"mistyrose",
"moccasin",
"navajowhite",
"navyblue",
"oldlace",
"olive",
"olivedrab",
"orange",
"orangered",
"orchid",
"palegoldenrod",
"palegreen",
"paleturquoise",
"palevioletred",
"papayawhip",
"peachpuff",
"peru",
"pink",
"plum",
"powderblue",
"purple",
"rebeccapurple",
"red",
"rosybrown",
"royalblue",
"saddlebrown",
"salmon",
"sandybrown",
"seagreen",
"seashell",
"sienna",
"silver",
"skyblue",
"slateblue",
"slategray",
"snow",
"springgreen",
"steelblue",
"tan",
"teal",
"thistle",
"tomato",
"turquoise",
"violet",
"webgray",
"webgreen",
"webmaroon",
"webpurple",
"wheat",
"white",
"whitesmoke",
"yellow",
"yellowgreen"]