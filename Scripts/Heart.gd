extends Area2D

func _on_Heart_body_entered(body):
	if body is Player && GameController.playerHealth < 3:
		GameController.playerHealth += 0.25
		queue_free()
