class_name CardLayoutMargins
extends Resource

#Create a Resource of CardLayoutMargins? 
# CardWidth = 57 ; CardLength = 75 ; CardStackMargin = 15 ; FoundationRowAxis = 39 ; TableauRowYAxis = 130 ; TableauColXAxis = 77 ; LeftMargin = 20
#To create moveable outlines on the table, create a transparent CardOutline file and import a pure green background

#Distance from left side of screen to left edge of 1st column card - X-Axis
@export var card_width: int 
@export var card_length: int 

@export var card_stack_margin: int

@export var play_area_left_margin: int
@export var play_area_top_margin: int 

@export var tableau_top_margin: int
