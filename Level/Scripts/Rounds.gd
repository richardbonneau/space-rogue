extends Node


onready var turn_order = []
onready var portrait_order = self.get_owner().get_owner().get_node("PortraitOrder")

func _ready():
	sort_turn_order()
	get_all_entities_turn_order()

func get_active_entity():
	return turn_order[0]

func add_entity_to_list(var entity):
	turn_order.append(entity)

func sort_turn_order():
	pass

func get_all_entities_turn_order():
	for entity in self.get_owner().get_node("Entities").get_children():
		pass

func next_turn():
	var entity_to_push_back = turn_order[0]
	turn_order.erase(entity_to_push_back)
	turn_order.append(entity_to_push_back)
	portrait_order.rearrange_portrait_order()
	
	if turn_order[0].type == "Enemy":
		turn_order[0].get_node("EnemyAi").ai_start_turn()
