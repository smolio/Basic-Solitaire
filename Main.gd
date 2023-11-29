extends Node

signal initialized_collections

@export var margins: CardLayoutMargins
@export var CM: Node
@export var SM: Node
@export var TM: Node


enum gamestate {NEW_GAME, LOAD_GAME}

var suits: Array = ["spade", "diamond", "club", "heart"]
#var values: Array = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"]

var full_deck: Array = []

var pckd_card = preload("res://Objects/Card.tscn")

#var viewport_height = ProjectSettings.get_setting("display/window/size/viewport_height")
#var viewport_width = ProjectSettings.get_setting("display/window/size/viewport_width")
#var project_aspect_ratio = viewport_height / viewport_width
#var project_aspect_ratio =  Vector2i(viewport_width, viewport_height).aspect()
#const project_aspect_ratio = 600.0 / 560.0

#NEXT THING TO TACKLE: Move card collection data structures out of resource objects and into base node itself


func _ready():
	print_debug(margins.min_screen_width)
	print_debug(margins.min_screen_length)
	
	get_window().set_min_size(Vector2i(margins.min_screen_width, margins.min_screen_length))
	#get_window().size_changed.connect(set_window_aspect_ratio)
	
	initialize_deck()
	initialize_caches()
	
	print_debug(TM.tableau.cards)
	TM.tableau.call("setup_table")
	#Add Tableau Cards to Scene
	#$TableauManager/TableauStacks.call("setup_table")


#func set_window_aspect_ratio():
#	print("size_changed")
#	get_window().size = Vector2i(get_window().size.x, get_window().size.x * project_aspect_ratio)

func initialize_deck():
	full_deck.clear()
	randomize()
	
	#For each suit
	for i in range(4):
		#For each value in suit
		for j in range(13):
			var new_card = pckd_card.instantiate()
			new_card.setup([suits[i],j,Card.FACEDOWN])
			full_deck.append(new_card)
	full_deck.shuffle()


func initialize_caches():
	initialize_collection(24, CM.stockpile)
	initialize_collection(28, TM.tableau)
	initialize_collection(0, SM.foundations)
	initialize_collection(0, CM.wastepile)

func initialize_collection(number: int, child: Node):
	var _cards: Array[Card] = []
	
	for i in range(number):
		_cards.append(full_deck.pop_back())
	
	child.cards.assign(_cards)
	if child is TableauStacks:
		child.arrange_tableau()
	print_debug(child)
	print_debug(child.cards)
	initialized_collections.emit()


func save_game():
	#ResourceSaver.save(coll, "res://Cache/%s.tres" % collection_type)
	
	#Need to include a way to skip initialization if loading a saved game
	pass


func reset_game():
	#free children and re-initialize deck and caches
	pass
