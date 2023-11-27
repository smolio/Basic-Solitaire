class_name TableauDataStruct
extends CardCache

#Tableau should be initialized with 28 cards that get divided into 7 inner stacks

var columns: Array = []


func _init(collection: Array):
	cards.assign(collection)
	divide_tableau()


func divide_tableau():
	#For each column
	for col in range(7):
		columns.append([])
		#Increase each stack size by one
		for card in range(col+1):
			columns[col].append(cards.pop_back())
			#cards[i].append(cards.pop_back())
		columns[col].back().face = Card.FACEUP
		columns[col].back().focus_mode = Control.FOCUS_CLICK
		
	
	#52 - 28(Tableau) = 24 Remaining for Stock
	#Initialize Tableau
	#Tableau.new(tableau)
