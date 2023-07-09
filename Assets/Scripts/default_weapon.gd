extends Node2D

@export var state = 0 #IDLE - 0, ATTACKING - 1
@export var attack_angle = -45
@export var attack_start_angle = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(attack_start_angle)
	match state:
		0: idle() #IDLE
		1: attack()
		2: recover()
	pass
	
func idle():
	look_at(get_global_mouse_position())
	
func attack():
	#print("%s,%s" % [attack_start_angle, attack_angle])
	if state == 0:
		setAttackAngle()
	$weaponAnim.play('attack')
	rotation = deg_to_rad(attack_start_angle + attack_angle)
	#print(rotation)
func recover():
	$weaponAnim.play('recover')
func _input(event):
	if event.is_action("Attack") and state == 0:
		print("ATTACK STARTED")
		attack()
		state = 1
		
func setAttackAngle():
	attack_start_angle = rad_to_deg((get_global_mouse_position()-global_position).angle())
	