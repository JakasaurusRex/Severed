extends CharacterBody2D


var dir 
var speed = 100
var lifetime = 3
var hit = 25
#var 

func initialize(d, s, l, h):
	dir = d
	speed = s
	lifetime = l
	hit = h

func _ready():
	$timer.start(lifetime)

func _physics_process(delta):
	$spinner.play("spin")
	velocity = dir*speed
	move_and_slide()
	
func _on_timer_timeout():
	queue_free()

func enemyHit():
	queue_free()
	return hit
