extends Camera

onready var game_board = self.get_owner().get_owner().get_node("GameBoard")
onready var pathfinder = game_board.get_node("Pathfinder")
onready var player_actions = game_board.get_node("PlayerActions")
onready var rounds = game_board.get_node("Rounds")

onready var accessible_tile_mat = load('res://Assets/Materials/TileAccessible.tres')
onready var not_accessible_tile_mat = load('res://Assets/Materials/TileNotAccessible.tres')

onready var player_can_move_to_selected_location = true

var player_select_tile_for_movement = false
var current_focused_node
var path:Array

func _ready():
	pass 

func clear_highlighted_path():
	for tile in game_board.get_node("Tiles").get_children():
		var highlight = tile.get_node("Highlight")
		#TODO: why does sometimes we get a tile with no children?
		if highlight : highlight.visible = false

func _input(event):
	if player_select_tile_for_movement and rounds.turn_order.size() > 0:
		var tap = get_viewport().get_mouse_position()
		var from = self.project_ray_origin(tap)
		var to = from + self.project_ray_normal(tap) * 10000
		var space_state = get_world().direct_space_state
		
		var hovered_node = space_state.intersect_ray(from, to, [], 1).get("collider")
		if !hovered_node: 
			clear_highlighted_path()
			current_focused_node = null
		
		if current_focused_node != hovered_node:
			clear_highlighted_path()
			path = []
			current_focused_node = hovered_node
			
			var moving_entity_node = rounds.get_active_entity().get_current_tile()
			path = pathfinder.find_path(moving_entity_node,hovered_node)
			
			
			moving_entity_node.get_node("Highlight").visible = true
			player_can_move_to_selected_location = true
			
			for tile in path:
				var distance = pathfinder.get_distance(moving_entity_node,tile)
				var highlight = tile.get_node("Highlight")
				highlight.visible = true
				
				if distance < player_actions.player_remaining_move:
					highlight.set_material_override(accessible_tile_mat)
				else: 
					player_can_move_to_selected_location = false
					highlight.set_material_override(not_accessible_tile_mat)
		
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed() and player_can_move_to_selected_location:
			if hovered_node: pathfinder.start_moving_entity(hovered_node, "Player")
