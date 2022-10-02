extends Node2D

func _ready():
	$anim.play("active")
	$BreakFX.play()
	yield(get_node("anim"), "animation_finished")
	queue_free()
