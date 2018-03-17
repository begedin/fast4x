func generate(x, y):
	randomize()
	var grid = []
	var rang
	for i in range(0, x):
		grid.push_back([])
		for j in range(0, y):
			grid[i].push_back(rand_range(0, 1))
	
	return grid
	
