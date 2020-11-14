extends Control

var dependencies_gotten = false

export var active_entity_size = 60
export var inactive_entities_size = 80

onready var rounds = self.get_owner().get_node("GameBoard").get_node("Rounds")
onready var portrait = load('res://UI/Portrait.tscn')
onready var alien  = load('res://Assets/Sprites/alien.png')
onready var scientist  = load('res://Assets/Sprites/scientist.png')
onready var bot  = load('res://Assets/Sprites/bot.png')

func rearrange_portrait_order():
	for child in self.get_children():
		self.remove_child(child)
		child.queue_free()
	
	var all_entities = rounds.turn_order
	for entity in all_entities:
		add_portrait_to_turn_order(entity.type)
	
	change_boxes_size()


func add_portrait_to_turn_order(var type):
	var portrait_instance = portrait.instance()
	var image
	
	if type == "Player": image = alien
	elif type == "Enemy": image = scientist
	elif type == "Ally": image = bot
	
	portrait_instance.set_texture(image)
	self.add_child(portrait_instance)


func remove_portrait_from_turn_order():
	#TODO: when an entity dies, remove it from the portraits
	pass

func change_boxes_size():
	var all_portraits = self.get_children()
	for i in all_portraits.size():
		if i == 0:
			all_portraits[i].set_custom_minimum_size(Vector2(inactive_entities_size,inactive_entities_size))
		else:
			all_portraits[i].set_custom_minimum_size(Vector2(active_entity_size,active_entity_size))

