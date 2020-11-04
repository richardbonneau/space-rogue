extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	camera_movement(delta)
	

func camera_movement(var delta):
	var screen_edge_threshold = 10
	var screen_scroll_speed = 5
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_size = get_viewport().size
	var move_vec = Vector3()
	
	if mouse_pos.x < screen_edge_threshold or Input.is_action_pressed("left"):
		move_vec.z -= 1
	if mouse_pos.y < screen_edge_threshold or Input.is_action_pressed("up"):
		move_vec.x += 1
	if mouse_pos.x > screen_size.x - screen_edge_threshold or Input.is_action_pressed("right"):
		move_vec.z += 1
	if mouse_pos.y > screen_size.y - screen_edge_threshold or Input.is_action_pressed("down"):
		move_vec.x -= 1
	
	move_vec = move_vec.rotated(Vector3(0,1,0),rotation_degrees.y).normalized()
	global_translate(move_vec * delta * screen_scroll_speed)
