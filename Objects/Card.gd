class_name Card
extends Control

signal dropped_card
signal picked_up_card

const select_scn = preload("res://Commands/SelectAction.tscn")
const move_scn = preload("res://Commands/MoveAction.tscn")

@export var margins: CardLayoutMargins

#Constants
enum {FACEDOWN, FACEUP}
enum suit_color {RED, BLACK}

#Attributes
var suit: String
var color: int
var value: int
var face: int:
	set = set_face

#State
var selected: bool = false
var current_frame_tex: Texture2D
var condition: Dictionary = {
	"flippable": false,
	"selectable": false,
	"draggable": false
}

#var card_attr = ["spade", "K", FACEUP]

#Card should be initialized with a suit, value, and face position
func setup(card_attr: Array) -> void:
	
	#Set the suit
	self.suit = card_attr[0]
	
	#Set color based on suit
	match card_attr[0]:
		"spade","club":
			self.color = suit_color.BLACK
		"diamond","heart":
			self.color = suit_color.RED
	
	#Set the card value (#1 - #13)
	self.value = card_attr[1] + 1
#	#Set integer value
#	match card_attr[1]:
#		"A":
#			self.value = 1
#		"J":
#			self.value = 11
#		"Q":
#			self.value = 12
#		"K":
#			self.value = 13
#		_:
#			self.value = int(card_attr[1])
	
	#Set the face position
	self.face = card_attr[2]


func _ready():
	#Initialize the images and set the initial face position
	$ImageFrames.sprite_frames.add_frame("default", load("res://Assets/Cards/%s/%s_%d.png" % [suit, suit, value]))
	$ImageFrames.set_frame(face)
	current_frame_tex = $ImageFrames.sprite_frames.get_frame_texture("default", face)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		self.release_focus()


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if (get_global_rect().has_point(event.global_position)):
				self.grab_focus()
		elif condition.flippable:
			self.set_face(FACEUP)
#		elif !(get_global_rect().has_point(event.global_position)):
#			self.release_focus()
		elif self.has_focus():
			log_select_command(self)
			log_move_command(self)


func _on_focus_entered() -> void:
	selected = true
	$Outline.show()


func _on_focus_exited() -> void:
	selected = false
	$Outline.hide()


func _get_drag_data(at_position):
	var selected_card: Card = self
	
	#Dragging Preview
	var preview: TextureRect = TextureRect.new()
	preview.texture = selected_card.current_frame_tex
	set_drag_preview(preview)
	
	#Show that the card has started move away from original position
	self.set_modulate(Color(1,1,1,0.5))
	picked_up_card.emit(selected_card)
	return selected_card


func _can_drop_data(at_position, data):
	if data is Card: #Or Array[Card]
		return true


func _drop_data(at_position, picked_up_card):
	if picked_up_card.value + 1 == self.value && picked_up_card.color != self.color:
		
		#Snap card to card
		picked_up_card.position = global_position + Vector2(0, margins.card_stack_margin)
	picked_up_card.set_modulate(Color(1,1,1,1))
	dropped_card.emit(picked_up_card) #Tell TableauManager to move it from stack(n) to stack(n) / also move_child to the "front" of the stack
	#ISSUE: If mouse click release happens out of bounds of Card it goes into the aether
	#Cancelled drag needs to "reset" objects back to state before dragging began
	#Figure out how to create a snap threshold, if two cards overlap, it should snap in place, don't rely on released mouse position


#func _get_drag_data(position):
#	var data = self #How do I incorporate a card stack?
#   var data = CardStack.new(self)
#	#data.state.dragging = true
#   emit_signal("dragging", position) #If CachesManager does not see release state of Card to Tableau/Foundation
#
#	#Get preview data
#	var preview = data.duplicate()
#	preview.setup([data.suit, data.value, data.face])
#	set_drag_preview(preview)
#
#	set_modulate(Color(1,1,1,0.5))
#	return data




	
#func _drop_data(position, data):
#	pass
#	#should join stack
#	#emit object that CardStack is dropped onto?
#	#data.set_modulate(Color(1,1,1,1))
#	#data.state.dragging = false


func log_select_command(target: Card) -> void:
	var new_select_command = select_scn.instantiate()
	self.add_child(new_select_command)
	print_debug(target)


func log_move_command(target: Card) -> void:
	var new_move_command = move_scn.instantiate()
	self.add_child(new_move_command)
	print_debug(target)


func set_face(new_value):
	face = new_value
	current_frame_tex = $ImageFrames.sprite_frames.get_frame_texture("default", face)
	match face:
		FACEUP:
			$ImageFrames.set_frame(FACEUP)
			self.mouse_filter = Control.MOUSE_FILTER_STOP
			condition.draggable = true
			condition.flippable = false
		FACEDOWN:
			condition.draggable = false
			condition.flippable = true
			


