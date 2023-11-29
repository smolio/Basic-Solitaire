class_name WastePileDeck
extends Control

@export var cards: Array

@export var margins: CardLayoutMargins
#@export var pile: WasteDataStruct

func _ready():
	set_position(Vector2(margins.play_area_left_margin, margins.play_area_top_margin) + Vector2(margins.card_width + margins.column_distance, 0))


func reveal_draw():
	if cards.size() > 0:
		var next = cards[-1]
		
		next.face = Card.FACEUP
		next.focus_mode = Control.FOCUS_CLICK
		if !next.is_inside_tree():
			add_child(next)
