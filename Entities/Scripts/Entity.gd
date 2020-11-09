extends Spatial

onready var rounds = self.get_owner().get_node("Rounds")
onready var turn_order = self.get_owner().get_owner().get_node("TurnOrder")

export(String,"Enemy", "Player") var type
var current_tile

func _ready():
	#Armature
	var armature = load('res://Entities/Armatures/'+type+'.tscn')
	var armature_instance = armature.instance()
	self.add_child(armature_instance)
	#AnimationPlayer
	var animation_player = load('res://Entities/AnimationPlayers/'+type+'.tscn')
	var animation_player_instance = animation_player.instance()
	self.add_child(animation_player_instance)
	
	add_to_turn_order()

func get_current_tile():
	if $CurrentTile.is_colliding():
		current_tile = $CurrentTile.get_collider()
		return current_tile
	

func add_to_turn_order():
	rounds.add_entity_to_list(self)
	turn_order.add_portrait_to_turn_order(type)


