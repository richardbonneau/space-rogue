extends Node

onready var camera = self.get_parent().get_node("CameraHolder").get_child(0)
onready var player_max_move = 60
onready var player_remaining_move = 60
onready var player_max_cards = 2
onready var player_remaining_cards = 2

func play_card(var card_attributes):
	if card_attributes.type == "move":
		camera.player_select_tile_for_movement = true
