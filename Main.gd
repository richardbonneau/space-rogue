extends Node

var held_object = null






func _on_Deck_mouse_exited():
	print("leaving deck",held_object)
	if held_object:
		
		held_object.color = "#43ce03"
	
	
