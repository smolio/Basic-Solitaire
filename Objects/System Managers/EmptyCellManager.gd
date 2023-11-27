class_name CellManager
extends Node

@export var margins: CardLayoutMargins
@export var cell: TextureRect

func _ready():
	setup_cells()

func setup_cells():
	var x = margins.play_area_left_margin
	# Setup Columns
	for column in range(7):
		var y = margins.play_area_top_margin
		
		#Setup Rows in Each Column
		for row in range(2):
			#Skip Cell (2,0)
			if column == 2 and row == 0:
				pass
			else:
				cell = TextureRect.new()
				cell.mouse_filter = Control.MOUSE_FILTER_IGNORE
				cell.texture = load("res://Assets/Cards/cell.png")
				cell.set_position(Vector2(x, y))
				add_child(cell)
			y += margins.card_length + margins.row_distance
		x += margins.card_width + margins.column_distance
