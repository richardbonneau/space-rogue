extends Spatial

func _process(delta):
	camera_movement(delta)

func camera_movement(var delta):
	var screen_edge_threshold = 10
	var screen_scroll_speed = 5
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_size = get_viewport().size
	var move_vec = Vector3()
	
	#Movements
	if mouse_pos.y < screen_edge_threshold or Input.is_action_pressed("up"):
		move_vec -= transform.basis.z
	if mouse_pos.y > screen_size.y - screen_edge_threshold or Input.is_action_pressed("down"):
		move_vec += transform.basis.z
	if mouse_pos.x < screen_edge_threshold or Input.is_action_pressed("left"):
		move_vec -= transform.basis.x
	if mouse_pos.x < screen_edge_threshold or Input.is_action_pressed("right"):
		move_vec += transform.basis.x
	
	move_vec = move_vec.normalized()
	translation += move_vec * delta * screen_scroll_speed
	
	#Rotation
	if Input.is_action_pressed("q"):
		rotation_degrees.y += delta * screen_scroll_speed * 20
	elif Input.is_action_pressed("e"):
		rotation_degrees.y -= delta * screen_scroll_speed * 20


func _input(event):
	if event is InputEventMouseButton:
		event as InputEventMouseButton
		
		if event.pressed:
			var current_pos = self.get_translation()
			
			match event.button_index:
				BUTTON_WHEEL_UP:
					if current_pos.y > 3: set_translation(Vector3(current_pos.x,current_pos.y - .2 , current_pos.z))
					
				BUTTON_WHEEL_DOWN:
					if current_pos.y < 10: set_translation(Vector3(current_pos.x,current_pos.y + .2 , current_pos.z))
				
	
