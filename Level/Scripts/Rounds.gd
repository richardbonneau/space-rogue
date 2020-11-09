extends Node


onready var turn_order = []

func _ready():
	sort_turn_order()
	get_all_entities_turn_order()
	pass

func get_active_entity():
	return turn_order[0]

func add_entity_to_list(var entity):
	turn_order.append(entity)


func sort_turn_order():
	pass
	

func get_all_entities_turn_order():
	for entity in self.get_owner().get_node("Entities").get_children():
		pass
