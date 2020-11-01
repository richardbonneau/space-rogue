extends Node

func _ready():
	pass 

func get_distance(var tile_a, var tile_b):
	#Get H value
	var dst_x = abs(tile_a.x - tile_b.x)
	var dst_z = abs(tile_a.z - tile_b.z)
	print(" tile_a.x ",tile_a," tile_b ",tile_b)
	
	if dst_x > dst_z:
		return 14 * dst_z + 10 * (dst_x - dst_z)
	else:
		return 14 * dst_x + 10 * (dst_z - dst_x)

func find_path(var start_tile, var dest_tile):
	var open_nodes:Array = []
	var closed_nodes:Array = []
	open_nodes.append(start_tile)
	
	while(open_nodes.size() > 0):
		var lowest_cost_node = open_nodes[0]
		for node in open_nodes:
			if node.f_cost <= lowest_cost_node.f_cost and node.h_cost < lowest_cost_node.h_cost:
				lowest_cost_node = node
		
		open_nodes.erase(lowest_cost_node)
		closed_nodes.append(lowest_cost_node)
		
		if lowest_cost_node == dest_tile:
			var path:Array = []
			var current_node = dest_tile
			while current_node != start_tile:
				path.append(current_node)
				current_node = current_node.parent
				path.invert()
				return path
		
		var neighbours = lowest_cost_node.get_neighbours()
		for neighbour in neighbours:
			if closed_nodes.has(neighbour): continue
			
			var new_cost_to_neighbour = lowest_cost_node.g_cost + get_distance(lowest_cost_node,neighbour)
			var open_nodes_contains_neighbour = open_nodes.has(neighbour)
			
			if new_cost_to_neighbour < neighbour.g_cost or !open_nodes_contains_neighbour:
				neighbour.g_cost = new_cost_to_neighbour
				neighbour.h_cost = get_distance(neighbour, dest_tile)
				neighbour.parent = lowest_cost_node
				
				if !open_nodes_contains_neighbour:
					open_nodes.append(neighbour)
	return []

