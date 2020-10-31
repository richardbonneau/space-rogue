extends Camera


var enable_debug_tile_clicks = false

func _ready():
	pass # Replace with function body.

func _input(event):
	if enable_debug_tile_clicks and event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		var tap = get_viewport().get_mouse_position()
		var from = self.project_ray_origin(tap)
		var to = from + self.project_ray_normal(tap) * 10000
		# TODO: Make sure it only hits tiles, by using either groups or mask/colliders
		var space_state = get_world().direct_space_state
		
		var clicked_collider = space_state.intersect_ray(from, to, [], 1).get("collider")
		if clicked_collider:
			clicked_collider.logic()


