extends Node

func _ready():
	pass 

func get_movement_cost_to_destination(var tile_a, var tile_b):
	#Get H value
	var dst_x = abs(tile_a.x - tile_b.x)
	var dst_z = abs(tile_a.z - tile_b.z)
	print(" tile_a.x ",tile_a," tile_b ",tile_b)
	
	if dst_x > dst_z:
		return 14 * dst_z + 10 * (dst_x - dst_z)
	else:
		return 14 * dst_x + 10 * (dst_z - dst_x)

func FindPath(var start):
	pass
	


