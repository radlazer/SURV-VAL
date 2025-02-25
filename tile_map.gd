extends TileMap

func _ready():
	set_y_sort_enabled(true)
	set_half_offset(0)
	set_cell_size(Vector2(16, 16))
