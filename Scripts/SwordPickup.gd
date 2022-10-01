extends Area2D

func _on_Sword_body_entered(body):
	if body is Player:
		GameController.hasSword = true
		queue_free()
