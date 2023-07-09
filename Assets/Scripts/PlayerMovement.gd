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
	print("taken hit %s" % hp)

func _on_player_area_area_entered(area):
	if area.get_parent().has_method("hitAttack"):
		takeHit(area.get_parent().hitAttack())
	elif area.get_parent().has_method("targetHit"):
		takeHit(area.get_parent().targetHit())
		
func _input(event):
	if event.is_action("Attack"):
		$wep.attack()
