extends Spatial

onready var rounds = self.get_owner().get_node("Rounds")

onready var initiative = 50
export(String,"Enemy", "Player", "Ally") var type
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
	
	if type == "Enemy":
		initiative = 60
		var enemy_ai = load('res://Entities/EnemyAi.tscn')
		var enemy_ai_instance = enemy_ai.instance()
		self.add_child(enemy_ai_instance)
	
	add_to_turn_order()

func _process(delta):
	pass

func get_current_tile():
	if $CurrentTile.is_colliding():
		current_tile = $CurrentTile.get_collider()
		return current_tile

func mark_current_tile_as_occupied():
	self.get_current_tile().taken = true

func free_occupied_tile():
	self.get_current_tile().taken = false

func add_to_turn_order():
	rounds.add_entity_to_list(self)
