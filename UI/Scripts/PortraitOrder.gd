extends Control

var dependencies_gotten = false

export var active_entity_size = 60
export var inactive_entities_size = 80

var rounds
var portrait
var alien 
var scientist 

func get_dependencies():
	if !dependencies_gotten:
		if !rounds: rounds = self.get_owner().get_node("GameBoard").get_node("Rounds")
		if !portrait: portrait = load('res://UI/Portrait.tscn')
		if !alien: alien = load('res://Assets/Sprites/Alien.png')
		if !scientist: scientist = load('res://Assets/Sprites/Scientist.png')
		dependencies_gotten = true

func _ready():
	get_dependencies()
	change_boxes_size()
	

func rearrange_portrait_order():
	get_dependencies()
	for child in self.get_children():
		print("removing")
		child.queue_free()
	
	var all_entities = rounds.turn_order
	for entity in all_entities:
		add_portrait_to_turn_order(entity.type)
	
	change_boxes_size()
	print("----")

func add_portrait_to_turn_order(var type):
	var portrait_instance = portrait.instance()
	var image
	
	if type == "Player": image = alien
	elif type == "Enemy": image = scientist
	
	portrait_instance.set_texture(image)
	self.add_child(portrait_instance)
	print("adding ")




func remove_portrait_from_turn_order():
	#TODO:
	pass

func change_boxes_size():
	var all_portraits = self.get_children()
	for i in all_portraits.size():
		print("all_portraits[i] ",all_portraits[i])
		if i == 0:
			all_portraits[i].set_custom_minimum_size(Vector2(inactive_entities_size,inactive_entities_size))
		else:
			all_portraits[i].set_custom_minimum_size(Vector2(active_entity_size,active_entity_size))

