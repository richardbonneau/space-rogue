extends StaticBody

onready var neighbors = []

func _ready():
	pass




func logic():
	if self.neighbors.empty():
		get_neighbors()

func get_neighbors():
	get_single_neighbor($Rays/North)
	get_single_neighbor($Rays/South)
	get_single_neighbor($Rays/East)
	get_single_neighbor($Rays/West)


func get_single_neighbor(var ray):
	if ray.is_colliding(): 
		var collider = ray.get_collider()
		self.neighbors.append(collider)
		collider.get_node("Highlight").visible = true
	
