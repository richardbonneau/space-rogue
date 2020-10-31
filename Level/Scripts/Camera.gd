extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		var tap = get_viewport().get_mouse_position()
		var from = self.project_ray_origin(tap)
		var to = from + self.project_ray_normal(tap) * 10000
		var space_state = get_world().direct_space_state
		print(space_state.intersect_ray(from, to, [], 1).get("collider"))


