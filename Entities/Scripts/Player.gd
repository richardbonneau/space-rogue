extends Spatial

var current_tile

func _ready():
	get_current_tile()

func _process(delta):
	pass
	get_current_tile()

func get_current_tile():
	if $Mesh/CurrentTile.is_colliding():
		current_tile = $Mesh/CurrentTile.get_collider()
	
	#print($Mesh/CurrentTile.get_collider().name)
	

