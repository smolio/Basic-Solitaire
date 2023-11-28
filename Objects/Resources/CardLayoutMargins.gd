class_name CardLayoutMargins
extends Resource


var _card_width: int
@export var card_width: int:
	get: return _card_width
	set(value): _card_width = value; calculate_screen_size()

var _card_length: int
@export var card_length: int:
	get: return _card_length
	set(value): _card_length = value; calculate_screen_size()

#Distance from left side of screen to left edge of 1st column card - (x,0)
var _play_area_left_margin: int
@export var play_area_left_margin: int:
	get: return _play_area_left_margin
	set(value): _play_area_left_margin = value; calculate_screen_size()

#Distance from top of screen to top edge of 1st row of cards - (0, y)
var _play_area_top_margin: int
@export var play_area_top_margin: int:
	get: return _play_area_top_margin
	set(value): _play_area_top_margin = value; calculate_screen_size()

#Distance between rows of cards
var _row_distance: int
@export var row_distance: int:
	get: return _row_distance
	set(value): _row_distance = value; calculate_screen_size()

#Distance between columns of cards
var _column_distance: int
@export var column_distance: int:
	get: return _column_distance
	set(value): _column_distance = value; calculate_screen_size()

#Distance between two cards that are stacked on top of each other
var _card_stack_margin: int
@export var card_stack_margin: int:
	get: return _card_stack_margin
	set(value): _card_stack_margin = value; calculate_screen_size()

#Minimum Screen Size to prevent object cutoffs
@export var min_screen_width: int 
@export var min_screen_length: int


func calculate_screen_size():
	min_screen_width = (2 * _play_area_left_margin) + (7 * _card_width) + (6 * _column_distance) # (x,0) value
	min_screen_length = (2 * _play_area_top_margin) + (2 * _card_length) + (12 * _card_stack_margin) + _row_distance # (0,y) value
