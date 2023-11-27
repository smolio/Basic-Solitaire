class_name Card
extends Control

const select_scn = preload("res://Commands/SelectAction.tscn")
const move_scn = preload("res://Commands/MoveAction.tscn")

#Constants
enum {FACEDOWN, FACEUP}
enum suit_color {RED, BLACK}

#Properties
var suit: String
var color: int
var value: int
var face: int:
	set = set_face

#State
var selected: bool = false
var condition: Dictionary = {
	"flippable": false,
	"selectable": false,
	"draggable": false
}

#var card_attr = ["spade", "K", FACEUP]

#Card should be initialized with a suit, value, and face position
func setup(card_attr: Array):
	
	#Set the suit
	self.suit = card_attr[0]
	
	#Set color based on suit
	match card_attr[0]:
		"spade","club":
			self.color = suit_color.BLACK
		"diamond","heart":
			self.color = suit_color.RED
	
	#Set integer value
	match card_attr[1]:
		"A":
			self.value = 1
		"J":
			self.value = 11
		"Q":
			self.value = 12
		"K":
			self.value = 13
		_:
			self.value = int(card_attr[1])
	
	#Set the face position
	self.face = card_attr[2]


func _ready():
	#Initialize the images and set the initial face position
	#$ImageFrames.sprite_frames.add_frame("default", load("res://Assets/Cards/facedown.png"))
	$ImageFrames.sprite_frames.add_frame("default", load("res://Assets/Cards/%s/%s_%d.png" % [suit, suit, value]))
	$ImageFrames.set_frame(face)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		self.release_focus()


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if (get_global_rect().has_point(event.global_position)):
				self.grab_focus()
		elif condition.flippable:
			self.flip()
#		elif !(get_global_rect().has_point(event.global_position)):
#			self.release_focus()
		elif self.has_focus():
			log_select_command(self)
			log_move_command(self)


func _on_focus_entered():
	selected = true
	$Outline.show()


func _on_focus_exited():
	selected = false
	$Outline.hide()


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


func _can_drop_data(position, data):
	if data is Card: #Or Card Stack?
		return data


func _drop_data(position, data):
	pass
	#should join stack
	#emit object that CardStack is dropped onto?
	#data.set_modulate(Color(1,1,1,1))
	#data.state.dragging = false



func log_select_command(target):
	var new_select_command = select_scn.instantiate()
	self.add_child(new_select_command)
	print_debug(target)


func log_move_command(target):
	var new_move_command = move_scn.instantiate()
	self.add_child(new_move_command)
	print_debug(target)


func flip():
	#if self.condition.flippable:
	self.face = FACEUP
#	$ImageFrames.frame = FACEUP
#	condition.flippable = false
#	condition.draggable = true


func set_face(new_value):
	face = new_value
	match face:
		FACEUP:
			$ImageFrames.set_frame(FACEUP)
			condition.draggable = true
			condition.flippable = false
		FACEDOWN:
			condition.draggable = false
			condition.flippable = true
#Make a setter for face, so that anytime face is set to FACEUP, the card's flippable and draggable states change along with it, also focus_mode


