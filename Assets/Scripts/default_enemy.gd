extends CharacterBody2D

class_name defaultEnemy
@onready var speed = 100
@onready var enemy_loc 
@export var state := 0 as int #0-IDLE,1-SEEK,2-ATTACK,3-RECOVER
@onready var attacking = false
@onready var nav_agent = $enemyNav as NavigationAgent2D
@onready var sprite = $enemySprite
@onready var anim = $enemyAnim
@onready var trigger_dist = 300
@onready var attack_dist = 75
@onready var hit_damage = 10
@onready var hp = 50
@onready var drag = 2000
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _enter_tree():
	add_to_group("seeking_enemy")

func _physics_process(delta):
	match state:
		0: idle() #IDLE
		1: seek() #SEEK 
		2: attack() #ATTACK
		3: recover() #RECOVER
	
	if velocity.x < 0:
		sprite.flip_h = true
		$hitbox.position.x = -40
	else:
		sprite.flip_h = false
		$hitbox.position.x = 40
	
func idle():
	if nav_agent.distance_to_target() < trigger_dist:
		state = 1
func seek():
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	if nav_agent.distance_to_target() < attack_dist:
		state = 2
func attack():
	anim.play('attack')
func recover():
	anim.play('recover')
func updateTarget(pos):
	nav_agent.target_position = pos
func hitAttack():
	return hit_damage


func _on_enemy_hurt_area_entered(area):
	print("IN BROADCAST")
	var parent = area.get_parent()
	hp -= parent.enemyHit()
	if(parent.has_method("drag")):
		velocity += (parent.position - position).normalized() * drag
		print(velocity)
	print("hp = " + str(hp))
	if(hp <= 0):
		queue_free()
	
