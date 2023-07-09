extends "res://Assets/Scripts/default_enemy.gd"

@onready var bubble = preload("res://Assets/Scenes/bubble.tscn")
@onready var num_bubs = 3
@onready var shoot_angle = 30
func _ready():
	trigger_dist = 500
	attack_dist = 300
	hit_damage = 10
	
func shootBubbles():
	for x in range(num_bubs):
		var new_bubble = bubble.instantiate()
		var bub_angle = shoot_angle * (num_bubs/2 - x) 
		print(bub_angle)
		bub_angle = deg_to_rad(bub_angle)
		
		var bub_dir = (nav_agent.target_position - position)
		new_bubble.initialize(bub_dir.rotated(bub_angle).normalized(), 100, 2, hit_damage)
		add_child(new_bubble)


