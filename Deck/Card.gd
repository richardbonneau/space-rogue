extends Panel

var drag_position = null
var position_before_drag = null

export var neighbour_push: =0.75
onready var hand_width_margin := rect_size.x * 2
onready var bottom_margin:=  rect_size/2

enum{
	InHand
	InPlay
	AboutToBePlayed
}
var state := InHand
var start_position: Vector2
var target_position: Vector2
var focus_completed: bool = false

func _ready():
	position_before_drag = self.rect_position




func _on_Card_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			print("pressed")
			drag_position = get_global_mouse_position() - rect_global_position
			position_before_drag = self.rect_position
			get_owner().held_object = self
		else: 
			drag_position = null
			self.rect_position = position_before_drag
			if state == AboutToBePlayed:
				var parent:Node = self.get_parent()
				parent.remove_child(self)
				parent.reorganize_scroll_hand()
				self.queue_free()
	
	if event is InputEventMouseMotion and drag_position:
		rect_global_position = get_global_mouse_position() - drag_position
		if rect_global_position.y < 900:
			var node_new_style = self.get_stylebox("panel").duplicate()
			node_new_style.set_border_color(Color("#29be05"))
			self.add_stylebox_override("panel", node_new_style)
			state = AboutToBePlayed
		else:
			var node_new_style = self.get_stylebox("panel").duplicate()
			node_new_style.set_border_color(Color("fff"))
			self.add_stylebox_override("panel", node_new_style)
			state = InHand
			


func _on_Card_mouse_entered():
	var node_new_style = self.get_stylebox("panel").duplicate()
	node_new_style.set_border_color(Color("fff"))
	self.add_stylebox_override("panel", node_new_style)


func _on_Card_mouse_exited():
	var node_new_style = self.get_stylebox("panel").duplicate()
	node_new_style.set_border_color(Color("000"))
	self.add_stylebox_override("panel", node_new_style)