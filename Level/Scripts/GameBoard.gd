extends Spatial

export var movement_stop_thresold: float = 0.1

onready var moving_entity = $Player
onready var entity_is_moving: bool = false
var destination_origin

func _ready():
	pass


func _process(delta):
	if entity_is_moving:
		var entity_origin = moving_entity.get_global_transform().origin
		var offset = destination_origin-entity_origin
		var distance_to_destination = offset.length()
		
		var move_speed = 100
		
		moving_entity.move_and_slide(offset.normalized() * move_speed * delta)
		print(distance_to_destination)
		if distance_to_destination < movement_stop_thresold:
			entity_is_moving = false
			#switch to next node to move to
	

func play_card(var card_attributes):
	if card_attributes.type == "move":
		_enable_entity_movement_grid()

func _enable_entity_movement_grid():
	print("enable_entity_movement_grid")
	#moving_entity.get_current_tile().get_neighbors()
	entity_is_moving = true
