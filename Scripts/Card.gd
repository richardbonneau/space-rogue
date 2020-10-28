extends TextureRect

var drag_position = null
var position_before_drag = null

func _ready():
	position_before_drag = self.rect_position



func _on_Card_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		print("click event")
		if event.pressed:
			drag_position = get_global_mouse_position() - rect_global_position
		else: 
			drag_position = null
			self.rect_position = position_before_drag
	
	if event is InputEventMouseMotion and drag_position:
		print("motion event")
		rect_global_position = get_global_mouse_position() - drag_position
