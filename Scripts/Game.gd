extends Node


onready var __board = self.get_node('Map')

export var window_zoom = 1

func _ready():
	randomize()
	self.__board.fetch_tiles('res://Scenes/TileSet.tscn', 'Water')
	self.__board.make_board()
	self.__init_ui()
	self.__set_screen()
	self.start()

func start():
	pass

func __init_ui(): 
	pass

func __set_screen():
	var grid_size = self.__board.size
	var x = grid_size.x + ((grid_size.x - 1) / 2)
	var y = grid_size.y + (grid_size.y - 1)
	var board_size = Vector2(x,y) * self.__board.tile_collection.tile_size
	
	var stretch_mode = SceneTree.STRETCH_MODE_2D
	var aspect_mode = SceneTree.STRETCH_ASPECT_KEEP
	
	self.get_tree().set_screen_stretch(stretch_mode, aspect_mode, board_size)
	
	OS.set_window_size(self.window_zoom * board_size)