extends Control

export var active_entity_size = 60
export var inactive_entities_size = 80


# Called when the node enters the scene tree for the first time.
func _ready():
	change_boxes_size()


func change_boxes_size():
	var entities_on_game_board = self.get_children()
	for i in entities_on_game_board.size():
		if i == 0:
			entities_on_game_board[i].set_custom_minimum_size(Vector2(inactive_entities_size,inactive_entities_size))
		else:
			entities_on_game_board[i].set_custom_minimum_size(Vector2(active_entity_size,active_entity_size))

