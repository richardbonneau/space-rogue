extends HBoxContainer


var held_object = null

onready var card = load("res://Deck/Card.tscn")
onready var hand_width: float = get_viewport().size.x
var card_width: float


func _ready():
	
	var temp_card = card.instance()
	card_width = temp_card.get_size().x
	temp_card.queue_free()
	
	reorganize()


func reorganize():
	var cards_in_hand:Array = self.get_children()
	var num_of_cards: int = cards_in_hand.size()
	var maximum_num_of_cards : int = floor(hand_width / card_width)
	
	for card in cards_in_hand:
		print(maximum_num_of_cards)
		pass
		
