class_name CardCache
extends Resource

enum {COL_1, COL_2, COL_3, COL_4, COL_5, COL_6, COL_7}
#The Base Class for any construct that holds Cards in arrays
var cards: Array[Card]


#add, remove
#func transfer_single(from: Object, to: Object):
#	#Both Objects must inherit CardCollection
#	to.cards.append(from.cards.pop_back())
#	pass
