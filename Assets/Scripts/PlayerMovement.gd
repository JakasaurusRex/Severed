extends CharacterBody2D

@export var speed = 300
@onready var hp = 200
var pickup = 0
@onready var cyclone = preload("res://Assets/Scenes/cyclone.tscn")
@onready var currentPowers = ["cyclone"]

func get_input():
	var input_direction = Input.get_vector("a", "d", "w", "s")
	if(input_direction == Vector2.ZERO):
		velocity = 0.70 * velocity
		pickup = 0
	else:
		velocity = input_direction.normalized() * speed * pickup/100
		if(pickup + 33 < 100):
			pickup += 33

func _physics_process(delta):
	get_input()
	move_and_slide()
	
func takeHit(hit_damage):
	hp -= hit_damage
	print("taken hit %s" % hp)

func _on_player_area_area_entered(area):
	if area.get_parent().has_method("hitAttack"):
		takeHit(area.get_parent().hitAttack())
	elif area.get_parent().has_method("targetHit"):
		takeHit(area.get_parent().targetHit())
		
func _input(event):
	if event.is_action("Attack"):
		print("ATTACKACTIOn")
		$wep.attack()
	elif event.is_action("Ability 1"):
		if(currentPowers.has("cyclone") and $AbilityTimer.is_stopped()):
			shootCyclone()
			$AbilityTimer.start(5)
			$AbilityTimer.one_shot = true


func shootCyclone():
	var new_cyclone = cyclone.instantiate()
	new_cyclone.initialize(position, (get_global_mouse_position() - position).normalized(), 100, 5, 20)
	get_parent().add_child(new_cyclone)
