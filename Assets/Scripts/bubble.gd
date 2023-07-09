extends CharacterBody2D

var dir 
var speed = 100
var lifetime = 3
var hit = 10
#var 

func initialize(pos, d, s, l, h):
	position = pos
	dir = d
	speed = s
	lifetime = l
	hit = h

func _ready():
	$timer.start(lifetime)

func _physics_process(delta):
	velocity = dir*speed
	move_and_slide()
	
func _on_timer_timeout():
	queue_free()

func targetHit():
	queue_free()
	return hit
