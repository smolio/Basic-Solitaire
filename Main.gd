extends Node

signal initialized_collections

@export var margins: CardLayoutMargins
@export var CM: Node
@export var SM: Node

var suits: Array = ["spade", "diamond", "club", "heart"]
var values: Array = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"]

var full_deck: Array = []

var pckd_card = preload("res://Objects/Card.tscn")


func _ready():
	initialize_deck()
	initialize_caches()

	#Add Cards to Scene - Call setup_table() for Tableau
	$StacksManager/TableauStacks.call("setup_table")

func initialize_deck():
	full_deck.clear()
	randomize()
	
	#For each suit
	for i in range(4):
		#For each value in suit
		for j in range(13):
			var new_card = pckd_card.instantiate()
			new_card.setup([suits[i],values[j],Card.FACEDOWN])
			full_deck.append(new_card)
	full_deck.shuffle()

func initialize_caches():
	CM.stockpile.deck = initialize_collection(StockDataStruct, 24)
	SM.tableau.tabl = initialize_collection(TableauDataStruct, 28)
	SM.foundations.foundation = initialize_collection(FoundationDataStruct, 0)
	CM.wastepile.pile = initialize_collection(WasteDataStruct, 0)
	initialized_collections.emit()


func initialize_collection(collection_type: Object, number: int):
	var cards = []
	
	for i in range(number):
		cards.append(full_deck.pop_back())
	#ResourceSaver.save(coll, "res://Cache/%s.tres" % collection_type)
	if cards.size() > 0:
		return collection_type.new(cards)
	else:
		return collection_type.new()

