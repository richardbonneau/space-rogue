extends ColorRect


var held_object = null

onready var card = load("res://UI/Card.tscn")
var card_width: float


func _ready():
	var temp_card = card.instance()
	card_width = temp_card.get_size().x
	temp_card.queue_free()
	
	reorganize_hand()
	


func reorganize_hand():
	var cards_in_hand:Array = self.get_children()
	
	var hand_container_width: float = get_viewport().size.x
	var num_of_cards: int = cards_in_hand.size()
	var total_hand_width : float = card_width * num_of_cards
	var maximum_num_of_cards : float = hand_container_width / card_width
	
	
	var middle_of_hand = hand_container_width / 2
	
	for card in cards_in_hand:
		
		card.set_position(Vector2(middle_of_hand - card_width / 2,0))
	
	# center cards
	# make space to display all cards
	
	print("total_hand_width ",num_of_cards)




func _on_Add_Card_Button_pressed():
	var new_card = card.instance()
	self.add_child(new_card)
	reorganize_hand()
