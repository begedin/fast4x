var width = 60
var height = 30
var grid
var sea_level = 0.2
var DiamondSquare = load("res://Scripts/DiamondSquare.gd")

func _init(x, y):
	self.width = x
	self.height = y
	
	randomize()
	
	self.grid = DiamondSquare.generate(x, y, 0.65)
	self.__add_water(0.5)
	
func __add_water(amount):	
	if amount == 1.0:
		self.sea_level = 1.0
	else:
		var height_sum = 0
		for row in self.grid:
			for height in row:
				height_sum += height
		var average_height = height_sum / (self.grid.size() * self.grid[0].size())
		print("%d %d %d %d" % [self.grid.size(), self.grid[0].size(), self.width, self.height])
		self.sea_level = average_height * amount * 2