extends Control

@export var margins: CardLayoutMargins
@export var tabl: TableauDataStruct


func setup_table():
	var x = margins.play_area_left_margin
		# Setup tableau area
	for stack in range(tabl.columns.size()):
		var y = margins.tableau_top_margin
		#For each card in a stack in Tableau
		for card in tabl.columns[stack]:
			card.set_position(Vector2(x, y))
			add_child(card)
			y += margins.card_stack_margin
		x += 77
