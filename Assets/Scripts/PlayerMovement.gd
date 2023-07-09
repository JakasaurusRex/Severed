extends CharacterBody2D

@export var speed = 300
@onready var hp = 200
var pickup = 0

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
	print("taken hit")

