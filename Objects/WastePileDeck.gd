class_name WastePileDeck
extends Control

@export var cards: Array
@export var margins: CardLayoutMargins


func _ready():
	CardManager.dropped_card.connect(pass_to_tableau)
	set_position(Vector2(margins.play_area_left_margin, margins.play_area_top_margin) + Vector2(margins.card_width + margins.column_distance, 0))

#Issue: If WastePile card is dragged to a non-stacking destination, it snaps back to the origin of the screen, not the origin of the parent node
#The cancelled drag didn't send it back to WastePile, it's still in TableauStacks

func reveal_draw():
	if cards.size() > 0:
		var next = cards[-1]
		
		next.face = Card.FACEUP
		next.focus_mode = Control.FOCUS_CLICK
		if !next.is_inside_tree():
			add_child(next)

func pass_to_tableau(from, to):
	if from.get_parent() == self:
		remove_child(cards[-1])
		CardManager.waste_card_waiting = cards.pop_back()

