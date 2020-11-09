extends Control

onready var alien 
onready var scientist 

export var active_entity_size = 60
export var inactive_entities_size = 80

var portrait

# Called when the node enters the scene tree for the first time.
func _ready():
	change_boxes_size()
	

func add_portrait_to_turn_order(var type):
	if !portrait: portrait = load('res://UI/TurnOrderPortrait.tscn')
	if !alien: alien = load('res://Assets/Sprites/Alien.png')
	if !scientist: scientist = load('res://Assets/Sprites/Scientist.png')
	
	var portrait_instance = portrait.instance()
	var image
	
	if type == "Player": image = alien
	elif type == "Enemy": image = scientist
	
	portrait_instance.set_texture(image)
	self.add_child(portrait_instance)
	change_boxes_size()
	

func change_boxes_size():
	var entities_on_game_board = self.get_children()
	for i in entities_on_game_board.size():
		if i == 0:
			entities_on_game_board[i].set_custom_minimum_size(Vector2(inactive_entities_size,inactive_entities_size))
		else:
			entities_on_game_board[i].set_custom_minimum_size(Vector2(active_entity_size,active_entity_size))

