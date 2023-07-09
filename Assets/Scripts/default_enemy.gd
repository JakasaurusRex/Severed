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
@onready var attacK_dist = 50
@onready var hit_damage = 10
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
	if nav_agent.distance_to_target() < attacK_dist:
		state = 2
func attack():
	anim.play('attack')
func recover():
	anim.play('recover')
func updateTarget(pos):
	nav_agent.target_position = pos
func hitAttack():
	return hit_damage
