extends Node

onready var turn_order = []
onready var portrait_order = self.get_owner().get_owner().get_node("PortraitOrder")
onready var entities = self.get_owner().get_node("Entities")
onready var camera = self.get_owner().get_node("CameraHolder").get_child(0)
onready var player_actions = self.get_owner().get_node("PlayerActions")

onready var initial_tile_check = false

class MyCustomSorter:
	static func custom_sorter(a,b):
		if a.initiative < b.initiative:
			return true
		else : return false

func _ready():
	#get_all_entities_turn_order()
	pass

func _process(delta):
	if !initial_tile_check:
		for entity in entities.get_children():
			entity.mark_current_tile_as_occupied()
		initial_tile_check = true

func get_active_entity():
	return turn_order[0]

func add_entity_to_list(var entity):
	turn_order.append(entity)

func sort_turn_order():
	print("bef ",turn_order)
	turn_order.sort_custom(MyCustomSorter,"custom_sorter")
	print("aft " , turn_order)

func get_all_entities_turn_order():
	for entity in entities.get_children():
		print("rounds ",entity.get_current_tile())

func next_turn():
	var entity_to_push_back = turn_order[0]
	turn_order.erase(entity_to_push_back)
	turn_order.append(entity_to_push_back)
	portrait_order.rearrange_portrait_order()
	
	if turn_order[0].type == "Player":
		camera.player_select_tile_for_movement = true
		player_actions.player_remaining_move = player_actions.player_max_move
	elif turn_order[0].type == "Enemy":
		turn_order[0].get_node("EnemyAi").ai_start_turn()
