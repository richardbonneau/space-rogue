extends Label

onready var player_actions = get_owner().get_owner().get_node("GameBoard").get_node("PlayerActions")

var remaining_cards
var max_cards

func _process(delta):
	if player_actions.player_remaining_cards != remaining_cards or player_actions.player_max_cards != max_cards:
		remaining_cards = player_actions.player_remaining_cards
		max_cards = player_actions.player_max_cards
		self.set_text(str(remaining_cards) + " / "+str(max_cards))
