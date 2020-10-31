extends Spatial

onready var moving_entity = $Player

func _ready():
	pass


func _process(delta):
	pass
	

func enable_entity_movement_grid():
	print("enable_entity_movement_grid")
	moving_entity.get_current_tile().get_neighbors()
