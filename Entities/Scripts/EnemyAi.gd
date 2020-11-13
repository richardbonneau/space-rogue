extends Node

onready var game_board = self.get_parent().get_owner()
onready var entities = self.get_parent().get_parent()
onready var pathfinder = game_board.get_node("Pathfinder")
var player

func _ready():
	pass

func find_player_entity():
	for entity in entities.get_children():
		if entity.type == "Player": player = entity

func ai_start_turn():
	if !player: find_player_entity()
	#move 2 tiles towards player
	var current_node = self.get_parent().get_current_tile()
	var player_node = player.get_current_tile()
	var player_node_neighbours = player_node.get_neighbours()
	
	#Can't move on top of player. Find neighbour node that's closest to us.
	var shortest_path_size = 9999
	var tile_to_move_to
	for tile in player_node_neighbours:
		if tile.taken: continue
		var path = pathfinder.find_path(current_node,tile)
		var path_size = path.size()
		if path_size < shortest_path_size: 
			shortest_path_size = path_size
			tile_to_move_to = tile
	
	pathfinder.start_moving_entity(tile_to_move_to, "Enemy")
