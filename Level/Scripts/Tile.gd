extends StaticBody

var neighbours:Array = []
var parent
onready var h_cost = 0
onready var g_cost= 0

func _ready():
	pass

func get_f_cost():
	return h_cost + g_cost

func get_neighbours():
	if neighbours.size() > 0: return neighbours
	else:
		for ray in $Rays.get_children():
			var new_neighbour = get_single_neighbour(ray)
			if new_neighbour: neighbours.append(new_neighbour)
		return neighbours

func get_single_neighbour(var ray):
	if ray.is_colliding(): return ray.get_collider()

