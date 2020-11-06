extends Spatial

onready var player = self.get_owner().get_owner().get_node("GameBoard").get_node("Player")
onready var is_key_pressed = false

func _process(delta):
	camera_movement(delta)

func camera_movement(var delta):
	if is_key_pressed:
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
		var player_origin = player.get_global_transform().origin
		var camera_origin = self.get_global_transform().origin
		player_origin = Vector3 (player_origin.x,camera_origin.y,player_origin.z)
		
		var offset = player_origin - camera_origin
		var distance_between_camera_and_player = offset.length()
		
		if distance_between_camera_and_player < 12: translation += move_vec * delta * screen_scroll_speed
		else : self.global_translate(offset.normalized() * screen_scroll_speed * delta)
		
		
		#Rotation
		if Input.is_action_pressed("q"):
			rotation_degrees.y += delta * screen_scroll_speed * 20
		elif Input.is_action_pressed("e"):
			rotation_degrees.y -= delta * screen_scroll_speed * 20
		elif move_vec == Vector3(0,0,0):
			is_key_pressed = false
		


func _input(event):
	if event is InputEventKey: 
		if event.pressed: is_key_pressed = true
	
	if event is InputEventMouseButton:
		event as InputEventMouseButton
		
		if event.pressed:
			var current_pos = self.get_translation()
			
			match event.button_index:
				BUTTON_WHEEL_UP:
					if current_pos.y > 3: set_translation(Vector3(current_pos.x,current_pos.y - .2 , current_pos.z))
					
				BUTTON_WHEEL_DOWN:
					if current_pos.y < 10: set_translation(Vector3(current_pos.x,current_pos.y + .2 , current_pos.z))
				
	
