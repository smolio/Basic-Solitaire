class_name TableauStacks
extends Control



@export var cards: Array[Card]
@export var arranged_stacks: Array[Array]

@export var margins: CardLayoutMargins
#@export var tabl: TableauDataStruct

var waste_card: Card

enum {A=1, B, C, D, E, F, G}

#Any time a facedown card within a tableau stack is revealed / last in stack, make it flippable and change mouse_filter to STOP
#Card Tells TableauManager to move it from stack(n) to stack(n) / also move_child to the "front" of the stack
#move_child(-1) OR Card.z_index = dest_stack.size() + 1
#Doesn't look like nodes share resources across instances - reconstruct this

func _ready():
	#arrange_tableau()
	#setup_table()
	CardManager.picked_up_card.connect(pick_up)
	CardManager.dropped_card.connect(change_stacks)


func print_card_data():
	for column in arranged_stacks:
		for card in column:
			print_debug(card.suit + str(card.value))
			print_debug(card.stack_coords)
			print_debug(card.z_index)


func arrange_tableau():
	#For each column
	for col in range(7):
		arranged_stacks.append([])
		#Increase each stack size by one
		for card in range(col+1):
			arranged_stacks[col].append(cards.pop_back())
			arranged_stacks[col][card].stack_coords = Vector2i(col,card)
			arranged_stacks[col][card].z_index = arranged_stacks[col].size()
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


func pick_up(card: Card):
	pass

func change_stacks(from, to): #From ColA to ColC From 1 to 3
	var starting_card
	if from.get_parent() != self && CardManager.waste_card_waiting != null:
		#CardManager.moved_from_waste_to_tableau.emit(self)
		starting_card = CardManager.waste_card_waiting
		
	if to.get_parent() != self:
		print_debug("Card is not going to a Card within TableauStacks")
	var source = from.stack_coords
	var dest = to.stack_coords
	#arranged_stacks[dest.x][dest.y].pop_at(arranged_stacks[source.x][source.y])
	
	if starting_card == null:
		starting_card = arranged_stacks[source.x].pop_at(source.y)
	arranged_stacks[dest.x].insert(dest.y + 1, starting_card)
	if starting_card.get_parent() == null:
		add_child(starting_card)
	
	for card_position in range(arranged_stacks[dest.x].size()):
		arranged_stacks[dest.x][card_position].stack_coords = Vector2i(dest.x,card_position)
		arranged_stacks[dest.x][card_position].z_index = card_position+1
	CardManager.moved_card_stack.emit()
