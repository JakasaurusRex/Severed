extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_broad_cast_timer_timeout():
	for dude in get_tree().get_nodes_in_group("seeking_enemy"):
		dude.updateTarget($Player.position)
