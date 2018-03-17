extends Sprite

var coordinates setget coordinates_set, coordinates_get
var q = 0 setget ,q_get
var r = 0 setget ,r_get
var radius = 55 setget ,radius_get
var vertical_offset setget ,vertical_offset_get

func _ready():
	set_position(self.__pixels())

func coordinates_set(value):
	coordinates = value
	
func coordinates_get():
	return coordinates
	
func q_get():
	return self.coordinates.x
	
func r_get():
	return self.coordinates.y

func vertical_offset_get():
	return int(self.q) % 2 / 2.0
	
func radius_get():
	return self.get_parent().tile_collection.tile_size.x / 2
	
func __pixels():
	var x = self.radius * 3/2 * self.q
	var y = self.radius * sqrt(3) * (self.r + self.vertical_offset) 
	return Vector2(x, y)
	
	
