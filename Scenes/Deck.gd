extends HBoxContainer



func _ready():
	fanCards()

func fanCards():
	for card in self.get_children():
		print(card.get_size())
		card.set_size(Vector2(100,100))
		print(card.get_size())
