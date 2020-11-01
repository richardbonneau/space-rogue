extends Spatial

export var movement_stop_thresold: float = 0.1

onready var moving_entity = $Player
var destination_tile
onready var entity_is_moving: bool = false

onready var entity_origin = moving_entity.get_global_transform().origin
onready var destination_origin = moving_entity.get_global_transform().origin


func _ready():
	pass


func _process(delta):
	if entity_is_moving:
		entity_origin = moving_entity.get_global_transform().origin
		var offset = destination_origin - entity_origin
		var distance_to_destination = offset.length()
		
		var move_speed = 500
		moving_entity.move_and_slide(offset.normalized() * move_speed * delta)
		
		if distance_to_destination < movement_stop_thresold:
			#Switch to next node to move to
			#If last node then :
			moving_entity.set_global_transform(destination_tile.get_global_transform()) 
			_done_moving()
			print("miaow ",moving_entity.get_global_transform().origin)


func play_card(var card_attributes):
	if card_attributes.type == "move":
		$Camera.enable_debug_tile_clicks = true

func start_moving_entity(destTile):
	destination_tile = destTile
	var entity_tile_origin = moving_entity.get_current_tile().get_global_transform().origin
	destination_origin = destTile.get_global_transform().origin
	
	print($Pathfinder.get_movement_cost_to_destination(entity_tile_origin, destination_origin))
	entity_is_moving = true

func _done_moving():
	$Camera.enable_debug_tile_clicks = false
	entity_is_moving = false
