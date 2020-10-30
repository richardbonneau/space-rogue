extends HBoxContainer


var held_object = null

onready var card = load("res://Deck/Card.tscn")
onready var hand_container_width: float = get_viewport().size.x
var card_width: float

var scrollbar : HScrollBar 
var scroll_container : ScrollContainer

func _ready():
	scrollbar = self.get_owner().get_node("./HScrollBar")
	scroll_container = self.get_owner().get_node("./ScrollContainer")
	print("scrollbar",scrollbar)
	var temp_card = card.instance()
	card_width = temp_card.get_size().x
	temp_card.queue_free()
	
	reorganize_scroll_hand()
	


func reorganize_scroll_hand():
	var cards_in_hand:Array = self.get_children()
	var num_of_cards: int = cards_in_hand.size()
	var total_hand_width : float = card_width * num_of_cards
	var maximum_num_of_cards : float = hand_container_width / card_width
	
	#scrollbar.set_max(total_hand_width)
	#scrollbar.set_page(hand_container_width)
	print("total_hand_width ",num_of_cards)



func _on_HScrollBar_value_changed(value):
	scroll_container.scroll_horizontal = value
