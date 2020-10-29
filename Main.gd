extends Node

var held_object = null






func _on_Deck_mouse_exited():
	print("leaving deck",held_object)
	if held_object:
		var node_new_style = held_object.get_stylebox("panel").duplicate()
		node_new_style.set_border_color(Color("#43ce03"))
		held_object.add_stylebox_override("panel", node_new_style)
		
	
	



func _on_ScrollContainer_mouse_exited():
	print("exit")
	pass # Replace with function body.
