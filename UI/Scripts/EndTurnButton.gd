extends Button

onready var rounds = self.get_owner().get_owner().get_node("GameBoard").get_node("Rounds")

func _on_pressed():
	rounds.next_turn()
