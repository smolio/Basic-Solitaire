class_name StacksManager
extends Node


@export var foundations: FoundationStacks
@export var tableau: TableauStacks
#@export var waste: Node


#Analyzes the board and "glues" cards together that form a stack
func _ready():
	CardManager.moved_card_stack.connect(check_table)
	

func check_table():
	#Make exposed facedown cards flippable
	for column in tableau.arranged_stacks:
		for card in column:
			if column[-1] == card && card.face == Card.FACEDOWN:
				card.mouse_filter = Control.MOUSE_FILTER_STOP
				card.condition.flippable = true
	
	#Join stacks
