extends Area2D

func _on_Key_body_entered(body):
	if body is Player:
		GameController.hasKey = true
		queue_free()
