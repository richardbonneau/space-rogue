extends Spatial

var current_tile

func _ready():
	get_current_tile()



func get_current_tile():
	if $Mesh/CurrentTile.is_colliding():
		current_tile = $Mesh/CurrentTile.get_collider()
		return current_tile
	
	#print($Mesh/CurrentTile.get_collider().name)
	

