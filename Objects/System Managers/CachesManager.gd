class_name CachesManager
extends Node

signal moved_card_out_of_waste(card)

@export var stockpile: Node
@export var wastepile: Node


func _ready():
	stockpile.drew_card.connect(draw_from_stockpile)
	stockpile.drew_last_card.connect(refresh_stockpile_from_waste)
	#Card pick_up /drop signal should be connected



func draw_from_stockpile(card):
#	print_debug("StockPile to WastePile Transfer begin")
#	print_debug(stockpile.cards)
#	print_debug(wastepile.cards)
	
	wastepile.cards.append(card)
	wastepile.reveal_draw()

#	print_debug("StockPile card transferred to WastePile Complete")
#	print_debug(stockpile.cards)
#	print_debug(wastepile.cards)


func refresh_stockpile_from_waste():
	print_debug("Refresh Stock")
	
	#Push all remaining cards from wastepile to stockpile 
	for i in wastepile.cards.size():
		stockpile.cards.push_back(wastepile.cards.pop_back())
	
	#Remove all WastePileDeck children (Cards)
	for card in wastepile.get_children():
		wastepile.remove_child(card)
	
	stockpile.draw()




#func xfer_btwn_caches(from: Object, to: Object, dest_col_idx = null): #[0, null] from Object column 0 but to Object has no nested arrays
#	#This only works if one obj is Array[Card], need to address Array[Array[Card]]
#	#to.cards.append(from.cards.pop_at(from.cards.find(c)))
#	pass
