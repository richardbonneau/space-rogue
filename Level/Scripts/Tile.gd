extends StaticBody

onready var neighbors = []

func _ready():
	pass
	#print("above", $Rays/Above.get_collider())



func logic():
	if self.neighbors.empty():
		get_neighbors()

func get_neighbors():
	get_single_neighbor($Rays/North)
	get_single_neighbor($Rays/South)
	get_single_neighbor($Rays/East)
	get_single_neighbor($Rays/West)
	print(neighbors)
	

func get_single_neighbor(var ray):
	if ray.is_colliding(): 
		self.neighbors.append(ray.get_collider())
	
