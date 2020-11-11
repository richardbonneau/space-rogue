extends Camera

onready var game_board = self.get_owner().get_owner().get_node("GameBoard")
onready var pathfinder = game_board.get_node("Pathfinder")
onready var rounds = game_board.get_node("Rounds")

var player_select_tile_for_movement = false
var current_focused_node
var path:Array

func _ready():
	pass 


func clear_highlighted_path():
	for tile in game_board.get_node("Tiles").get_children():
		var highlight = tile.get_node("Highlight")
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
			path = pathfinder.find_path(moving_entity_node,hovered_node, "Player")
			moving_entity_node.get_node("Highlight").visible = true
			for tile in path:
				tile.get_node("Highlight").visible = true
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
			if hovered_node: pathfinder.start_moving_entity(hovered_node)





