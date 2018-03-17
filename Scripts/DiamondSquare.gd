static func generate(width, height, roughness = 0.5):
	var params = get_DS_size_and_iters(width, height)
	var ds_size = params[0]
	var iterations = params[1]
	
	var grid = init(ds_size)
	grid = seed_corners(grid, ds_size)
	
	for i in range(iterations):
		var r = pow(roughness, i)
		
		var step_size = (ds_size - 1) / pow(2, i)
		grid = diamond_step(grid, step_size, r)
		grid = square_step(grid, step_size, r)
	
	return trim(grid, width, height)
	
func get_DS_size_and_iters(width, height, max_power_of_two = 13):
	if max_power_of_two < 3: max_power_of_two = 3
	
	var largest_edge = max(width, height)
	
	for power in range(1, max_power_of_two + 1):
		var d = (pow(2, power) + 1)
		if largest_edge <= d:
			return [d, power]
			
func init(size):
	var grid = []
	for x in range(size):
    	grid.push_back([])
    	for y in range(size):
        	grid[x].push_back(-1.0)
	
	return grid
			
func seed_corners(grid, size):
	var m = size - 1
	
	grid[0][0] = rand_range(0, 1)
	grid[m][0] = rand_range(0, 1)
	grid[0][m] = rand_range(0, 1)
	grid[m][m] = rand_range(0, 1)
	
	return grid
			
		
static func diamond_step(grid, step_size, roughness):
	var half_step = step_size / 2
	var x_steps = range(half_step, grid.size(), step_size)
	var y_steps = x_steps.duplicate()
	
	for i in x_steps:
		for j in y_steps:
			if grid[i][j] == -1.0: 
				grid[i][j] = diamond_displace(grid, i, j, half_step, roughness)
	
	return grid
			
static func diamond_displace(grid, i, j, half_step, roughness):
	var ul = grid[i - half_step][j - half_step]
	var ur = grid[i - half_step][j + half_step]
	var ll = grid[i + half_step][j - half_step]
	var lr = grid[i + half_step][j + half_step]
	
	var average = (ul + ur + ll + lr) / 4.0
	var rand_val = rand_range(0, 1)
	
	return (roughness * rand_val + (1.0 - roughness) * average)
			
static func square_step(grid, step_size, roughness):
	var half_step = step_size/2
	
	var steps_x_horiz = range(0, grid.size(), step_size)
	var steps_y_horiz = range(half_step, grid[0].size(), step_size)
	
	for i in steps_x_horiz:
		for j in steps_y_horiz:
			grid[i][j] = square_displace(grid, i, j, half_step, roughness)
			
	var steps_x_vert = range(half_step, grid.size(), step_size)
	var steps_y_vert = range(0, grid[0].size(), step_size)
	
	for i in steps_x_vert:
		for j in steps_y_vert:
			grid[i][j] = square_displace(grid, i, j, half_step, roughness)

	return grid
			
static func square_displace(grid, i, j, half_step, roughness):
	var sum = 0.0
	var divide_by = 4
	
	if i - half_step >= 0:
		sum += grid[i - half_step][j]
	else: 
		divide_by -= 1
		
	if i + half_step < grid.size():
		sum += grid[i + half_step][j]
	else :
		divide_by -= 1
		
	if j - half_step >= 0:
		sum += grid[i][j - half_step]
	else:
		divide_by -= 1
	
	if j + half_step < grid[0].size():
		sum += grid[i][j + half_step]
	else:
		divide_by -= 1
	
	var average = sum / divide_by
	var rand_val = rand_range(0, 1)
	return (roughness * rand_val + (1.0 - roughness) * average)
	
static func trim(grid, width, height): 
	return grid