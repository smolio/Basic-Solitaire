extends Control

@export var margins: CardLayoutMargins
@export var tabl: TableauDataStruct


#Any time a facedown card within a tableau stack is revealed / last in stack, make it flippable and change mouse_filter to STOP
#Card Tells TableauManager to move it from stack(n) to stack(n) / also move_child to the "front" of the stack
#Doesn't look like nodes share resources across instances - reconstruct this

func _ready():
	pass


func setup_table():
	var x = margins.play_area_left_margin
		# Setup tableau area
	for stack in range(tabl.columns.size()):
		var y = margins.play_area_top_margin + margins.card_length + margins.row_distance
		#For each card in a stack in Tableau
		for card in tabl.columns[stack]:
			card.set_position(Vector2(x, y))
			add_child(card)
			y += margins.card_stack_margin
		x += margins.card_width + margins.column_distance


func change_stacks():
	pass
