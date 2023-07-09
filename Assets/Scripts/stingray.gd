extends "res://Assets/Scripts/default_enemy.gd"

@onready var bubble = preload("res://Assets/Scenes/bubble.tscn")
@onready var num_bubs = 3
@onready var shoot_angle = 30
@export var position1: Vector2
@export var position2: Vector2
@onready var target_pos: Vector2

func _ready():
	hit_damage = 20
	state = 1
	target_pos = position2
	
	var tween := create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	var target_rot := global_position.direction_to(target_pos).angle() + PI/2
	tween.tween_property(self, "rotation", target_rot, (rotation - global_position.direction_to(target_pos).angle())/5)
	
func _enter_tree():
	add_to_group("pathed_enemy")
	
func seek():
	$enemyAnim.play('attack')
	var tween := create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", target_pos, target_pos.distance_to(position)/5)
	
	if(target_pos.distance_to(position) <= 25):
		if(target_pos == position1):
			target_pos = position2
			var target_rot := global_position.direction_to(target_pos).angle() + PI/2
			tween.parallel().tween_property(self, "rotation", target_rot, (rotation - global_position.direction_to(target_pos).angle())/5)
		else:
			target_pos = position1
			var target_rot := global_position.direction_to(target_pos).angle() + PI/2
			tween.parallel().tween_property(self, "rotation", target_rot, (rotation - global_position.direction_to(target_pos).angle())/5)

	
	
	

