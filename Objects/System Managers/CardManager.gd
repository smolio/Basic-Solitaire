extends Node

signal picked_up_card(card: Card)
signal dropped_card(source_card: Card, dest_card: Card)

signal moved_from_waste_to_tableau
signal moved_card_stack

var waste_card_waiting


