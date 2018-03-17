

static func generate(x, y):
	randomize()
	var grid = []
	var rang
	
	var DiamondSquare = load("res://Scripts/DiamondSquare.gd")
	var height_map = DiamondSquare.generate(x, y, 0.65)
	
	return height_map
	
