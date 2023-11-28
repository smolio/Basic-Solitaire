class_name CellManager
extends Node

@export var margins: CardLayoutMargins

func _ready():
	setup_cells()


func setup_cells():
	var y = margins.play_area_top_margin
	
	# Setup Rows
	for row in range(2):
		var x = margins.play_area_left_margin
		
		#Setup Cells in Each Row
		for column in range(7):
			#Skip Cell (3,0)
			if row == 0 and column == 2:
				pass
			else:
				#Create a Cell
				var cell: TextureRect

				#For Cells (4,0) to (7,0) Assign Foundation class
				if row == 0 && column in range(3,7):
					cell = Cell.FoundationCell.new()
				
				#For Cells (1,1) to (7,1) Assign Tableau class
				elif row == 1 && column in range(0,7):
					cell = Cell.TableauCell.new()
				
				else:
					cell = Cell.new()
					
				cell.set_position(Vector2(x, y))
				add_child(cell)
			x += margins.card_width + margins.column_distance
		y += margins.card_length + margins.row_distance
