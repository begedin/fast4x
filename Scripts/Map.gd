extends TileMap

export var size = Vector2(60, 30)

var World = load("res://Scripts/World.gd")

var tile_collection
var __world
var __label		

class TileCollection:
	var items = {}
	var tile_size

func __add_tile(tile, parent, q, r):
	var hex = tile.duplicate()
	hex.coordinates = Vector2(q, r)
		
	var label = self.__label.duplicate()
	label.set_text("%d, %d" % [hex.q, hex.r])
	
	hex.add_child(label)
	parent.add_child(hex)
	
func __make_label():
	var label = Label.new()
	return label
	
func __get_tile(world, x, y):
	var height = world.grid[x][y]
	var name
	if height < world.sea_level:
		name = "water"
	else:
		name = "grass"
		
	return self.tile_collection.items[name]
	
func make_board():
	self.__label = __make_label()
	
	var world = World.new(self.size.x, self.size.y)
	
	for x in range(0, self.size.x):
		for y in range(0, self.size.y):
			var tile = self.__get_tile(world, x, y)
			self.__add_tile(tile, self, x, y)

func fetch_tiles(tile_set_filepath, size_node_name):
	self.tile_collection = TileCollection.new()
	var tile_set_scene = load(tile_set_filepath)
	var tile_set = tile_set_scene.instance()
	for node in tile_set.get_children():
		self.tile_collection.items[node.get_name().to_lower()] = node
	self.tile_collection.tile_size = (tile_set.get_node(size_node_name).get_texture().get_size())

func _ready():
	pass
	
	