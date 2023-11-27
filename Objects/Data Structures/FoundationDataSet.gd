class_name FoundationDataStruct
extends CardCache

var assigned_suit

var columns: Array = []

func _init():
	for c in range(4):
		columns.append([])
		
#Each stack should have an "assigned" suit for the first card it intakes
