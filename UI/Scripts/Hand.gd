extends Control


var held_object = null

onready var card = load("res://UI/Card.tscn")
var card_width: float


func _ready():
	var temp_card = card.instance()
	card_width = temp_card.get_size().x
	temp_card.queue_free()
	
	reorganize_hand()
	


func reorganize_hand():
	var cards_in_hand:Array = $Container.get_children()
	var num_of_cards: int = cards_in_hand.size()
	var cards_overlap: float = 0
	
	var container_width: float = get_viewport().size.x
	var all_cards_width : float = card_width * num_of_cards
	var maximum_num_of_cards : float = container_width / card_width
	var middle_of_container = container_width / 2
	var distance_to_cover_to_get_to_middle = middle_of_container - all_cards_width / 2
	print("distance_to_cover_to_get_to_middle bef ",distance_to_cover_to_get_to_middle)
	
	#add - 200 to container_width on the two lines below
	if all_cards_width > container_width :
		var extra_space_needed = all_cards_width - (container_width )
		var middle_of_overlapped_cards = (all_cards_width / 2) - extra_space_needed 
		
		cards_overlap = extra_space_needed / (num_of_cards - 1 )
		distance_to_cover_to_get_to_middle = 0
		
		print("middle_of_overlapped_cards ",middle_of_overlapped_cards ,"middle_of_container ",middle_of_container, " extra_space_needed ",extra_space_needed," cards_overlap ",cards_overlap)
	
	
	for i in cards_in_hand.size():
		var card_position_x = 0
		if i != 0:
			card_position_x = (cards_in_hand[i-1].get_position().x + card_width - cards_overlap) - distance_to_cover_to_get_to_middle
			
		
		cards_in_hand[i].set_position(Vector2((card_position_x) + distance_to_cover_to_get_to_middle      ,0))
		
		
		
		
		
		
		
	
	# center cards
	# make space to display all cards
	
	print("total_hand_width ",num_of_cards)




func _on_Add_Card_Button_pressed():
	var new_card = card.instance()
	$Container.add_child(new_card)
	reorganize_hand()
