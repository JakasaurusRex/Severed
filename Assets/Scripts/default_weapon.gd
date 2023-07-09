extends Node2D

@export var state = 0 #IDLE - 0, ATTACKING - 1
@export var attack_angle = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		0: idle() #IDLE
		1: attack()
	pass
	
func idle():
	look_at(get_global_mouse_position())
func attack():
	rotation = (get_global_mouse_position()-position).normalized().angle()
	$weaponAnim.play('attack')

func _input(event):
	if event.is_action("Attack") and state == 0:
		attack()
