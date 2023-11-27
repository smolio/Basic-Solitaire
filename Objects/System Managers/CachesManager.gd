class_name CachesManager
extends Node

signal played_card_into_tableau
signal played_card_into_foundation

@export var stockpile: Node
@export var wastepile: Node


func _ready():
	stockpile.drew_card.connect(draw_from_stockpile)
	stockpile.drew_last_card.connect(refresh_stockpile_from_waste)


func draw_from_stockpile(card):
#	print_debug("StockPile to WastePile Transfer begin")
#	print_debug(stockpile.deck.cards)
#	print_debug(wastepile.pile.cards)
	
	wastepile.pile.cards.append(card)
	wastepile.reveal_draw()

#	print_debug("StockPile card transferred to WastePile Complete")
#	print_debug(stockpile.deck.cards)
#	print_debug(wastepile.pile.cards)


func refresh_stockpile_from_waste():
	print_debug("Refresh Stock")
	
	#Remove all WastePileDeck children (Cards)
	for card in wastepile.get_children():
		wastepile.remove_child(card)
	
	#Push all remaining cards from wastepile data struct to stockpile data struct
	for i in wastepile.pile.cards.size():
		stockpile.deck.cards.push_back(wastepile.pile.cards.pop_back())




#func xfer_btwn_caches(from: Object, to: Object, dest_col_idx = null): #[0, null] from Object column 0 but to Object has no nested arrays
#	#This only works if one obj is Array[Card], need to address Array[Array[Card]]
#	#to.cards.append(from.cards.pop_at(from.cards.find(c)))
#	pass
