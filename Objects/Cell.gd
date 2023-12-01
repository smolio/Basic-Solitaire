class_name Cell
extends TextureRect

enum {CELL_1, CELL_2, CELL_3, CELL_4, CELL_5, CELL_6, CELL_7}

@export var margins: CardLayoutMargins
@export var message: String

class FoundationCell:
	extends Cell
	var suit

	func _ready():
		message = "New FoundationCell"
		#print_debug(message)

class TableauCell:
	extends Cell
	
	func _ready():
		message = "New TableauCell"
		#print_debug(message)
	

var value: int
var ordinal: int


func _init():
	self.margins = load("res://Objects/Resources/DefaultMargins.tres")
	self.texture = load("res://Assets/Cards/cell.png")
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _ready():
	self.size = Vector2(margins.card_width, margins.card_length)
