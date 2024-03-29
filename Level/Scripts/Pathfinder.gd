extends Node

var destination_tile
var path
var last_entity_rotation
var entity_origin
var destination_origin
var active_entity_type
var last_tile
var next_tile

onready var game_board = get_owner()
onready var rounds = game_board.get_node("Rounds")
onready var player_actions = game_board.get_node("PlayerActions")
onready var camera = self.get_parent().get_node("CameraHolder").get_child(0)

onready var entity_is_moving: bool = false
onready var path_index = 0
onready var movement_stop_thresold: float = 0.1
onready var move_speed = 500


func _process(delta):
	if entity_is_moving: move_entity(delta)

func start_moving_entity(destTile, type):
	active_entity_type = type
	camera.player_select_tile_for_movement = false
	rounds.get_active_entity().get_node("AnimationPlayer").play("Moving")
	destination_tile = destTile
	var entity_tile = rounds.get_active_entity().get_current_tile()
	destination_origin = destTile.get_global_transform().origin
	
	path = find_path(entity_tile, destTile)
	last_tile = entity_tile
	next_tile = entity_tile
	entity_tile.taken = false
	destTile.taken = true
	entity_is_moving = true

func move_entity(delta):
	if path.size() < 1: 
		_done_moving()
		return
	
	#REFACTOR: some of these variables could probably be only set once in a while in the following if statement, instead of every frame
	entity_origin = rounds.get_active_entity().get_global_transform().origin
	next_tile = path[path_index]
	var next_tile_origin = next_tile.get_global_transform().origin
	var this_move_cost = self.get_distance(last_tile,next_tile)
	var offset = next_tile_origin  - entity_origin
	var distance_to_destination = offset.length()

	rounds.get_active_entity().look_at(next_tile_origin, Vector3(0,1,0))
	rounds.get_active_entity().move_and_slide(offset.normalized() * move_speed * delta)
	
	last_entity_rotation = rounds.get_active_entity().get_rotation()
	if distance_to_destination < movement_stop_thresold:
		last_tile = next_tile
		next_tile = path[path_index]
		if active_entity_type == "Player": player_actions.player_remaining_move -= this_move_cost
		#Switch to next node to move to
		if path_index < path.size() - 1: 
			path_index+=1
		#If last node then :
		else: _done_moving()

func _done_moving():
	camera.player_select_tile_for_movement = false
	camera.clear_highlighted_path()
	rounds.get_active_entity().get_node("AnimationPlayer").play("Idle")
	rounds.get_active_entity().set_rotation(Vector3(0,last_entity_rotation.y,0))
	entity_is_moving = false
	rounds.get_active_entity().set_global_transform(destination_tile.get_global_transform())
	path = null
	path_index = 0
	active_entity_type = null

func get_distance(var tile_a, var tile_b):
	var tile_a_origin = tile_a.get_global_transform().origin
	var tile_b_origin = tile_b.get_global_transform().origin
	var dst_x = abs(tile_a_origin.x - tile_b_origin.x)
	var dst_z = abs(tile_a_origin.z - tile_b_origin.z)
	
	if dst_x > dst_z:
		return 14 * dst_z + 10 * (dst_x - dst_z)
	else:
		return 14 * dst_x + 10 * (dst_z - dst_x)

func find_path(var start_tile, var dest_tile):
	var open_nodes:Array = []
	var closed_nodes:Array = []
	open_nodes.append(start_tile)
	while(open_nodes.size() > 0):
		var lowest_cost_node = open_nodes[0]
		for node in open_nodes:
			if node.get_f_cost() <= lowest_cost_node.get_f_cost() and node.h_cost < lowest_cost_node.h_cost:
				lowest_cost_node = node
		
		open_nodes.erase(lowest_cost_node)
		closed_nodes.append(lowest_cost_node)
		
		if lowest_cost_node == dest_tile:
			path = []
			var current_node = dest_tile
			while current_node != start_tile:
				path.append(current_node)
				current_node = current_node.parent
			path.invert()
			return path
		
		var neighbours = lowest_cost_node.get_neighbours()
		for neighbour in neighbours:
			if closed_nodes.has(neighbour) or neighbour.taken: continue
			var new_cost_to_neighbour = lowest_cost_node.g_cost + get_distance(lowest_cost_node,neighbour)
			var open_nodes_contains_neighbour = open_nodes.has(neighbour)
			
			if new_cost_to_neighbour < neighbour.g_cost or !open_nodes_contains_neighbour:
				neighbour.g_cost = new_cost_to_neighbour
				neighbour.h_cost = get_distance(neighbour, dest_tile)
				neighbour.parent = lowest_cost_node
				
				if !open_nodes_contains_neighbour:
					open_nodes.append(neighbour)
	return []

