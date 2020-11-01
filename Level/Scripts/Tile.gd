extends StaticBody

var parent
var h_cost
var g_cost



func _ready():
	pass
	

func get_f_cost():
	return h_cost + g_cost

func logic():
	if self.neighbours.empty():
		get_neighbours()

func get_neighbours():
	var neighbours:Array = []
	neighbours.append(get_single_neighbour($Rays/North))
	neighbours.append(get_single_neighbour($Rays/South))
	neighbours.append(get_single_neighbour($Rays/East))
	neighbours.append(get_single_neighbour($Rays/West))
	return neighbours


func get_single_neighbour(var ray):
	if ray.is_colliding(): 
		var collider = ray.get_collider()
		return collider
		#collider.get_node("Highlight").visible = true
	
