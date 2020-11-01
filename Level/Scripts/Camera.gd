extends Camera

onready var game_board = self.get_owner().get_owner().get_node("GameBoard")
var enable_debug_tile_clicks = false
var current_focused_node
var path:Array

func _ready():
	pass # Replace with function body.

func clear_highlighted_path():
	for tile in path:
		tile.get_node("Highlight").visible = false


func _input(event):
	if enable_debug_tile_clicks:
		var tap = get_viewport().get_mouse_position()
		var from = self.project_ray_origin(tap)
		var to = from + self.project_ray_normal(tap) * 10000
		# TODO: Make sure it only hits tiles, by using either groups or mask/colliders
		var space_state = get_world().direct_space_state
		
		var hovered_node = space_state.intersect_ray(from, to, [], 1).get("collider")
		if !hovered_node: 
			clear_highlighted_path()
			current_focused_node = null
		
		if current_focused_node != hovered_node:
			clear_highlighted_path()
			path = []
			current_focused_node = hovered_node
			
			var player_node = game_board.get_node("Player").get_current_tile()
			path = game_board.get_node("Pathfinder").find_path(player_node,hovered_node)
			for tile in path:
				tile.get_node("Highlight").visible = true
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
			game_board.start_moving_entity(hovered_node)




