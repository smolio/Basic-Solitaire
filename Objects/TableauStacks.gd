class_name TableauStacks
extends Control


@export var cards: Array[Card]
@export var arranged_stacks: Array[Array]

@export var margins: CardLayoutMargins
#@export var tabl: TableauDataStruct


#Any time a facedown card within a tableau stack is revealed / last in stack, make it flippable and change mouse_filter to STOP
#Card Tells TableauManager to move it from stack(n) to stack(n) / also move_child to the "front" of the stack
#Doesn't look like nodes share resources across instances - reconstruct this

func _ready():
	#arrange_tableau()
	#setup_table()
	pass


func arrange_tableau():
	#For each column
	for col in range(7):
		arranged_stacks.append([])
		#Increase each stack size by one
		for card in range(col+1):
			arranged_stacks[col].append(cards.pop_back())
			#cards[i].append(cards.pop_back())
		arranged_stacks[col].back().face = Card.FACEUP
		arranged_stacks[col].back().focus_mode = Control.FOCUS_CLICK
	print_debug(arranged_stacks)


func setup_table():
	var x = margins.play_area_left_margin
		# Setup tableau area
	for stack in range(arranged_stacks.size()):
		var y = margins.play_area_top_margin + margins.card_length + margins.row_distance
		#For each card in a stack in Tableau
		for card in arranged_stacks[stack]:
			card.set_position(Vector2(x, y))
			add_child(card)
			y += margins.card_stack_margin
		x += margins.card_width + margins.column_distance


func change_stacks():
	pass
