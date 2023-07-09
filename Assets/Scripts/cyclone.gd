extends CharacterBody2D


var dir 
var speed = 100
var lifetime = 5
var hit = 25
#var 

func initialize(pos, d, s, l, h):
	position = pos
	dir = d
	speed = s
	lifetime = l
	hit = h

func _ready():
	$Timer.start(lifetime)

func _physics_process(delta):
	$spinner.play("spin")
	velocity = dir*speed
	move_and_slide()
	
func _on_timer_timeout():
	queue_free()

func enemyHit():
	$Timer.start(2)
	return hit

func drag():
	pass
