extends Control

export var active_entity_size = 60
export var inactive_entities_size = 80

var portrait

# Called when the node enters the scene tree for the first time.
func _ready():
	change_boxes_size()
	

func add_entity_to_list(var type):
	if !portrait: portrait = load('res://UI/TurnOrderPortrait.tscn')
	var portrait_instance = portrait.instance()
	var image
	
	if type == "Player": image = load('res://Assets/Sprites/Alien.png')
	elif type == "Enemy": image = load('res://Assets/Sprites/Scientist.png')
	
	portrait_instance.set_texture(image)
	self.add_child(portrait_instance)

func change_boxes_size():
	var entities_on_game_board = self.get_children()
	for i in entities_on_game_board.size():
		if i == 0:
			entities_on_game_board[i].set_custom_minimum_size(Vector2(inactive_entities_size,inactive_entities_size))
		else:
			entities_on_game_board[i].set_custom_minimum_size(Vector2(active_entity_size,active_entity_size))

