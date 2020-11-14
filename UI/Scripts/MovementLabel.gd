extends Label

onready var player_actions = get_owner().get_owner().get_node("GameBoard").get_node("PlayerActions")

var remaining_move
var max_move

func _process(_delta):
	if player_actions.player_remaining_move != remaining_move or player_actions.player_max_move != max_move:
		remaining_move = player_actions.player_remaining_move
		max_move = player_actions.player_max_move
		self.set_text(str(remaining_move) + " / "+str(max_move))
