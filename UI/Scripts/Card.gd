extends Panel

var drag_position = null
onready var position_before_drag = self.rect_position
export var neighbour_push: =0.75
onready var hand_width_margin := rect_size.x * 2
onready var bottom_margin:=  rect_size/2

enum {
	InHand
	AboutToBePlayed
	InPlay
}
var state := InHand
var start_position: Vector2
var target_position: Vector2
var focus_completed: bool = false

func _ready():
	pass


func _on_Card_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			drag_position = get_global_mouse_position() - rect_global_position
			position_before_drag = self.rect_position
		else: 
			drag_position = null
			self.rect_position = position_before_drag
			if state == AboutToBePlayed:
				state = InPlay
				var pathfinder = self.get_owner().get_owner().get_node("GameBoard").get_node("Pathfinder")
				pathfinder.play_card({"type": "move", "value": 1})
				
				#TODO: Drag and drop cards directly to the battlefield
				var parent:Node = self.get_parent()
				parent.remove_child(self)
				parent.get_parent().reorganize_hand()
				self.queue_free()
	
	if event is InputEventMouseMotion and drag_position:
		rect_global_position = get_global_mouse_position() - drag_position
		if rect_global_position.y < 400:
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
	print("mouse entered")
	var node_new_style = self.get_stylebox("panel").duplicate()
	node_new_style.set_border_color(Color("fff"))
	self.add_stylebox_override("panel", node_new_style)


func _on_Card_mouse_exited():
	var node_new_style = self.get_stylebox("panel").duplicate()
	node_new_style.set_border_color(Color("000"))
	self.add_stylebox_override("panel", node_new_style)
