extends Spatial

var current_tile

func _ready():
	pass


func get_current_tile():
	if $CurrentTile.is_colliding():
		current_tile = $CurrentTile.get_collider()
		print(current_tile)
		return current_tile
	

