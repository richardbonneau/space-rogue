extends Spatial

export var movement_stop_thresold: float = 0.1

onready var moving_entity = $Player
var destination_tile
onready var entity_is_moving: bool = false

onready var entity_origin = moving_entity.get_global_transform().origin
onready var destination_origin = moving_entity.get_global_transform().origin

var path
onready var path_index = 0

func _ready():
	pass


func _process(delta):
	if entity_is_moving: moving_entity(delta)


func play_card(var card_attributes):
	if card_attributes.type == "move":
		$Camera.enable_debug_tile_clicks = true

func start_moving_entity(destTile):
	$Camera.enable_debug_tile_clicks = false
	destination_tile = destTile
	var entity_tile = moving_entity.get_current_tile()
	var entity_tile_origin = entity_tile.get_global_transform().origin
	destination_origin = destTile.get_global_transform().origin
	
	path = $Pathfinder.find_path(entity_tile, destTile)
	entity_is_moving = true

func moving_entity(delta):
	entity_origin = moving_entity.get_global_transform().origin
	var next_tile_origin = path[path_index].get_global_transform().origin
	var offset = next_tile_origin  - entity_origin
	var distance_to_destination = offset.length()
	var move_speed = 500
	moving_entity.move_and_slide(offset.normalized() * move_speed * delta)
	
	if distance_to_destination < movement_stop_thresold:
		#print(path_index < path.size() - 1)
		
		#Switch to next node to move to
		if path_index < path.size() - 1: 
			path_index+=1
		#If last node then :
		else: _done_moving()


func _done_moving():
	$Camera.enable_debug_tile_clicks = false
	$Camera.clear_highlighted_path()
	entity_is_moving = false
	moving_entity.set_global_transform(destination_tile.get_global_transform())
	path = null
	path_index = 0
