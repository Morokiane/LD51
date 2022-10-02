extends Area2D

func _on_Respawn_body_entered(body):
	if body is Player:
		GameController.lastPosition = body.position
