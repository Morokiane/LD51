extends Area2D

onready var pot = preload("res://Assets/PotFX.tscn")

func _on_Pot2_area_entered(area):
	if area.is_in_group("swing"):
		var potFX = pot.instance()
		get_parent().add_child(potFX)
		potFX.global_position = global_position
		queue_free()
