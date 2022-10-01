extends Node2D

func _ready():
	$anim.play("active")
	yield(get_node("anim"), "animation_finished")
	queue_free()
