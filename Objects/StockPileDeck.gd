#class_name StockPileDeck
extends Control

enum {DECKFACE, RECYCLESTOCK}

signal drew_card(card)
signal drew_last_card

@export var margins: CardLayoutMargins
@export var deck: StockDataStruct

func _ready():
	set_position(Vector2(margins.play_area_left_margin, margins.play_area_top_margin))
	
	#DEBUG IN INDIVIDUAL SCENE
	if deck == null:
		deck = StockDataStruct.new([Card.new()])


func _gui_input(event):
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			draw()
			print_debug("StockPile clicked")
			pass


func draw():
	if deck.cards.size() > 0:
		$ImageFrames.set_frame(DECKFACE)
		drew_card.emit(deck.cards.pop_back())
		if deck.cards.size() == 0:
			$ImageFrames.set_frame(RECYCLESTOCK)
			drew_last_card.emit()
