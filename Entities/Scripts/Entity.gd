extends Spatial

onready var game_board = self.get_owner()

export(String,"Enemy", "Player") var type
var current_tile

func _ready():
	if type == "Player":
		#Armature
		var armature = load('res://Entities/Armatures/Player.tscn')
		var armature_instance = armature.instance()
		self.add_child(armature_instance)
		#AnimationPlayer
		var animation_player = load('res://Entities/AnimationPlayers/Player.tscn')
		var animation_player_instance = animation_player.instance()
		self.add_child(animation_player_instance)
		
		game_board.active_entity = self

func get_current_tile():
	if $CurrentTile.is_colliding():
		current_tile = $CurrentTile.get_collider()
		return current_tile
	

