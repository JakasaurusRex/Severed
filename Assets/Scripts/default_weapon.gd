extends Node2D

@export var state = 0 #IDLE - 0, ATTACKING - 1, RECOVER - 2
@export var attack_angle = -45
@export var attack_start_angle = 0
@onready var damage = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(state)
	#print(attack_start_angle)
	match state:
		0: idle() #IDLE
		1: attack()
		2: recover()
	pass
	
func idle():
	look_at(get_global_mouse_position())
	$weaponAnim.play('idle')
func attack():
	
	#print("%s,%s" % [attack_start_angle, attack_angle])
	if state == 0:
		state = 1
		setAttackAngle()
		$weaponAnim.play('attack')
	rotation = deg_to_rad(attack_start_angle + attack_angle)
func recover():
	look_at(get_global_mouse_position())
	$weaponAnim.play("recover")
func setAttackAngle():
	attack_start_angle = rad_to_deg((get_global_mouse_position()-global_position).angle())
	print(attack_start_angle)
	
func enemyHit():
	return damage
	
