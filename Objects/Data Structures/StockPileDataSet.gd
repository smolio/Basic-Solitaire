class_name StockDataStruct
extends CardCache

func _init(collection: Array):
	cards.assign(collection)
	#return self

func transfer_to_waste():
	#CM.wastepile.cards.append(cards[-1])
	pass
