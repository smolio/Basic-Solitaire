extends Node

signal initialized_collections

@export var margins: CardLayoutMargins
@export var CM: CachesManager
@export var SM: StacksManager
@export var TM: TableauManager


enum gamestate {NEW_GAME, LOAD_GAME}
enum count {STOCK = 24, TABLEAU = 28}

var suits: Array = ["spade", "diamond", "club", "heart"]
#var values: Array = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"]

var pckd_card: PackedScene = preload("res://Objects/Card.tscn")


#var viewport_height = ProjectSettings.get_setting("display/window/size/viewport_height")
#var viewport_width = ProjectSettings.get_setting("display/window/size/viewport_width")
#var project_aspect_ratio = viewport_height / viewport_width
#var project_aspect_ratio =  Vector2i(viewport_width, viewport_height).aspect()
#const project_aspect_ratio = 600.0 / 560.0

#NEXT THING TO TACKLE: Move card collection data structures out of resource objects and into base node itself


func _ready():
	print_debug(margins.min_screen_width)
	print_debug(margins.min_screen_length)
	CM.moved_card_out_of_waste.connect(transfer)
	
	get_window().set_min_size(Vector2i(margins.min_screen_width, margins.min_screen_length))
	#get_window().size_changed.connect(set_window_aspect_ratio)
	
	initialize_caches()
	
	#Add Tableau Cards to Scene
	SM.tableau.call("setup_table")
	SM.tableau.print_card_data()
	


#func set_window_aspect_ratio():
#	print("size_changed")
#	get_window().size = Vector2i(get_window().size.x, get_window().size.x * project_aspect_ratio)

func initialize_deck():
	var _full_deck: Array = []
	randomize()

	#For each suit
	for i in range(4):
		#For each value in suit
		for j in range(13):
			var new_card = pckd_card.instantiate()
			new_card.setup([suits[i],j,Card.FACEDOWN])
			_full_deck.append(new_card)
	_full_deck.shuffle()
	return _full_deck


func initialize_caches():
	var shuffled_deck = initialize_deck()
	var _caches = {
		"stock": [],
		"tableau": []
	}
	
	#Deal cards to each cache
	for card in range(count.TABLEAU):
		_caches.tableau.append(shuffled_deck.pop_back())
	for card in range(count.STOCK):
		_caches.stock.append(shuffled_deck.pop_back())
	
	#Assign cards to the instanced nodes
	for manager in self.get_children():
		if manager.has_node("StockPileDeck"):
			print_debug(str(manager) + " has stockpile")
			manager.stockpile.cards.assign(_caches.stock)
		if manager.has_node("TableauStacks"):
			print_debug(str(manager) + " has tableau")
			manager.tableau.cards.assign(_caches.tableau)
			manager.tableau.arrange_tableau()


func transfer():
	#Receives inputs: Card, destination
	pass
	

func save_game():
	#ResourceSaver.save(coll, "res://Cache/%s.tres" % collection_type)
	
	#Need to include a way to skip initialization if loading a saved game
	pass


func reset_game():
	#free children and re-initialize deck and caches
	pass
