extends TileMap

export var size = Vector2(4, 4)

var tile_collection
var __grid
var __label

class Hex:
	var q
	var r
	var size
		
	func _init(q, r, diameter):
		self.q = q
		self.r = r
		self.size = diameter / 2
		
	func pixels():
		var x = self.size * 3/2 * self.q
		var offset = int(self.q) % 2 / 2.0
		var y = self.size * sqrt(3) * (self.r + offset) 
		return Vector2(x, y)
		

class TileCollection:
	var items = {}
	var tile_size

func __add_tile(tile, parent, gridxy):
	var tile_dup = tile.duplicate()
	var hex = Hex.new(gridxy.x, gridxy.y, self.tile_collection.tile_size.x)
	tile_dup.set_position(hex.pixels())
	
	var label = self.__label.duplicate()
	label.set_text("%d, %d" % [gridxy.x, gridxy.y])
	
	tile_dup.add_child(label)
	
	parent.add_child(tile_dup)
	
func __make_grid():
	var grid = []
	var rang
	for x in range(-1 * floor(self.size.x / 2), floor(self.size.x / 2)):
		for y in range(-1 * floor(self.size.y / 2), floor(self.size.y / 2)):
			grid.push_back(Vector2(x, y))
	return grid
	
func __make_label():
	var label = Label.new()
	return label
	
func __rand_tile():
	var keys = self.tile_collection.items.keys()
	var r = int(rand_range(0, keys.size()))
	return self.tile_collection.items[keys[r]]
	
func make_board():
	randomize()
	self.__label = __make_label()
	self.__grid = __make_grid()
	
	for x in range(0, self.size.x + 1):
		for y in range(0, self.size.y + 1):
			var tile = self.__rand_tile()
			self.__add_tile(tile, self, Vector2(x, y))

func fetch_tiles(tile_set_filepath, size_node_name):
	self.tile_collection = TileCollection.new()
	var tile_set_scene = load(tile_set_filepath)
	var tile_set = tile_set_scene.instance()
	for node in tile_set.get_children():
		self.tile_collection.items[node.get_name().to_lower()] = node
	self.tile_collection.tile_size = (tile_set.get_node(size_node_name).get_texture().get_size())

func _ready():
	pass
	
	